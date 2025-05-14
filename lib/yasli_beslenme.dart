import 'package:flutter/material.dart';

class YasliBeslenme extends StatelessWidget {
  const YasliBeslenme({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yaşlı Beslenme Önerileri'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Yaşlılıkta Sağlıklı Beslenme',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 10),
            _buildNutritionTip(
                "Beslenme Tarzı:",
                "Yeterli ve dengeli beslenme;"
                    "dört besin grubunda bulunan besinlerin yeterli miktarda tüketilmesiyle "
                    "sağlanır. Bu besinler; süt grubunda yer alan süt, peynir ve yoğurt; "
                    "et grubunda yer alan et, tavuk, yumurta ve kuru baklagiller; sebze ve "
                    "meyve grubu ile tahıl grubuna giren ekmek, bulgur, makarna, pirinç, mısır ve tarhanadır."
                    "Bu besinlerin önerilen tüketim miktarları kişiye özgü olarak değişmekte, bireyin yaşı, "
                    "cinsiyeti ve fiziksel aktivite durumu bu oranları etkilemektedir. "
                    "Öğün sayısı artırılmalı, az ve sık yemek yenilmelidir. "
                    "Sabah kahvaltısı mutlaka yapılmalıdır. İdeal vücut ağırlığı korunmalı, "
                    "besinler yoluyla alınan enerji ile harcanan enerji arasındaki denge sağlanmalıdır. "
                    "Yağlı besinlerin tüketimi sınırlandırılmalıdır. "
                    "Kırmızı et yerine tavuk veya hindi eti tercih edilmelidir."),
            _buildNutritionTip(
                "Yemeklerin Yapıplma Tarzı:",
                "Haftada en az 2-3 kez balık tüketilmelidir. "
                    "Hayvansal kaynaklı yağ tüketimi azaltılmalı, "
                    "bitkisel kaynaklı sıvı yağlar tercih edilmelidir. "
                    "Az yağlı veya yağsız süt ve yoğurt tüketimine özen gösterilmelidir. "
                    "Kan şekerini hemen yükselten şeker, şekerli ve hamurlu besinler yerine "
                    "muhallebi ve sütlaç gibi sütlü tatlılar tercih edilmelidir. "
                    "Özel gün ve toplantılarda pasta, tatlı ve şekerleme tüketiminden "
                    "olabildiğince kaçınılmalıdır."),
            _buildNutritionTip(
                "Kötü Alışkanlıklar:",
                "Her gün imkanlar dahilinde 5-7 porsiyon sebze ve meyve ile haftada "
                    "2-3 kez kuru baklagil yemeği tüketilmelidir. Kızartma ve kavurma "
                    "yöntemleri yerine sağlık açısından daha uygun olan haşlama, ızgara "
                    "ve fırında pişirme yöntemlerini tercih edilmelidir. "
                    "Kızartılmış besinlerden uzak durulmalıdır. "
                    "İçinde et bulunan yemekleri pişirirken ilave yağ konulmamalıdır. "
                    "Mümkün olduğunca yaşa uygun olarak fiziksel aktivite artırılmalıdır."),
            _buildNutritionTip(
                "Genel Olarak Dikkat Edilmesi Gereken Şeyler:",
                " 65 yaş üzerindeki kişilerde yoğun olarak görülen, "
                    "beyin kanamaları ve ölümlere yol açan yüksek tansiyondan "
                    "korunmak için günlük tuz tüketimi kısıtlanmalıdır. "
                    "Hazırlanmış yemeklere ilave tuz eklenilmemeli ve tuz "
                    "içeriği yüksek geleneksel besinler olan turşu ve salamuralardan u"
                    "zak durulmalıdır. 65 yaş üstü kişilerin sıvı kayıpları ile "
                    "bu kayıpların yol açtığı sağlık sorunları diğer yaş grubundaki "
                    "kişilere göre daha yüksektir. Bu nedenle yaşlı bireyler günlük sıvı "
                    "tüketimini artırmalı ve günde 8-10 su bardağı sıvı tüketmelidirler. "),
            _buildNutritionTip(
                "Vitamin Mineral Alımı:",
                "Sigara, alkol, aşırı çay ve kahve tüketimi "
                    "herkes için özellikle de yaşlı kişiler için sağlık sorunlarına "
                    "davetiye çıkarmaktadır. Ihlamur, taze sıkılmış meyve suyu, "
                    "ayran ve çorba yaşlı bireyler için uygun içeceklerdir."),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 4,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: ListTile(
                onTap: () {
                  Navigator.pop(context);
                },
                title: const Text(
                  'Geri Dön',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_back,
                  color: Colors.blueAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionTip(String title, String description) {
    return Card(
      color: Colors.blue.shade50,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        subtitle: Text(
          description,
          style: const TextStyle(
            color: Colors.blueGrey,
          ),
        ),
      ),
    );
  }
}
