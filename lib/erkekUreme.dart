import 'package:flutter/material.dart';

class ErkekUreme extends StatelessWidget {
  const ErkekUreme({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Erkek Üreme Sağlığı', style: TextStyle(fontSize: 24)),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        elevation: 10,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Başlık
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blueAccent.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Erkekler için Üreme Sağlığı (18-65 yaş)',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),

            // Erkek Üreme Organları Başlığı
            const Text(
              'Erkek Üreme Organları Nelerdir?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(height: 10),

            // Dış Üreme Organları
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: const ListTile(
                title: Text(
                  'Dış Üreme Organları',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text('• Penis\n• Haya torbası (skrotum)'),
              ),
            ),

            // İç Üreme Organları
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: const ListTile(
                title: Text(
                  'İç Üreme Organları',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '• Hayalar (testisler)\n• Tohum kanalları (sperm kanalları)\n• Meni kesecikleri (semen kesecikleri)\n• Prostat\n• Boşaltım yolu, idrar yolu ve meni kanalı',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Korunma Yöntemleri Başlığı
            const Text(
              'Erkeğe Ait Korunma Yöntemleri',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(height: 10),

            // Korunma Yöntemleri
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: const ListTile(
                title: Text(
                  '• Geri Dönebilir Yöntemler',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text('• Kondom (Korunmada etkilidir.)'),
              ),
            ),
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: const ListTile(
                title: Text(
                  '• Kalıcı Yöntemler',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text('• Kanalların bağlanması (vazektomi)'),
              ),
            ),
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: const ListTile(
                title: Text(
                  '• Geleneksel Yöntemler',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '• "Geri çekme" yönteminin koruyucu etkisi yoktur.',
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // HPV ve Kanserler Başlığı
            const Text(
              'Human Papilloma Virüsü ve Erkeklerde Yaptığı Kanserler',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(height: 10),

            // HPV ile İlişkili Kanserler
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: const ListTile(
                title: Text(
                  'HPV ile İlişkili Kanserler',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '• Genital bölgede, anal kanal ve çok nadiren rektumda, nazal kavite, orofarengeyal bölgede siğiller\n'
                  '• Penis kanseri\n'
                  '• Prostat kanseri\n'
                  '• Kısırlık (infertilite)\n'
                  '• Anüs kanseri\n'
                  '• Orofarenks kanseri',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
