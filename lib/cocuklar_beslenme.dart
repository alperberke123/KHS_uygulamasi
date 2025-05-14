import 'package:flutter/material.dart';

class CocukBeslenme extends StatelessWidget {
  const CocukBeslenme({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Çocuklar için Beslenme Önerileri'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Çocuklarda Sağlıklı Beslenme',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 10),
            _buildNutritionTip(
                "Beslenme Tarzı:",
                "Çocukların sağlıklı beslenmesi için dört besin grubunda bulunan çeşitli besinlerden yeterli"
                    "miktarlarda ve dengeli bir şekilde tüketmeleri gerekmektedir. Süt grubunda yer alan süt"
                    "yoğurt, et grubunda yer alan et, tavuk, yumurta, peynir, kuru baklagiller, sebze ve meyve"
                    "grubu ve tahıl grubuna giren ekmek, bulgur, makarna, pirinç vb. besinlerin her öğünde"
                    "yeterli miktarlarda tüketilmesi önerilmektedir."),
            _buildNutritionTip(
                "Yemeklerin Yapıplma Tarzı:",
                "Çocukların özellikle kemik ve diş gelişimi için günde 2-3 "
                    "su bardağı kadar süt veya yoğurt, 1 kibrit kutusu kadar "
                    "beyaz peynir tüketmeleri önemlidir. Günlük beslenme planı "
                    "içine yüksek kaliteli proteinlerden 1 yumurta, 500 ml süt "
                    "veya yoğurt, 1 köfte kadar et veya 1 porsiyon kurubaklagiller "
                    "tüketiliyorsa çocuk için protein alımı yeterlidir."),
            _buildNutritionTip(
                "Kötü Alışkanlıklar:",
                "Çocuklar için en önemli öğün kahvaltıdır. "
                    "Bütün gece süren açlıktan sonra, vücudumuz ve "
                    "beynimiz güne başlamak için enerjiye gereksinim "
                    "duymaktadır. Çocukların her sabah düzenli olarak "
                    "kahvaltı yapma alışkanlığı kazanmalarına özen gösterilmelidir. "
                    "Peynir, haşlanmış yumurta, taze meyve suyu, birkaç dilim ekmek veya "
                    "1 bardak süt, poğaça, mandalina çocuklar için yeterli ve dengeli bir "
                    "kahvaltı örneğidir."),
            _buildNutritionTip(
                "Genel Olarak Dikkat Edilmesi Gereken Şeyler:",
                " Gün boyu fiziksel ve zihinsel performansın en üst düzeyde tutulabilmesi, "
                    "düzenli olarak ara ve ana öğünlerin tüketilmesi ile mümkündür. "
                    "Bu nedenle, öğün atlanmamalıdır. Günlük tüketilecek besinlerin "
                    "3 ana, 2 ara öğünde alınması en uygun olanıdır."
                    " Yüksek oranda şeker ve şekerli besinler çocukların beslenmesi "
                    "için olumlu değildir. Şeker alımı ile iştahsızlık ve diş "
                    "çürümeleri arasında sıkı bir ilişki vardır. Bu riski azaltmak "
                    "veya en aza indirmek için şekerli içeceklerin, tatlıların, bisküvi, "
                    "çikolata gibi besinlerin fazla tüketilmemesi özellikle ara öğünlerde "
                    "çocuklara verilmemesi bu besinler yerine taze meyvelerin tüketilmesi önerilmektedir."),
            _buildNutritionTip(
                "Vitamin Mineral Alımı:",
                "Yetişkinlere ve okul çağındaki çocuklara kıyasla okul öncesi "
                    "çocukların beslenmesinde şeker besinlerle alınan enerjinin "
                    "çok daha fazlasını sağlar. Yüksek oranda şeker tüketen çocukların "
                    "beslenmelerine bakıldığında asıl şeker kaynağının meyveli şekerler, "
                    "hazır meyve suları, kolalı içecekler oluşturmaktadır. "
                    "Bu içecekler yerine taze sıkılmış meyve suları, süt, ayran vb. "
                    "içeceklerin tüketimi tercih edilmelidir."),
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
