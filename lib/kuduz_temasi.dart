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
        title: Text('Kuduz Riskli Temas'),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0), // Tüm kenarlara 20 birim boşluk
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start, // Metinleri sola hizalar
          children: [
            Text(
              "KUDUZ RİSKLİ TEMAS:",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 20), // Başlık ve içerik arasında boşluk
            Container(
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: Colors.red[50], // Arka plan rengi
                borderRadius: BorderRadius.circular(10), // Köşeleri yuvarlat
              ),
              child: Text(
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
            SizedBox(height: 40), // Alt kısımla metin arasında boşluk
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Geri dön butonu
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Butonun köşelerini yuvarlat
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Buton boyutları
                ),
                child: Text(
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
