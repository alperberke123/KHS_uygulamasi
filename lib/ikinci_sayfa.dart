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
        title: const Text('Sağlığımı Takipteyim'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView( // ListView ile kaydırma özelliği
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: _buildInfoSection(
                "Kişisel özelliklerinizi girmek için aşağıdaki butona tıklayınız.",
                "Devam Et",
                    () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => anasayfa()));
                },
                isLarge: true, // "Devam Et" butonu büyük olacak.
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: const SizedBox(height: 30),
            ),
            _buildInfoSection(
              "Yakın zamanda kuduz açısından riskli bir temas gerçekleştirdiyseniz tıklayınız.",
              "Kuduz Riskli Temas",
                  () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => KuduzTemasi()));
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: const SizedBox(height: 20),
            ),
            _buildInfoSection(
              "Hiç aşı olmadıysanız aşağıdaki butona tıklayabilirsiniz.",
              "Hiç Aşı Olmadım",
                  () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => asi_olmadim()));
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: const SizedBox(height: 20),
            ),
            _buildInfoSection(
              "KSH hakkında genel bilgi sahibi olmak için",
              "Genel Olarak KSH",
                  () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => DataPage()));
              },
            ),
          ],
        ),
      ),
    );
  }

  // Bilgilendirme ve buton yapısını oluşturan widget
  Widget _buildInfoSection(String text, String buttonText, VoidCallback onPressed, {bool isLarge = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: Colors.blueGrey,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: isLarge ? 70 : 50, // "Devam Et" butonunu diğerlerinden büyük yapıyoruz
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: Text(
              buttonText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18, // "Devam Et" butonunda yazı boyutu da büyük olacak
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
