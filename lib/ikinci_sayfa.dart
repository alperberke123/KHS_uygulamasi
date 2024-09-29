import 'package:flutter/material.dart';
import 'package:ksh_uygulamasi/anaSayfa.dart';
import 'package:ksh_uygulamasi/her_seyi_gosteren_sayfa.dart';
import 'package:ksh_uygulamasi/hic_asi_olmadim.dart';
import 'package:ksh_uygulamasi/kuduz_temasi.dart';

class sayfa2 extends StatefulWidget {
  const sayfa2({super.key});

  @override
  State<sayfa2> createState() => _sayfa2State();
}

class _sayfa2State extends State<sayfa2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Koruyucu Sağlık Hizmetleri'),
        backgroundColor: Colors.blueAccent, // Mavi tonlu AppBar
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch, // Buton ve metinleri hizalı gösterir
          children: [
            _buildInfoSection(
              "Yakın zamanda kuduz açısından riskli bir temas gerçekleştirdiyseniz tıklayınız.",
              "Kuduz Riskli Temas",
                  () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => KuduzTemasi()));
              },
            ),
            const SizedBox(height: 20),
            _buildInfoSection(
              "Hiç aşı olmadıysanız aşağıdaki butona tıklayabilirsiniz.",
              "Hiç Aşı Olmadım",
                  () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => asi_olmadim()));
              },
            ),
            const SizedBox(height: 20),
            _buildInfoSection(
              "KSH hakkında genel bilgi sahibi olmak için",
              "Genel Olarak KSH",
                  () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => DataPage()));
              },
            ),
            const SizedBox(height: 20),
            _buildInfoSection(
              "Kişisel özelliklerinizi girmek için aşağıdaki butona tıklayınız.",
              "Devam Et",
                  () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => anasayfa()));
              },
            ),
          ],
        ),
      ),
    );
  }

  // Bilgilendirme ve buton yapısını oluşturan widget
  Widget _buildInfoSection(String text, String buttonText, VoidCallback onPressed) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: Colors.blueGrey, // Metin rengi olarak mavinin daha yumuşak bir tonu
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent, // Butonun arka planı mavi tonlu
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // Buton köşeleri yuvarlatıldı
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: Text(
              buttonText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
