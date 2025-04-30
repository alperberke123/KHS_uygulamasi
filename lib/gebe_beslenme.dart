import 'package:flutter/material.dart';

class GebeBeslenme extends StatelessWidget {
  const GebeBeslenme({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gebe Beslenme Önerileri'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Gebelikte Sağlıklı Beslenme',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.pinkAccent,
              ),
            ),
            const SizedBox(height: 10),
            _buildNutritionTip(
                "Beslenme Tarzı:",
                "Her gün en az 2 su bardağı kadar süt veya yoğurt tüketilmelidirler. Bu besinlerin yerine 2-3 kibrit kutusu kadar peynir veya 1-2 kaşık çökelek tüketmeleri de yararlı olacaktır. Çiğ süt ve bundan yapılan peynirler zararlı mikropları içerdiğinden pastörize süt ve bu sütlerden yapılan peynirler tercih edilmelidir. Yine anne adayları normal zamanda yediklerine ek olarak bir adet yumurta veya yumurta kadar et, tavuk, balık tüketmelidir. Bu besinler tüketilemiyorsa kurubaklagil yemekleri, mercimekli veya nohutlu çorbaların tüketilmesine özen gösterilmelidir. Vitaminler açısından zengin olan taze sebze ve meyveler her öğünde düzenli olarak tüketilmelidir. Azar azar ve sık aralıklarla beslenilmeli, uzun süre aç kalınmamalıdır."),
            _buildNutritionTip(
                "Yemeklerin Yapılma Tarzı:",
                "Yemeklerde sıvı yağlar tercih edilmelidir. Gün içinde zeytinyağı tüketmeye özen gösterilmelidir. Fasulye, nohut, mercimek gibi kuru baklagillerin yanında, C vitamini açısından zengin bol limonlu salata, taze soğan veya meyve tüketilmelidir. Yemeklerde mutlaka iyotlu tuz kullanılmalıdır. Böylelikle bebek, guatr hastalığı ve zeka geriliğinden korunmuş olur. İyotlu tuz, koyu renkli cam kavanozda saklanılmalı, ışıktan, güneşten ve nemli ortamlardan korunmalıdır. Böylelikle iyodun kayba uğraması engellenmiş olur. Yüksek tansiyon (hipertansiyon) varsa yemekler tuzsuz veya az tuzlu pişirilmelidir. Aşırı tuzlu besinler tüketilmemelidir.."),
            _buildNutritionTip(
                "Kötü Alışkanlıklar:",
                "Sigara ve alkol kesinlikle kullanılmamalıdır. Sigara içilen ortamlardan uzak durulmalıdır. Gebelikte sıvı gereksinimi artmaktadır. Bunu karşılamak için daha fazla su veya süt, ayran, taze sıkılmış meyve suları içerek sıvı alımı arttırılmalıdır. Her gün en az 10 bardak su içilmelidir. Gebelikte anemi (kansızlık) daha sık görülür. Anemiden korunmak için; yumurta, kırmızı et, kuru baklagiller, pekmez ve taze meyve-sebze gibi yiyeceklerin daha fazla tüketilmesine özen gösterilmelidir. Çay ve kahve tüketimi en aza indirilmelidir. Yemeklerden bir saat öncesi ve bir saat sonrasına kadar çay ve kahve içilmemelidir.."),
            _buildNutritionTip(
                "Genel Olarak Dikkat Edilmesi Gereken Şeyler:",
                "Tarım ürünlerindeki zararlı olabilecek kalıntıları uzaklaştırmak için, besinler, özellikle sebze ve meyveler tüketilmeden önce çok iyi yıkanmalıdır. Bu besinleri en iyi yıkama şekli; yiyecekleri su dolu bir kapta 5-10 dakika bekletmek, bu işlemi birkaç kez tekrarlamak ve sonra çeşme altında bol suda yıkamaktır. Gebelikte aşermenin hormonal etkiler sonucu gerçekleştiği bilinmektedir. Bu nedenle canın her çektiği yiyecek değil, vücut için gerekli olanlar ölçülü şekilde tüketilmelidir. Gebelik boyunca her ay 1-1.5 kg olmak üzere, toplam 7-14 kg alacak şekilde ağırlık artışı kontrol edilmelidir. Sebze ve kuru baklagillerin haşlama sularının dökülmesi, vitamin ve mineral kayıplarına neden olacağı için haşlama ve pişirme suları dökülmemelidir. Satın alırken taze besinler tercih edilmelidir."),
            _buildNutritionTip(
                "Vitamin Mineral Alımı:",
                "Ambalajlı besinlerin son kullanma tarihi ve içeriğine dikkat edilmelidir. İçeriği bilinmeyen besinler gebelik süresince tüketilmemelidir. Hamilelerde D vitamini yetersizliği, anne karnındaki bebeklerin beyin ve kemik gelişimini olumsuz etkilemekte, doğumsal katarakt hastalığı ve enfeksiyon risklerini de beraberinde getirmektedir. Bütün hamile kadınlar, yazın öğle saatleri dışında günde 10-15 dakika süreyle güneşe çıkmalıdırlar."),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.pink.shade50,
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
                    color: Colors.pinkAccent,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_back,
                  color: Colors.pinkAccent,
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
      color: Colors.pink.shade50,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.pinkAccent,
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
