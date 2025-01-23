import 'package:flutter/material.dart';

class erkekUreme extends StatelessWidget {
  const erkekUreme({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Erkek Üreme Sağlığı'),
        backgroundColor: Colors.blueAccent, // Başlık için renk
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Başlık
            Text(
              'Erkekler için Üreme Sağlığı (18-65 yaş)',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
            SizedBox(height: 20),

            // Erkek Üreme Organları Başlığı
            Text(
              'Erkek Üreme Organları Nelerdir?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),

            // Dış Üreme Organları
            Text(
              'Dış Üreme Organları:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('• Penis\n• Haya torbası (skrotum)'),
            SizedBox(height: 10),

            // İç Üreme Organları
            Text(
              'İç Üreme Organları:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('• Hayalar (testisler)\n• Tohum kanalları (sperm kanalları)\n• Meni kesecikleri (semen kesecikleri)\n• Prostat\n• Boşaltım yolu, idrar yolu ve meni kanalı'),
            SizedBox(height: 20),

            // Korunma Yöntemleri Başlığı
            Text(
              'Erkeğe Ait Korunma Yöntemleri',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),

            // Geri Dönebilir Yöntemler
            Text(
              '• Geri Dönebilir Yöntemler:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('• Kondom (Korunmada etkilidir.)'),
            SizedBox(height: 10),

            // Kalıcı Yöntemler
            Text(
              '• Kalıcı Yöntemler:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('• Kanalların bağlanması (vazektomi)'),
            SizedBox(height: 10),

            // Geleneksel Yöntemler
            Text(
              '• Geleneksel yöntemlerden yaygın olarak kullanılan "Geri çekme" yönteminin koruyucu etkisi yoktur.',
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 20),

            // HPV ve Kanserler Başlığı
            Text(
              'Human Papilloma Virüsü ve Erkeklerde Yaptığı Kanserler',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),

            // HPV ve Kanserler Açıklaması
            Text(
              'Human papilloma virüs (HPV), dünyada en sık görülen cinsel yol ile bulaşan enfeksiyon (CYBE) etkenidir. En sık vajinal ve anal cinsel ilişki ile ayrıca oral ilişki ile yayılır hatta cinsel ilişki olmadan sadece cilt temasıyla da bulaşma olabilir.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),

            // HPV ile İlişkili Kanserler
            Text(
              'Erkeklerde HPV ile ilişkilendirilen hastalıklar:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '1. Genital bölgede, anal kanal ve çok nadiren rektumda, nazal kavite, paranazal sinüs, orofarengeyal bölgede, larinkste, nadiren trakeobronşial mukozada ve konjonktivada siğiller\n'
                  '2. Penis kanseri\n'
                  '3. Prostat kanseri\n'
                  '4. Kısırlık (infertilite)\n'
                  '5. Anüs kanseri\n'
                  '6. Orofarenks kanseri',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
