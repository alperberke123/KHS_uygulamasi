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
        title: Text('Koruyucu Sağlık Hizmetleri'),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch, // Butonları ve metinleri hizalı gösterir
          children: [
            _buildInfoSection(
              "Yakın zamanda kuduz açısından riskli bir temas gerçekleştirdiyseniz tıklayınız.",
              "Kuduz Riskli Temas",
                  () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => KuduzTemasi()));
              },
            ),
            SizedBox(height: 20),
            _buildInfoSection(
              "Hiç aşı olmadıysanız aşağıdaki butona tıklayabilirisiniz.",
              "Hiç Aşı Olmadım",
                  () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => asi_olmadim()));
              },
            ),
            SizedBox(height: 20),
            _buildInfoSection(
              "KSH hakkında genel bilgi sahibi olmak için",
              "Genel Olarak KHS",
                  () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => DataPage()));
              },
            ),
            SizedBox(height: 20),
            _buildInfoSection(
              "Kişisel bilgilerinizi girmek için aşağıdaki butona tıklayınız.",
              "Devam Et",
                  () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => anaSayfa()));
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
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 10),
        SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // Buton köşeleri yuvarlatıldı
              ),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: Text(
              buttonText,
              style: TextStyle(
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
