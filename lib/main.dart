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
        scaffoldBackgroundColor: Colors.lightBlue.shade50, // Açık mavi arka plan
        useMaterial3: true,
        primarySwatch: Colors.blue, // Genel tema rengi
      ),
      home: const BilgilendirmeSayfasi(),
    );
  }
}

class BilgilendirmeSayfasi extends StatefulWidget {
  const BilgilendirmeSayfasi({super.key});

  @override
  State<BilgilendirmeSayfasi> createState() => _BilgilendirmeSayfasiState();
}

class _BilgilendirmeSayfasiState extends State<BilgilendirmeSayfasi> {
  @override
  void initState() {
    super.initState();
    checkSpecialDays(); // Özel gün kontrolünü başlat
  }

  void checkSpecialDays() {
    DateTime today = DateTime.now(); // Bugünün tarihi

    if (today.month == 10 && today.day == 29) {
      _showSpecialDayDialog("29 Ekim Cumhuriyet Bayramı", "Bugün Cumhuriyet Bayramı'nı kutluyoruz!");
    } else if (today.month == 9 && today.day == 24) {
      _showSpecialDayDialog("23 Nisan Ulusal Egemenlik ve Çocuk Bayramı", "Bugün 23 Nisan Ulusal Egemenlik ve Çocuk Bayramı'nı kutluyoruz!");
    } else if (today.month == 5 && today.day == 19) {
      _showSpecialDayDialog("19 Mayıs Atatürk'ü Anma, Gençlik ve Spor Bayramı", "Bugün 19 Mayıs Atatürk'ü Anma, Gençlik ve Spor Bayramı'nı kutluyoruz!");
    }
  }

  void _showSpecialDayDialog(String title, String message) {
    Future.delayed(Duration.zero, () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          double screenWidth = MediaQuery.of(context).size.width;
          double titleFontSize = screenWidth * 0.06;

          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            backgroundColor: Colors.white,
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.celebration, color: Colors.blueAccent, size: 30),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Mavi buton
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text("Kapat", style: TextStyle(color: Colors.white)),
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
            const Spacer(),
            const Text(
              "UYGULAMAMIZ HAKKINDA",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blueAccent),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: const Text(
                "Koruyucu Sağlık Hizmetleri (KSH) uygulaması sağlığınızı korumak "
                    "için kişisel özelliklerinize göre yaşam boyu almanız gereken "
                    "sağlık hizmetleri hakkında bilgilendirmeyi amaçlamaktadır.",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Colors.blueGrey),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            ElevatedButton(
              child: const Text(
                "Diğer sayfa için tıklayınız",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                backgroundColor: Colors.lightBlue, // Açık mavi buton
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const sayfa2()));
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
