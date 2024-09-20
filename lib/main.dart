import 'package:flutter/material.dart';
import 'package:ksh_uygulamasi/ikinci_sayfa.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.orangeAccent,
        useMaterial3: true,
      ),
      home: bilgilendirmeSayfasi(),
    );
  }
}

class bilgilendirmeSayfasi extends StatefulWidget {
  const bilgilendirmeSayfasi({super.key});

  @override
  State<bilgilendirmeSayfasi> createState() => _bilgilendirmeSayfasiState();
}

class _bilgilendirmeSayfasiState extends State<bilgilendirmeSayfasi> {
  @override
  void initState() {
    super.initState();
    checkSpecialDays(); // Özel gün kontrolünü başlat
  }

  // Özel günleri kontrol eden fonksiyon
  void checkSpecialDays() {
    DateTime today = DateTime.now(); // Bugünün tarihi

    // Özel günlerin olduğu tarihleri tanımlıyoruz
    if (today.month == 10 && today.day == 29) {
      _showSpecialDayDialog("29 Ekim Cumhuriyet Bayramı", "Bugün Cumhuriyet Bayramı'nı kutluyoruz!");
    } else if (today.month == 9 && today.day == 20) {
      _showSpecialDayDialog("23 Nisan Ulusal Egemenlik ve Çocuk Bayramı", "Bugün 23 Nisan Ulusal Egemenlik ve Çocuk Bayramı'nı kutluyoruz!");
    } else if (today.month == 5 && today.day == 19) {
      _showSpecialDayDialog("19 Mayıs Atatürk'ü Anma, Gençlik ve Spor Bayramı", "Bugün 19 Mayıs Atatürk'ü Anma, Gençlik ve Spor Bayramı'nı kutluyoruz!");
    }
  }

  // Şık pop-up dialog'u gösteren fonksiyon
  void _showSpecialDayDialog(String title, String message) {
    Future.delayed(Duration.zero, () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          double screenWidth = MediaQuery.of(context).size.width;
          double titleFontSize = screenWidth * 0.06; // Ekranın %6'sı kadar

          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0), // Köşeleri yuvarlat
            ),
            backgroundColor: Colors.white,
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min, // İçeriğe göre boyutlan
                children: [
                  // Başlık
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.celebration, color: Colors.orange, size: 30),
                      SizedBox(width: 10),
                      // Başlık kısmında Expanded kullanarak taşmayı önlüyoruz
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis, // Taşma durumunda üç nokta ekle
                          maxLines: 2, // Maksimum satır sayısı
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // İçerik
                  Text(
                    message,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  // Kapat Butonu
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text("Kapat", style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Text(
              "UYGULAMAMIZ HAKKINDA",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Uygulamamız Koruyucu Sağlık Hizmetleri hakkında insanları bilgilendirmeyi amaçlamaktadır. "
                    "Bu şekilde insanlar hem ileride oluşabilecek hastalıklara erken önlem almış olacaklar hem de "
                    "şuan halihazırda var olabilecek hastalıklara karşı bilgilendirilmiş olacaklar.",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ),
            Spacer(),
            ElevatedButton(
              child: Text(
                "Diğer sayfa için tıklayınız",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => sayfa2()));
              },
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
