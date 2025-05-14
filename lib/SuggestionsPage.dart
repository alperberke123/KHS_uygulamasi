import 'package:flutter/material.dart';

class SuggestionsPage extends StatelessWidget {
  const SuggestionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Psikolojik Sağlamlık ve Öneriler'),
        backgroundColor: Colors.blueAccent,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Psikolojik Sağlamlık Nedir?',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Psikolojik sağlamlık, bireyin yaşamındaki stres, travma, zorluk, tehdit veya önemli değişimlerle başa çıkabilme ve bu durumlar karşısında esneklik gösterebilme becerisidir. ...',
                // Belgeden gelen ilk paragraf burada
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Psikolojik Sağlamlık İçin Pratikler ve Egzersizler',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '''
1. **Yapışkan Düşünceye Mesafe Koyma (Defusion Tekniği)**

Zihninizden geçen olumsuz bir düşünceyi ele alın: “Ben başarısız biriyim.”  
Bu düşünceyi sesli bir şekilde tekrar edin. Ardından şu şekilde söyleyin:  
“Zihnim ‘ben başarısız biriyim’ düşüncesini söylüyor.”  
Bu küçük dil değişimi bile düşünce ile aranıza mesafe koyar.

2. **Şu Anda Kalma Egzersizi (Mindfulness)**

Beş duyunuzu kullanarak anda kalın:  
- 5 şey görün,  
- 4 şey dokunun,  
- 3 şey duyun,  
- 2 şey koklayın,  
- 1 şeyin tadına odaklanın.

3. **Değerlerini Belirleme**

Kendinize şu soruları sorun:  
- Gerçekten neye önem veriyorum?  
- Hangi değerler beni ben yapar?  
- Hayatımı nasıl yaşamak isterdim?

4. **Kararlı Adım Egzersizi**

Zihniniz “Yapamazsın!” dese bile, küçük bir adım atın. Örneğin: biriyle göz teması kurmak gibi.  
Bu, korkuya rağmen eyleme geçme pratiğidir.

5. **Nefesle Bağlantı Kurma**

Günde birkaç dakika sadece nefese odaklanın. Düşünceler geldiğinde bastırmayın; fark edip nefese dönün.
                ''',
                style: TextStyle(fontSize: 16, height: 1.6),
              ),
              SizedBox(height: 20),
              Text(
                'Psikolojik Sağlamlığı Güçlendirmek Öneriler',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(height: 20),
              Text(
                '''
1. Duygularla Savaşmak Yerine Onlara Alan Tanıyın
Zor duyguları bastırmak yerine fark edin, isimlendirin, şefkatle yaklaşın.

2. Kendinize Anlamlı Sorular Sorun
“Bu yaşadığım şey bana ne öğretiyor?” gibi sorular zihinsel esnekliği güçlendirir.

3. Değerlerinize Uygun Yaşayın
Her gün küçük de olsa değerlerinize uygun bir davranışta bulunun.

4. Zihninizi Gözlemleyin, Onunla Özdeşleşmeyin
“Yetersizim” gibi düşünceler sadece zihnin ürünüdür; onlara mesafe koyun.

5. Sosyal Destek Ağınızı Güçlendirin
Güven duyduğunuz insanlarla duygularınızı paylaşın.

6. Mindfulness (Bilinçli Farkındalık) Pratiği Yapın
Kısa anlarda bile ana odaklanın, zihninizi şimdiye getirin.

7. Kendinize Nazik Davranın
Kendinizi yargılamak yerine anlayış gösterin. Bu, toparlanmayı kolaylaştırır.

                ''',
                style: TextStyle(fontSize: 16, height: 1.6),
              ),
              SizedBox(height: 20),
              Text(
                'Psikolojik Sağlamlığı Güçlendirmek İçin Detaylı Öneriler',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(height: 20),
              Text(
                '''
•	Duygulara Alan Tanıyın
Duygularınızı bastırmak yerine onları tanımayı ve kabul etmeyi öğrenin. Olumsuz duygulara “normal” yaklaşmak, onları daha sağlıklı şekilde yönetmenizi sağlar.

•	Değer Odaklı Yaşayın
Sizi siz yapan değerleri belirleyin: aile, dürüstlük, özgürlük, yardımseverlik gibi. Bu değerler doğrultusunda atılan küçük adımlar bile içsel tatmini artırır ve zorluklar karşısında ayakta kalmayı kolaylaştırır.

•	Kabul ve Kararlılık (ACT) Uygulamaları
‘Mutluluk Tuzağı’ kitabında da vurgulandığı gibi, zorluklar karşısında kaçmak yerine onları kabul ederek yaşamak ve değerler doğrultusunda harekete geçmek psikolojik sağlamlığı artırır.

•	Fiziksel Sağlığınızı İhmal Etmeyin
Yeterli uyku, dengeli beslenme, düzenli egzersiz; ruhsal sağlamlığın da temelidir. Zihin ve beden bir bütün olarak işler.

•	Düşünceyle Mücadeleyi Bırakın
Olumsuz düşüncelerle savaşmak yerine, onları sadece “zihnin düşünceleri” olarak görmek güçlü bir içsel farkındalık sağlar.

•	Zihinsel Esnekliği Geliştirin
Her şeyin kontrol edilemeyeceğini kabul etmek ve değişime açık kalmak, ruhsal esnekliğin temelidir.

•	Kendinize Merhamet Gösterin
Başarısızlık ya da hata durumunda, kendinize şefkatle yaklaşın. Kendini yargılamak yerine anlayış göstermek, iyileşmeyi hızlandırır.

•	Anlamlı Sosyal İlişkiler Kurun
Güçlü sosyal bağlar, stresle başa çıkmada en önemli koruyucu faktörlerden biridir.

•	Mindfulness (Bilinçli Farkındalık) Uygulayın
Her gün 5-10 dakika bile olsa nefes egzersizleri ve farkındalık çalışmaları yapmak ruhsal gücü artırır.

•	Amaç ve Anlam Yaratın
Hayatınıza anlam katan uğraşlara yer vermek – gönüllülük, sanat, meslek – psikolojik dayanıklılığı derinleştirir.

•	Kendinize Küçük Zaferler Tanıyın
Büyük hedeflere odaklanmak yerine küçük ilerlemeleri takdir edin.

•	Profesyonel Destek Almaktan Çekinmeyin
Bir psikolojik danışman ya da terapist ile iletişime geçmek güçlü olmanın bir göstergesidir.
               
                ''',
                style: TextStyle(fontSize: 16, height: 1.6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
