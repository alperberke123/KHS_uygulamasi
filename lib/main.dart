import 'package:flutter/material.dart';
import 'package:ksh_uygulamasi/ikinci_sayfa.dart';
import 'dart:async';
import 'package:ksh_uygulamasi/anaSayfa.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'package:ksh_uygulamasi/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Firebase'i başlat
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Firebase Authentication'ı başlat
  await FirebaseAuth.instance.signInAnonymously();
  
  // Bildirim servisini başlat
  final notificationService = NotificationService();
  await notificationService.init();
  
  // Tüm bildirimleri planla
  await notificationService.scheduleAllSpecialDays();
  
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
        scaffoldBackgroundColor: Colors.lightBlue.shade50,
        // Açık mavi arka plan
        useMaterial3: true,
        primarySwatch: Colors.blue, // Genel tema rengi
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sağlığımı Takipteyim'),
        backgroundColor: Colors.lightGreen,
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.person, color: Colors.white),
            label: const Text(
              'Profil',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Anasayfa(),
                ),
              );
            },
          ),
        ],
      ),
      body: const BilgilendirmeSayfasi(),
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

  // Yardımcı fonksiyonlar

  // Ocak ayının ilk pazartesi
  DateTime getFirstMondayInJanuary() {
    DateTime date = DateTime(DateTime.now().year, 1, 1);
    while (date.weekday != DateTime.monday) {
      date = date.add(const Duration(days: 1));
    }
    return date;
  }

  // Mart ayının üçüncü pazartesi
  DateTime getThirdMondayInMarch() {
    DateTime date = DateTime(DateTime.now().year, 3, 1);
    int mondayCount = 0;
    while (mondayCount < 3) {
      if (date.weekday == DateTime.monday) {
        mondayCount++;
      }
      date = date.add(const Duration(days: 1));
    }
    return date.subtract(const Duration(days: 1));
  }

  // Nisan ayının son haftası
  DateTime getLastMondayInApril() {
    DateTime date = DateTime(DateTime.now().year, 4, 30);
    while (date.weekday != DateTime.monday) {
      date = date.subtract(const Duration(days: 1));
    }
    return date;
  }

  // Mayıs ayının ilk salı günü
  DateTime getFirstTuesdayInMay() {
    DateTime date = DateTime(DateTime.now().year, 5, 1);
    while (date.weekday != DateTime.tuesday) {
      date = date.add(const Duration(days: 1));
    }
    return date;
  }

  // Ekim ayının ikinci perşembe günü
  DateTime getSecondThursdayInOctober() {
    DateTime date = DateTime(DateTime.now().year, 10, 1);
    int thursdayCount = 0;
    while (thursdayCount < 2) {
      if (date.weekday == DateTime.thursday) {
        thursdayCount++;
      }
      date = date.add(const Duration(days: 1));
    }
    return date.subtract(const Duration(days: 1));
  }

  // Özel günleri kontrol eden fonksiyon
  void checkSpecialDays() {
    DateTime today = DateTime.now(); // Bugünün tarihi
    List<Map<String, String>> specialDays = [];

    // Sabit tarihler
    if (today.month == 2 && today.day == 4) {
      specialDays.add({
        "title": "Dünya Kanser Günü",
        "message": "4 Şubat Dünya Kanser Günü!"
      });
    }
    if (today.month == 2 && today.day == 9) {
      specialDays.add({
        "title": "Sigarayı Bırakma Günü",
        "message": "9 Şubat Sigarayı Bırakma Günü!"
      });
    }
    if (today.month == 3 && today.day == 3) {
      specialDays.add({
        "title": "Dünya Kulak ve İşitme Günü",
        "message": "3 Mart Dünya Kulak ve İşitme Günü!"
      });
    }
    if (today.month == 3 && today.day == 4) {
      specialDays.add({
        "title": "Dünya Obezite Günü",
        "message": "4 Mart Dünya Obezite Günü!"
      });
    }
    if (today.month == 3 && today.day == 24) {
      specialDays.add({
        "title": "Dünya Tüberküloz Günü",
        "message": "24 Mart Dünya Tüberküloz Günü!"
      });
    }
    if (today.month == 4 && today.day == 2) {
      specialDays.add({
        "title": "Dünya Otizm Farkındalık Günü",
        "message": "2 Nisan Dünya Otizm Farkındalık Günü!"
      });
    }
    if (today.month == 4 && today.day == 15) {
      specialDays.add({
        "title": "Büyümenin İzlenmesi Günü",
        "message": "15 Nisan Büyümenin İzlenmesi Günü!"
      });
    }
    if (today.month == 4 && today.day == 17) {
      specialDays.add({
        "title": "Dünya Hemofili Günü",
        "message": "17 Nisan Dünya Hemofili Günü!"
      });
    }
    if (today.month == 5 && today.day == 8) {
      specialDays.add({
        "title": "Dünya Talasemi Günü",
        "message": "8 Mayıs Dünya Talasemi Günü!"
      });
    }
    if (today.month == 5 && today.day == 10) {
      specialDays.add({
        "title": "Dünya Sağlık İçin Hareket Et Günü",
        "message": "10 Mayıs Dünya Sağlık İçin Hareket Et Günü!"
      });
      specialDays.add({
        "title": "Dünya İnme Önleme Günü",
        "message": "10 Mayıs Dünya İnme Önleme Günü!"
      });
    }
    if (today.month == 5 && today.day == 17) {
      specialDays.add({
        "title": "Dünya Hipertansiyon Günü",
        "message": "17 Mayıs Dünya Hipertansiyon Günü!"
      });
    }
    if (today.month == 5 && today.day == 31) {
      specialDays.add({
        "title": "Dünya Tütünsüz Günü",
        "message": "31 Mayıs Dünya Tütünsüz Günü!"
      });
    }
    if (today.month == 6 && today.day == 1) {
      specialDays.add({
        "title": "Ulusal Fenilketonüri Günü",
        "message": "1 Haziran Ulusal Fenilketonüri Günü!"
      });
    }
    if (today.month == 6 && today.day == 26) {
      specialDays.add({
        "title": "Dünya Uyuşturucu Kullanımı ve Kaçakçılığı ile Mücadele Günü",
        "message":
            "26 Haziran Dünya Uyuşturucu Kullanımı ve Kaçakçılığı ile Mücadele Günü!"
      });
    }
    if (today.month == 7 && today.day == 28) {
      specialDays.add({
        "title": "Dünya Hepatit Günü",
        "message": "28 Temmuz Dünya Hepatit Günü!"
      });
    }
    if (today.month == 9 && today.day == 10) {
      specialDays.add({
        "title": "Dünya İntiharı Önleme Günü",
        "message": "10 Eylül Dünya İntiharı Önleme Günü!"
      });
    }
    if (today.month == 9 && today.day == 26) {
      specialDays.add({
        "title": "Dünya Doğum Kontrol Günü",
        "message": "26 Eylül Dünya Doğum Kontrol Günü!"
      });
    }
    if (today.month == 9 && today.day == 27) {
      specialDays.add({
        "title": "Dünya Okul Süt Günü",
        "message": "27 Eylül Dünya Okul Süt Günü!"
      });
    }
    if (today.month == 9 && today.day == 28) {
      specialDays.add({
        "title": "Dünya Kuduz Günü",
        "message": "28 Eylül Dünya Kuduz Günü!"
      });
    }
    if (today.month == 9 && today.day == 29) {
      specialDays.add(
          {"title": "Dünya Kalp Günü", "message": "29 Eylül Dünya Kalp Günü!"});
    }
    if (today.month == 10 && today.day == 1) {
      specialDays.add({
        "title": "Dünya Yaşlılar Günü",
        "message": "1 Ekim Dünya Yaşlılar Günü!"
      });
    }
    if (today.month == 10 && today.day == 3) {
      specialDays.add({
        "title": "Dünya Yürüyüş Günü",
        "message": "3 Ekim Dünya Yürüyüş Günü!"
      });
    }
    if (today.month == 10 && today.day == 10) {
      specialDays.add({
        "title": "Dünya Ruh Sağlığı Günü",
        "message": "10 Ekim Dünya Ruh Sağlığı Günü!"
      });
    }
    if (today.month == 10 && today.day == 13) {
      specialDays.add({
        "title": "Uluslararası Afet Risklerinin Azaltılması Günü",
        "message": "13 Ekim Uluslararası Afet Risklerinin Azaltılması Günü!"
      });
    }
    if (today.month == 10 && today.day == 15) {
      specialDays.add({
        "title": "Dünya El Yıkama Günü",
        "message": "15 Ekim Dünya El Yıkama Günü!"
      });
      specialDays.add({
        "title": "Dünya Meme Sağlığı Günü",
        "message": "15 Ekim Dünya Meme Sağlığı Günü!"
      });
    }
    if (today.month == 11 && today.day == 18) {
      specialDays.add({
        "title": "Avrupa Antibiyotik Farkındalık Günü",
        "message": "18 Kasım Avrupa Antibiyotik Farkındalık Günü!"
      });
    }
    if (today.month == 11 && today.day == 22) {
      specialDays.add({
        "title": "Ağız Diş Sağlığı Haftası",
        "message": "22 Kasım Ağız Diş Sağlığı Haftası!"
      });
    }
    if (today.month == 11 && today.day == 14) {
      specialDays.add({
        "title": "Dünya Diyabet Günü",
        "message": "14 Kasım Dünya Diyabet Günü!"
      });
    }
    if (today.month == 12 && today.day == 1) {
      specialDays.add(
          {"title": "Dünya AIDS Günü", "message": "1 Aralık Dünya AIDS Günü!"});
    }
    if (today.month == 12 && today.day == 3) {
      specialDays.add({
        "title": "Dünya Engelliler Günü",
        "message": "3 Aralık Dünya Engelliler Günü!"
      });
    }

    // Süreli özel günler
    if (today.isAfter(DateTime(today.year, 1, 1)) &&
        today.isBefore(
            DateTime(today.year, 1, 31).add(const Duration(days: 1)))) {
      specialDays.add({
        "title": "Rahim Ağzı (Serviks) Kanseri Farkındalık Ayı",
        "message": "1-31 Ocak boyunca Serviks Kanseri Farkındalığı!"
      });
    }
    if (today.isAfter(DateTime(today.year, 3, 1)) &&
        today.isBefore(
            DateTime(today.year, 3, 7).add(const Duration(days: 1)))) {
      specialDays.add(
          {"title": "Yeşilay Haftası", "message": "1-7 Mart Yeşilay Haftası!"});
    }
    if (today.isAfter(DateTime(today.year, 3, 14)) &&
        today.isBefore(
            DateTime(today.year, 3, 20).add(const Duration(days: 1)))) {
      specialDays.add({
        "title": "Dünya Tuza Dikkat Haftası",
        "message": "14-20 Mart Dünya Tuza Dikkat Haftası!"
      });
    }
    if (today.isAfter(DateTime(today.year, 3, 18)) &&
        today.isBefore(
            DateTime(today.year, 3, 24).add(const Duration(days: 1)))) {
      specialDays.add({
        "title": "Yaşlılar Haftası",
        "message": "18-24 Mart Yaşlılar Haftası!"
      });
    }
    if (today.isAfter(DateTime(today.year, 4, 1)) &&
        today.isBefore(
            DateTime(today.year, 4, 7).add(const Duration(days: 1)))) {
      specialDays.add(
          {"title": "Kanser Haftası", "message": "1-7 Nisan Kanser Haftası!"});
    }
    if (today.isAfter(DateTime(today.year, 4, 12)) &&
        today.isBefore(
            DateTime(today.year, 4, 18).add(const Duration(days: 1)))) {
      specialDays.add({
        "title": "Kalp Sağlığı Haftası",
        "message": "12-18 Nisan Kalp Sağlığı Haftası!"
      });
    }
    if (today.isAfter(DateTime(today.year, 4, 7)) &&
        today.isBefore(
            DateTime(today.year, 4, 13).add(const Duration(days: 1)))) {
      specialDays.add({
        "title": "Dünya Sağlık Haftası",
        "message": "7-13 Nisan Dünya Sağlık Haftası!"
      });
    }
    if (today.isAfter(DateTime(today.year, 4, 24)) &&
        today.isBefore(
            DateTime(today.year, 4, 30).add(const Duration(days: 1)))) {
      specialDays
          .add({"title": "Aşı Haftası", "message": "24-30 Nisan Aşı Haftası!"});
    }
    if (today.isAfter(DateTime(today.year, 5, 10)) &&
        today.isBefore(
            DateTime(today.year, 5, 16).add(const Duration(days: 1)))) {
      specialDays.add({
        "title": "Engelliler Haftası",
        "message": "10-16 Mayıs Engelliler Haftası!"
      });
    }
    if (today.isAfter(DateTime(today.year, 6, 1)) &&
        today.isBefore(
            DateTime(today.year, 6, 7).add(const Duration(days: 1)))) {
      specialDays.add({
        "title": "İyot Yetersizliği Hastalıklarının Önlenmesi Haftası",
        "message": "1-7 Haziran İyot Yetersizliği Haftası!"
      });
    }
    if (today.isAfter(DateTime(today.year, 8, 1)) &&
        today.isBefore(
            DateTime(today.year, 8, 7).add(const Duration(days: 1)))) {
      specialDays.add({
        "title": "Dünya Emzirme Haftası",
        "message": "1-7 Ağustos Dünya Emzirme Haftası!"
      });
    }
    if (today.isAfter(DateTime(today.year, 9, 3)) &&
        today.isBefore(
            DateTime(today.year, 9, 9).add(const Duration(days: 1)))) {
      specialDays.add({
        "title": "Halk Sağlığı Haftası",
        "message": "3-9 Eylül Halk Sağlığı Haftası!"
      });
    }
    if (today.isAfter(DateTime(today.year, 10, 1)) &&
        today.isBefore(
            DateTime(today.year, 10, 31).add(const Duration(days: 1)))) {
      specialDays.add({
        "title": "Meme Kanseri Bilinçlendirme Ayı",
        "message": "1-31 Ekim Meme Kanseri Bilinçlendirme Ayı!"
      });
    }
    if (today.isAfter(DateTime(today.year, 10, 1)) &&
        today.isBefore(
            DateTime(today.year, 10, 7).add(const Duration(days: 1)))) {
      specialDays.add(
          {"title": "Emzirme Haftası", "message": "1-7 Ekim Emzirme Haftası!"});
    }

    // Değişken tarihler
    if (today.isAtSameMomentAs(getFirstMondayInJanuary())) {
      specialDays.add({
        "title": "Verem Eğitimi ve Propaganda Haftası",
        "message": "Verem Eğitimi Haftası başladı!"
      });
    }
    if (today.isAtSameMomentAs(getThirdMondayInMarch())) {
      specialDays.add({
        "title": "Dünya Glokom Haftası",
        "message": "Mart ayının 3. haftası Dünya Glokom Haftası!"
      });
    }
    if (today.isAtSameMomentAs(getLastMondayInApril())) {
      specialDays.add({
        "title": "Aşı Haftası",
        "message": "Nisan ayının son haftası Aşı Haftası!"
      });
    }
    if (today.isAtSameMomentAs(getFirstTuesdayInMay())) {
      specialDays.add({
        "title": "Dünya Astım Günü",
        "message": "Mayıs ayının ilk Salı günü Dünya Astım Günü!"
      });
    }
    if (today.isAtSameMomentAs(getSecondThursdayInOctober())) {
      specialDays.add({
        "title": "Dünya Görme Günü",
        "message": "Ekim ayının ikinci Perşembe günü Dünya Görme Günü!"
      });
    }

    // Her bir özel gün için pop-up göster
    for (var day in specialDays) {
      _showSpecialDayDialog(day["title"]!, day["message"]!);
    }
  }

  // Pop-up'ı gösteren fonksiyon
  void _showSpecialDayDialog(String title, String message) {
    Future.delayed(Duration.zero, () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          double screenWidth = MediaQuery.of(context).size.width;
          double titleFontSize = screenWidth * 0.06;

          // Meme kanseri pop-up'ları için pembe arka plan rengi belirle
          bool isBreastCancerRelated =
              title.contains("Meme Kanseri") || title.contains("Meme Sağlığı");

          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            backgroundColor: isBreastCancerRelated
                ? Colors.pinkAccent
                : Colors.white, // Pembe arka plan
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.celebration,
                          color: Colors.blueAccent, size: 30),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.bold,
                            color: isBreastCancerRelated
                                ? Colors.white
                                : Colors.blueAccent, // Metin rengi
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
                    style: TextStyle(
                      fontSize: 18,
                      color: isBreastCancerRelated
                          ? Colors.white
                          : Colors.black54, // Metin rengi
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isBreastCancerRelated
                          ? Colors.white
                          : Colors.blue, // Pembe pop-up'ta beyaz buton
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      "Kapat",
                      style: TextStyle(
                        color: isBreastCancerRelated
                            ? Colors.pinkAccent
                            : Colors.white, // Buton yazı rengi
                      ),
                    ),
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
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightGreen),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Sağlığımı Takipteyim uygulaması sağlığınızı korumak "
                "için kişisel özelliklerinize göre yaşam boyu almanız gereken "
                "sağlık hizmetleri hakkında bilgilendirmeyi amaçlamaktadır.",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.green),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                backgroundColor: Colors.lightGreen, // Açık yeşil buton
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Sayfa2()));
              },
              child: const Text(
                "Diğer sayfa için ilerleyiniz",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
