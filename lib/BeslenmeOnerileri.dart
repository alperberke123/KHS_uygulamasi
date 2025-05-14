import 'package:flutter/material.dart';

class BeslenmeOnerileri extends StatelessWidget {
  const BeslenmeOnerileri({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beslenme Önerileri', style: TextStyle(fontSize: 24)),
        backgroundColor: Colors.greenAccent,
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
                color: Colors.greenAccent.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Toplum Beslenmesi ve Sağlıklı Beslenme',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.greenAccent,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),

            // İçerik Başlığı
            const Text(
              'Alma Ata Bildirgesi ve Sağlık',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.greenAccent,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '1978 yılında Kazakistan\'ın Alma Ata kentinde yapılan Dünya Sağlık Asamblesi toplantısında hazırlanan bildirge, sağlıkta fırsat eşitliğini vurgulamaktadır. Bu bildirgede, gelişmekte olan ülkelerde de gelişmiş ülkelerde sağlanan sağlık hizmetlerinin sağlanması gerektiği belirtilmiştir.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            // Beslenme ile İlgili Açıklamalar
            const Text(
              'Sağlıklı Beslenme ve Önemi',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.greenAccent,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Sağlıklı yaşam ve beslenme; kişilerin fiziksel ve mental gelişmesi, hastalıklara karşı direnç kazanması, yaşam kalitesinin artması için gereklidir. Beslenme davranışları, bir ülkenin sağlık harcamalarını da önemli ölçüde etkiler.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            // Beslenme Kuralları
            const Text(
              'Kaliteli ve Dengeli Beslenmenin Koşulları',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.greenAccent,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '1. Miktarda Yeterlilik: Bireylerin yaş, cinsiyet, kilo, fiziksel aktivite gibi özelliklerine göre gereksinim duyduğu besinleri yeterli miktarda alması gerekir.\n'
              '2. Çeşitlilik: Aynı besin grubundan olsa da çeşitlilik sağlanarak her grup besinden faydalanılmalıdır.\n'
              '3. Öğün Sayısı: Üç ana ve üç ara öğün tüketimi önerilmektedir.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            // Besin Grupları
            const Text(
              'Besin Grupları ve Tüketilmesi Gereken Miktarlar',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.greenAccent,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '1. Süt ve Sütten Yapılan Besinler: 2 porsiyon günde. Örnek: 1 su bardağı süt veya yoğurt.\n'
              '2. Et, Yumurta ve Kuru Baklagiller: 2-3 porsiyon günde. Örnek: 2-3 köfte kadar et.\n'
              '3. Sebzeler ve Meyveler: 5-6 porsiyon günde. Örnek: 1 orta büyüklükte elma veya 1 tabak sebze yemeği.\n'
              '4. Tahıl ve Türevleri: 1-2 porsiyon günde. Örnek: 1 ince dilim ekmek veya 3-5 yemek kaşığı pilav.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            // Diğer Besinler
            const Text(
              'Diğer Besinler ve Yağ Tüketimi',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.greenAccent,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Günlük 30 gram kadar yağ tüketilmesi önerilir. Yağların yarısı sıvı yağlardan, geri kalan yarısı ise katı yağlardan olmalıdır. Kırmızı et tüketimi fazla ise katı yağ tüketimi sınırlandırılmalıdır.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            // Yetersiz ve Dengesiz Beslenmenin Sonuçları
            const Text(
              'Yetersiz ve Dengesiz Beslenme Sonuçları',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.greenAccent,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Yetersiz ve dengesiz beslenme, toplumlarda sağlık harcamalarını artırmakta ve verimliliği azaltmaktadır. Bunun yanında, kanser, kalp-damar hastalıkları gibi sağlık problemleri de artmaktadır.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            // Beslenme Eğitimi
            const Text(
              'Beslenme Eğitimi ve Okuryazarlık',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.greenAccent,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Beslenme okuryazarlığı, besinler ve beslenmeyle ilgili doğru bilgilere erişim, değerlendirme ve sağlıklı beslenme alışkanlıklarını sürdürme yeteneğidir. Sağlıklı beslenme bilinci ve eğitimi, toplumun genel sağlık seviyesini artıracaktır.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
