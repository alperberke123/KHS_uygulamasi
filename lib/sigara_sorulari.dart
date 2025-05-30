import 'package:flutter/material.dart';

class SigaraSorulariEkrani extends StatefulWidget {
  const SigaraSorulariEkrani({super.key});

  @override
  _SigaraSorulariEkraniState createState() => _SigaraSorulariEkraniState();
}

class _SigaraSorulariEkraniState extends State<SigaraSorulariEkrani> {
  int _totalScore = 0;
  List<int?> selectedAnswers = [null, null, null, null, null, null];

  final List<Map<String, dynamic>> _questions = [
    {
      'question':
          'Günün ilk sigarasını sabah uyandıktan ne kadar sonra içersiniz?',
      'answers': [
        {'text': 'İlk 5 dakika içinde', 'score': 3},
        {'text': '6-30 dakika içinde', 'score': 2},
        {'text': '31-60 dakika içinde', 'score': 1},
        {'text': '1 saatten sonra', 'score': 0},
      ],
    },
    {
      'question':
          'Sigara içmenin yasak olduğu yerlerde sigara içmemek sizi zorlar mı?',
      'answers': [
        {'text': 'Evet', 'score': 1},
        {'text': 'Hayır', 'score': 0},
      ],
    },
    {
      'question': 'Günün hangi sigarasından vazgeçmek sizin için daha zordur?',
      'answers': [
        {'text': 'Sabah ilk içilen sigara', 'score': 1},
        {'text': 'Diğer zamanlarda içilen sigaralar', 'score': 0},
      ],
    },
    {
      'question': 'Günde kaç adet sigara içiyorsunuz?',
      'answers': [
        {'text': '31 ve daha fazla', 'score': 3},
        {'text': '21-30 adet', 'score': 2},
        {'text': '11-20 adet', 'score': 1},
        {'text': '10 ve daha az', 'score': 0},
      ],
    },
    {
      'question':
          'Sabahları günün diğer zamanlarına göre daha fazla sigara içiyor musunuz?',
      'answers': [
        {'text': 'Evet', 'score': 1},
        {'text': 'Hayır', 'score': 0},
      ],
    },
    {
      'question':
          'Yatmanızı gerektirecek kadar hasta olduğunuz zamanlarda da sigara içer misiniz?',
      'answers': [
        {'text': 'Evet', 'score': 1},
        {'text': 'Hayır', 'score': 0},
      ],
    },
  ];

  void _answerQuestion(int index, int score) {
    setState(() {
      selectedAnswers[index] = score;
    });
  }

  void _submitAnswers() {
    // Eğer bir soru cevaplanmamışsa uyarı göster
    if (selectedAnswers.contains(null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lütfen tüm soruları cevaplayınız.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // Tüm sorular cevaplandıysa toplam puanı hesapla ve sonucu göster
    _totalScore =
        selectedAnswers.fold(0, (prev, element) => prev + (element ?? 0));
    String resultMessage;

    if (_totalScore <= 2) {
      resultMessage = "Çok az bağımlılık";
    } else if (_totalScore <= 4) {
      resultMessage = "Az bağımlılık";
    } else if (_totalScore == 5) {
      resultMessage = "Orta derecede bağımlı";
    } else if (_totalScore <= 7) {
      resultMessage = "Yüksek bağımlılık";
    } else {
      resultMessage = "Çok yüksek bağımlılık";
    }

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Test Sonucu"),
        content: Text(
            "Toplam Puanınız: $_totalScore\nBağımlılık Düzeyi: $resultMessage"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("Tamam"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sigara Bağımlılığı Testi'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _questions.length,
                itemBuilder: (context, index) {
                  final question = _questions[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        question['question'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                      ...question['answers'].map<Widget>((answer) {
                        return RadioListTile<int>(
                          title: Text(answer['text']),
                          value: answer['score'],
                          groupValue: selectedAnswers[index],
                          activeColor: Colors.blueAccent,
                          onChanged: (value) {
                            _answerQuestion(index, value!);
                          },
                        );
                      }).toList(),
                      const SizedBox(height: 10),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitAnswers,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Sonuçları Göster',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
