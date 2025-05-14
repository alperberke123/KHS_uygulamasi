import 'package:flutter/material.dart';

class KadinUreme extends StatelessWidget {
  const KadinUreme({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Kadın Üreme Sağlığı', style: TextStyle(fontSize: 24)),
        backgroundColor: Colors.pinkAccent,
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
                color: Colors.pinkAccent.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Kadın ve Üreme Sağlığı Nedir?',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.pinkAccent,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),

            // Kadın ve Üreme Sağlığı Açıklaması
            const Text(
              'Dünyada nüfus, kalkınma ve doğurganlık arasında kurulan ilişki önce “Nüfus planlaması”, ardından “Doğum kontrolü” ve “Aile planlaması” kavramlarının gelişmesine sebep olmuştur.\n'
              'Bu alanda yapılan çalışmaların kadının statüsü ile ilgili konularla ve kadının genel sağlık sorunları ile ilişkisi, kadın nüfusa odaklanılmasına ve bu kavramlara “Kadın Sağlığı” nın da eklenmesine yol açmıştır.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            // Kadın Üreme Sağlığı Başlığı
            const Text(
              'Kadın Üreme Sağlığı',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.pinkAccent,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Kadın ve erkeğin üreme sağlığı ve cinsel sağlığını bir arada ele almaktadır. Kadın ve Üreme Sağlığı, öncelikle bireylerin sağlıklı üreme haklarına saygılı, çiftlerin istedikleri zaman ve istedikleri sayıda, bakabilecekleri kadar çocuk sahibi olmalarının sağlanması, anne ölümlerinin önüne geçebilmek, güvenli anneliğin her kadın tarafından yaşanabilmesi için, kadının ömrü boyunca sağlıklı ve kaliteli yaşam sürdürebilmesi için politik, yasal ve sağlık sistemleri ile ilgili düzenlemeleri yapmasının esas alındığı faaliyetleri sürdürmektedir.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            // Üreme Sağlığı ve Aile Planlaması Başlığı
            const Text(
              'Üreme Sağlığı ve Aile Planlamasının Amaçları Nelerdir?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.pinkAccent,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '• Aşırı doğurganlığın ve buna bağlı ortaya çıkan kansızlık, jinekolojik hastalıklar, doğuma bağlı oluşabilecek rahatsızlıkların azaltılması\n'
              '• Çok ve sık gebelikleri önleyerek, çok ve sık gebeliklerin anne ve çocuk sağlığına olan olumsuz etkilerini gidermek\n'
              '• Riskli gebeliklerin önlenmesi\n'
              '• İstenmeyen gebeliklerin ve bunlara bağlı olumsuz sonuçların önlenmesi\n'
              '• Doğum yaşının ayarlanmasını sağlamak\n'
              '• Çocuğu olmayan ailelere çocuk sahibi olmaları için yol göstermek',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            // Kadın Üreme Organları Başlığı
            const Text(
              'Kadın Üreme Organları Nelerdir?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.pinkAccent,
              ),
            ),
            const SizedBox(height: 10),

            // Kadın Üreme Organları Listesi
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: const ListTile(
                title: Text(
                  'Hazne (Vajen)',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                    'Vücudun dışında iç genital organlara doğru bir geçit görevi gören, genişleyebilen bir kanaldır. Cinsel ilişki bu kanal aracılığıyla olur.'),
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
                  'Rahim (Uterus)',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                    'Rahim iç yüzü, gebeliğin yerleşmesi ve bebeğin gelişmesine uygun bir tabakayla kaplıdır. Gebelik süresince, bebek rahim içinde büyüyüp gelişir.'),
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
                  'Tüpler',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                    'Rahmin iki yanından çıkıp, yumurtalıklara kadar uzanan ince kanallardır. Yumurtalıklardan çıkan yumurtayı yakalarlar.'),
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
                  'Yumurtalıklar',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                    'Kadınlık hormonlarını ve kadın üreme hücresi olan yumurtayı üretirler.'),
              ),
            ),
            const SizedBox(height: 20),

            // Gebeliği Önleyici Modern Yöntemler Başlığı
            const Text(
              'Gebeliği Önleyici Modern Yöntemler Nelerdir?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.pinkAccent,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '• Hormonal Yöntemler\n'
              '• Kombine oral kontraseptifler (Hap)\n'
              '• Enjekte edilen kontraseptifler (İğne)\n'
              '• Vajinal halkalar\n'
              '• Minihaplar\n'
              '• Post koital haplar (Ertesi gün hapı)\n'
              '• Deri altı kapsüller (implantlar)\n'
              '• Rahim içi araçlar (Spiral)\n'
              '• Bakırlı rahim içi araçlar\n'
              '• Hormonlu rahim içi araçlar\n'
              '• Bariyer yöntemler\n'
              '• Kondom\n'
              '• Diyafram\n'
              '• Cerrahi Yöntemler\n'
              '• Tüp ligasyonu\n'
              '• Vazektomi',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            // Kadına Ait ve Erkeğe Ait Yöntemler Başlığı
            const Text(
              'Kadına Ait ve Erkeğe Ait Yöntemler',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.pinkAccent,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Kadına Ait Yöntemler:\n'
              '• Doğum kontrol hapları\n'
              '• Rahim içi araç\n'
              '• Diyafram\n'
              '• Kadın kondomu\n'
              '• Enjektabl kontraseptifler\n'
              '• Kalıcı Yöntemler\n'
              '• Tüplerin bağlanması\n\n'
              'Erkeğe Ait Yöntemler:\n'
              '• Kondom\n'
              '• Vazektomi',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            // Uyarı Başlığı
            const Text(
              'UYARI:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '• Geleneksel yöntemlerden "Geri çekme" ve "Vajinal Lavaj" yöntemlerinin koruyucu etkisi yoktur.\n'
              '• Modern aile planlaması yöntemi seçmeden önce sağlık kuruluşuna danışılmalıdır.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
