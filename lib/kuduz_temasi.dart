import 'package:flutter/material.dart';

class KuduzTemasi extends StatefulWidget {
  const KuduzTemasi({super.key});

  @override
  State<KuduzTemasi> createState() => _KuduzTemasiState();
}

class _KuduzTemasiState extends State<KuduzTemasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kuduz Riskli Temas'),
        backgroundColor: Colors.blueAccent, // İlk sayfadaki renk temasına uygun hale getirildi
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Genel kenar boşlukları
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch, // Buton ve metinleri hizalı gösterir
          children: [
            Text(
              "KUDUZ RİSKLİ TEMAS:",
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent, // İlk sayfadaki mavi tema
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20), // Başlık ve içerik arasında boşluk
            Container(
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: Colors.blue[50], // Arka plan rengi olarak mavi ton kullanıldı
                borderRadius: BorderRadius.circular(10), // Köşeleri yuvarlat
              ),
              child: const Text(
                """
0., 3., 7. günlerde birer doz ve 14 ile 28. günler arasında dördüncü doz veya
0. gün 2 doz, 7. ve 21. günlerde birer doz uygulanmalıdır.

İLK BAŞVURU ACİL
                """,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 40), // Alt kısımla metin arasında boşluk
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Geri dön butonu
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent, // İlk sayfadaki buton rengiyle aynı
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Butonun köşeleri yuvarlatıldı
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text(
                  "Geri Dön",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
