import 'package:flutter/material.dart';

class beslenme_yuksek extends StatefulWidget {
  const beslenme_yuksek({super.key});

  @override
  State<beslenme_yuksek> createState() => _beslenme_yuksekState();
}

class _beslenme_yuksekState extends State<beslenme_yuksek> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('Fiziksel Aktivite Önerileri'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Fazla Kilolu Yetişkinler için (18 Yaş Üstü):',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '• Hergün fiziksel olarak aktif olunmalıdır.',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 5),
            const Text(
              '• 60 dakika orta şiddetli egzersiz yapılmalıdır.',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 5),
            const Text(
              '• Orta derecede fiziksel aktivite: 30 dakikada 2.5 km yürüyüş.',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const Divider(color: Colors.grey, thickness: 1.5, height: 30),
            const Text(
              'Fazla Kilolu Çocuklar için (2-17 Yaş):',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '• Haftanın her günü 30-80 dakika fiziksel aktivite yapılmalıdır.',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 5),
            const Text(
              'Başlangıç:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              '• 10 dakika yürüyüş, haftada 3-5 gün.',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 10),
            const Text(
              'Devamı:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              '• 60-80 dakika fiziksel aktivite, hemen her gün.',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 10),
            const Text(
              'Önerilen Aktiviteler:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              '• Aerobik egzersizler',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const Text(
              '• Dirençli egzersizler',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            'Orta Şiddetli Fiziksel Aktiviteler:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text('• Tempolu yürüyüş (saatte yaklaşık 5 km)'),
                          Text('• Bahçe işleri'),
                          Text('• Ev işleri (süpürme, silme)'),
                          Text('• Bisiklet (saatte 16 km)'),
                          Text('• Hafif ritimde halk oyunları'),
                          Text('• Salon dansları'),
                          Text('• Tenis (çift)'),
                          Divider(color: Colors.grey, thickness: 1.0),
                          Text(
                            'Şiddetli Fiziksel Aktiviteler:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text('• Koşu/jogging (saatte 8 km)'),
                          Text('• Bisiklet (saatte 16 km)'),
                          Text('• Yüzme'),
                          Text('• Aerobik egzersizler'),
                          Text('• Çok hızlı yürüme (saatte 7 km)'),
                          Text('• Ağırlık kaldırma'),
                          Text('• Basketbol'),
                        ],
                      ),
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Fiziksel Aktivite Detayları',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}