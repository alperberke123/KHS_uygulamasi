import 'package:flutter/material.dart';
import 'package:ksh_uygulamasi/SuggestionsPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DepressionQuiz extends StatefulWidget {
  const DepressionQuiz({Key? key}) : super(key: key);

  @override
  _DepressionQuizState createState() => _DepressionQuizState();
}

class _DepressionQuizState extends State<DepressionQuiz> {
  final List<int?> scores =
      List<int?>.filled(21, null); // Değerler başlangıçta null

  void _calculateTotalScore(BuildContext context) {
    if (scores.contains(null)) {
      // Eğer herhangi bir soru yanıtlanmadıysa uyarı göster
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Lütfen tüm soruları cevaplayınız."),
        ),
      );
      return;
    }

    // Tüm sorular yanıtlandıysa puanı hesapla ve sonucu göster
    int totalScore = scores
        .where((score) => score != null)
        .fold(0, (total, score) => total + (score ?? 0));
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizResultPage(totalScore: totalScore),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Depresyon Testi'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: quizQuestions.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      quizQuestions[index]['question']!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ...List.generate(4, (optionIndex) {
                      return RadioListTile<int>(
                        title:
                            Text(quizQuestions[index]['options']![optionIndex]),
                        value: optionIndex,
                        groupValue: scores[index],
                        onChanged: (value) {
                          setState(() {
                            scores[index] = value;
                          });
                        },
                      );
                    }),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _calculateTotalScore(context),
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}

class QuizResultPage extends StatefulWidget {
  final int totalScore;

  const QuizResultPage({Key? key, required this.totalScore}) : super(key: key);

  @override
  _QuizResultPageState createState() => _QuizResultPageState();
}

class _QuizResultPageState extends State<QuizResultPage> {
  bool _isSaving = false;
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    _saveTestResult();
  }

  String getResultMessage() {
    if (widget.totalScore <= 9) {
      return "Depresyon belirtileri göstermiyorsunuz.";
    } else if (widget.totalScore <= 16) {
      return "Hafif depresyon belirtileriniz olabilir.";
    } else if (widget.totalScore <= 29) {
      return "Orta derecede depresyon belirtileriniz var.";
    } else {
      return "Şiddetli depresyon belirtileriniz var. Profesyonel destek almanız önerilir.";
    }
  }

  String getResultCategory() {
    if (widget.totalScore <= 9) {
      return "Normal";
    } else if (widget.totalScore <= 16) {
      return "Hafif Depresyon";
    } else if (widget.totalScore <= 29) {
      return "Orta Depresyon";
    } else {
      return "Şiddetli Depresyon";
    }
  }

  Future<void> _saveTestResult() async {
    setState(() {
      _isSaving = true;
    });

    try {
      final User? user = FirebaseAuth.instance.currentUser;
      
      if (user != null) {
        // Firestore'a test sonucunu kaydet
        await FirebaseFirestore.instance
            .collection('depression_test_results')
            .add({
          'userId': user.uid,
          'totalScore': widget.totalScore,
          'resultCategory': getResultCategory(),
          'resultMessage': getResultMessage(),
          'testDate': FieldValue.serverTimestamp(),
          'createdAt': DateTime.now().toIso8601String(),
        });

        // Kullanıcının genel test geçmişine de ekle
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('test_history')
            .add({
          'testType': 'Depression Test',
          'score': widget.totalScore,
          'category': getResultCategory(),
          'completedAt': FieldValue.serverTimestamp(),
        });

        setState(() {
          _isSaved = true;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Test sonucu başarıyla kaydedildi!'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        }
      } else {
        // Kullanıcı giriş yapmamışsa anonymous olarak kaydet
        await FirebaseFirestore.instance
            .collection('anonymous_depression_test_results')
            .add({
          'totalScore': widget.totalScore,
          'resultCategory': getResultCategory(),
          'resultMessage': getResultMessage(),
          'testDate': FieldValue.serverTimestamp(),
          'createdAt': DateTime.now().toIso8601String(),
        });

        setState(() {
          _isSaved = true;
        });
      }
    } catch (e) {
      print('Test sonucu kaydedilirken hata: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Test sonucu kaydedilirken bir hata oluştu.'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      }
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Sonucu'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (_isSaving)
                const Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 10),
                    Text('Test sonucu kaydediliyor...'),
                    SizedBox(height: 20),
                  ],
                ),
              if (_isSaved && !_isSaving)
                const Column(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 30,
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Test sonucu kaydedildi!',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              Text(
                'Toplam Puanınız: ${widget.totalScore}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: _getScoreColor().withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _getScoreColor()),
                ),
                child: Text(
                  getResultCategory(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _getScoreColor(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                getResultMessage(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.blueGrey,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.home),
                    label: const Text('Ana Sayfa'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[600],
                      foregroundColor: Colors.white,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Belgeyi gösteren sayfaya yönlendirme
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const SuggestionsPage(), // Yeni öneri sayfasına yönlendirme
                        ),
                      );
                    },
                    icon: const Icon(Icons.psychology),
                    label: const Text('Öneriler'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (widget.totalScore > 16)
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.orange),
                  ),
                  child: const Column(
                    children: [
                      Icon(
                        Icons.info,
                        color: Colors.orange,
                        size: 24,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Önemli Not: Bu test sonuçları sadece bilgilendirme amaçlıdır. Profesyonel bir değerlendirme için mutlaka bir uzmana başvurunuz.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.orange,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getScoreColor() {
    if (widget.totalScore <= 9) {
      return Colors.green;
    } else if (widget.totalScore <= 16) {
      return Colors.orange;
    } else if (widget.totalScore <= 29) {
      return Colors.red;
    } else {
      return Colors.red[900]!;
    }
  }
}

final List<Map<String, dynamic>> quizQuestions = [
  {
    "question": "Üzgün ve sıkıntılı mısınız?",
    "options": [
      "Üzgün ve sıkıntılı değilim.",
      "Kendimi üzüntülü ve sıkıntılı hissediyorum.",
      "Hep üzüntülü ve sıkıntılıyım. Bundan kurtulamıyorum.",
      "O kadar üzgün ve sıkıntılıyım ki, artık dayanamıyorum."
    ],
  },
  {
    "question": "Başkalarıyla görüşme, konuşma isteğinizi kaybettiniz mi?",
    "options": [
      "Başkalarıyla görüşme, konuşma isteğimi kaybetmedim.",
      "Eskisi kadar insanlarla birlikte olmak istemiyorum.",
      "Birileriyle görüşüp konuşmak hiç içimden gelmiyor.",
      "Artık çevremde hiç kimseyi istemiyorum."
    ],
  },
  {
    "question": "Gelecek hakkında ne düşünüyorsunuz?",
    "options": [
      "Gelecek hakkında umutsuz ve karamsar değilim.",
      "Gelecek için karamsarım.",
      "Gelecekten beklediğim hiçbir şey yok.",
      "Gelecek hakkında umutsuzum ve sanki hiçbir şey düzelmeyecekmiş gibi geliyor."
    ],
  },
  {
    "question": "Karar vermekte güçlük çekiyor musunuz?",
    "options": [
      "Karar verirken eskisinden fazla güçlük çekmiyorum.",
      "Eskiden olduğu kadar kolay karar veremiyorum.",
      "Eskiye kıyasla karar vermekte çok güçlük çekiyorum.",
      "Artık hiçbir konuda karar veremiyorum."
    ],
  },
  {
    "question": "Kendinizi başarısız biri olarak görüyor musunuz?",
    "options": [
      "Kendimi başarısız biri olarak görmüyorum.",
      "Başkalarından daha başarısız olduğumu hissediyorum.",
      "Geçmişe baktığımda başarısızlıklarla dolu olduğunu görüyorum.",
      "Kendimi tümüyle başarısız bir insan olarak görüyorum."
    ],
  },
  {
    "question": "Her zamankinden farklı göründüğünüzü düşünüyor musunuz?",
    "options": [
      "Her zamankinden farklı göründüğümü sanmıyorum.",
      "Aynada kendime her zamankinden kötü görünüyorum.",
      "Aynaya baktığımda kendimi yaşlanmış ve çirkinleşmiş buluyorum.",
      "Kendimi çok çirkin buluyorum."
    ],
  },
  {
    "question": "Her şeyden eskisi kadar zevk alıyor musunuz?",
    "options": [
      "Her şeyden eskisi kadar zevk alıyorum.",
      "Birçok şeyden eskiden olduğu gibi zevk alamıyorum.",
      "Artık hiçbir şey bana tam anlamıyla zevk vermiyor.",
      "Her şeyden sıkılıyorum."
    ],
  },
  {
    "question": "İşlerinizi eskisi gibi yapabiliyor musunuz?",
    "options": [
      "Eskisi kadar iyi iş güç yapabiliyorum.",
      "Her zaman yaptığım işler şimdi gözümde büyüyor.",
      "Ufacık bir işi bile kendimi çok zorlayarak yapabiliyorum.",
      "Artık hiçbir iş yapamıyorum."
    ],
  },
  {
    "question": "Kendinizi suçlu hissediyor musunuz?",
    "options": [
      "Kendimi herhangi bir biçimde suçlu hissetmiyorum.",
      "Kendimi zaman zaman suçlu hissediyorum.",
      "Çoğu zaman kendimi suçlu hissediyorum.",
      "Kendimi her zaman suçlu hissediyorum."
    ],
  },
  {
    "question": "Uykunuz nasıl?",
    "options": [
      "Uykum her zamanki gibi.",
      "Eskisi gibi uyuyamıyorum.",
      "Her zamankinden 1-2 saat önce uyanıyorum ve kolay kolay tekrar uykuya dalamıyorum.",
      "Sabahları çok erken uyanıyorum ve bir daha uyuyamıyorum."
    ],
  },
  {
    "question": "Kendinizden memnun musunuz?",
    "options": [
      "Kendimden memnunum.",
      "Kendimden pek memnun değilim.",
      "Kendime kızgınım.",
      "Kendimden nefret ediyorum."
    ],
  },
  {
    "question": "Ne sıklıkla yorgun hissediyorsunuz?",
    "options": [
      "Kendimi her zamankinden yorgun hissetmiyorum.",
      "Eskiye oranla daha çabuk yoruluyorum.",
      "Her şey beni yoruyor.",
      "Kendimi hiçbir şey yapamayacak kadar yorgun ve bitkin hissediyorum."
    ],
  },
  {
    "question": "Başkalarından daha kötü olduğunuzu düşünüyor musunuz?",
    "options": [
      "Başkalarından daha kötü olduğumu sanmıyorum.",
      "Hatalarım ve zayıf taraflarım olduğunu düşünüyorum.",
      "Hatalarımdan dolayı kendimden utanıyorum.",
      "Her şeyi yanlış yapıyormuşum gibi geliyor ve hep kendimi kabahatli buluyorum."
    ],
  },
  {
    "question": "İştahınız nasıl?",
    "options": [
      "İştahım her zamanki gibi.",
      "Eskisinden daha iştahsızım.",
      "İştahım çok azaldı.",
      "Hiçbir şey yiyemiyorum."
    ],
  },
  {
    "question": "Zayıfladınız mı?",
    "options": [
      "Son zamanlarda zayıflamadım.",
      "Zayıflamaya çalışmadığım halde en az 2 kg verdim.",
      "Zayıflamaya çalışmadığım halde en az 4 kg verdim.",
      "Zayıflamaya çalışmadığım halde en az 6 kg verdim."
    ],
  },
  {
    "question": "Sağlığınız hakkında endişeleriniz var mı?",
    "options": [
      "Sağlığımla ilgili kaygılarım yok.",
      "Ağrılar, mide sancıları, kabızlık gibi şikayetlerim oluyor ve bunlar beni tasalandırıyor.",
      "Sağlığımın bozulmasından çok kaygılanıyorum ve kafamı başka şeylere vermekte zorlanıyorum.",
      "Sağlık durumum kafama o kadar takılıyor ki, başka hiçbir şey düşünemiyorum."
    ],
  },
  {
    "question": "Sekse karşı ilginizde değişiklik var mı?",
    "options": [
      "Sekse karşı ilgimde herhangi bir değişiklik yok.",
      "Eskisine oranla sekse ilgim az.",
      "Cinsel isteğim çok azaldı.",
      "Hiç cinsel istek duymuyorum."
    ],
  },
  {
    "question":
        "Cezalandırılmanız gereken şeyler yaptığınızı düşünüyor musunuz?",
    "options": [
      "Cezalandırılması gereken şeyler yaptığımı sanmıyorum.",
      "Yaptıklarımdan dolayı cezalandırılabileceğimi düşünüyorum.",
      "Cezamı çekmeyi bekliyorum.",
      "Sanki cezamı bulmuşum gibi geliyor."
    ],
  },
  {
    "question": "Kendinizi öldürmek gibi düşünceleriniz var mı?",
    "options": [
      "Kendimi öldürmek gibi düşüncelerim yok.",
      "Kimi zaman kendimi öldürmeyi düşündüğüm oluyor ama yapmıyorum.",
      "Kendimi öldürmek isterdim.",
      "Fırsatını bulsam kendimi öldürürüm."
    ],
  },
  {
    "question": "İçinizden ağlamak geliyor mu?",
    "options": [
      "İçimden ağlamak geldiği pek olmuyor.",
      "Zaman zaman içimden ağlamak geliyor.",
      "Çoğu zaman ağlıyorum.",
      "Eskiden ağlayabilirdim ama şimdi istesem de ağlayamıyorum."
    ],
  },
  {
    "question": "Her zamankinden daha canı sıkkın ve sinirli misiniz?",
    "options": [
      "Her zaman olduğumdan daha canı sıkkın ve sinirli değilim.",
      "Eskisine oranla daha kolay canım sıkılıyor ve kızıyorum.",
      "Her şey canımı sıkıyor ve kendimi hep sinirli hissediyorum.",
      "Canımı sıkan şeylere bile artık kızamıyorum."
    ],
  },
];
