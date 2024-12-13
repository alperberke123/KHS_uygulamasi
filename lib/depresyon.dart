import 'package:flutter/material.dart';

class DepressionQuiz extends StatefulWidget {
  const DepressionQuiz({Key? key}) : super(key: key);

  @override
  _DepressionQuizState createState() => _DepressionQuizState();
}

class _DepressionQuizState extends State<DepressionQuiz> {
  final List<int> scores = List<int>.filled(21, 0);

  void _calculateTotalScore(BuildContext context) {
    int totalScore = scores.reduce((a, b) => a + b);
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
                        title: Text(quizQuestions[index]['options']![optionIndex]),
                        value: optionIndex,
                        groupValue: scores[index],
                        onChanged: (value) {
                          setState(() {
                            scores[index] = value!;
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

class QuizResultPage extends StatelessWidget {
  final int totalScore;

  const QuizResultPage({Key? key, required this.totalScore}) : super(key: key);

  String getResultMessage() {
    if (totalScore <= 9) {
      return "Depresyon belirtileri göstermiyorsunuz.";
    } else if (totalScore <= 16) {
      return "Hafif depresyon belirtileriniz olabilir.";
    } else if (totalScore <= 29) {
      return "Orta derecede depresyon belirtileriniz var.";
    } else {
      return "Şiddetli depresyon belirtileriniz var. Profesyonel destek almanız önerilir.";
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
              Text(
                'Toplam Puanınız: $totalScore',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
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
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Başa Dön'),
              ),
            ],
          ),
        ),
      ),
    );
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
    "question": "Cezalandırılmanız gereken şeyler yaptığınızı düşünüyor musunuz?",
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