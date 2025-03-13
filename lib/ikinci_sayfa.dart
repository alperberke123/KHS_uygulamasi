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
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade50, Colors.white],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              const SizedBox(height: 20),
              _buildInfoSection(
                "Yakın zamanda kuduz açısından riskli bir temas gerçekleştirdiyseniz tıklayınız.",
                "Kuduz Riskli Temas",
                () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const KuduzTemasi()));
                },
                icon: Icons.pets,
              ),
              const SizedBox(height: 20),
              _buildInfoSection(
                "Hiç aşı olmadıysanız aşağıdaki butona tıklayabilirsiniz.",
                "Hiç Aşı Olmadım",
                () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const asi_olmadim()));
                },
                icon: Icons.vaccines,
              ),
              const SizedBox(height: 20),
              _buildInfoSection(
                "KSH hakkında genel bilgi sahibi olmak için",
                "Genel Olarak KSH",
                () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const DataPage()));
                },
                icon: Icons.info_outline,
              ),
              const SizedBox(height: 20),
              _buildInfoSection(
                "Kaydettiğiniz bilgiler doğrultusunda değerlendirme sonuçlarınızı görüntüleyin",
                "Değerlendirme Sonuçlarım",
                () {
                  // TODO: Değerlendirme sonuçları sayfasına yönlendirme eklenecek
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Bu özellik yakında eklenecektir'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                icon: Icons.assessment,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection(String text, String buttonText, VoidCallback onPressed, {IconData? icon}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.blueGrey,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(icon),
                  const SizedBox(width: 8),
                ],
                Text(
                  buttonText,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
