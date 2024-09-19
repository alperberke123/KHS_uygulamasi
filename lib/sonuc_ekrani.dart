import 'package:flutter/material.dart';

class degerlendirme extends StatelessWidget {
  final String name;
  final int? age; // Yaş
  final int? ageInMonths; // Ay olarak yaş
  final bool isBaby;
  final String gender;
  final bool isPregnant;
  final double? height;
  final double? weight;
  final bool isGoingToHajjUmrah;
  final String? profession;

  degerlendirme({
    required this.name,
    this.age,
    this.ageInMonths,
    required this.isBaby,
    required this.gender,
    required this.isPregnant,
    this.height,
    this.weight,
    required this.isGoingToHajjUmrah,
    this.profession,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sonuçlar'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Text(
              'Merhaba, $name!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            if (!isBaby) Text('Yaş: $age'),
            if (isBaby) Text('Ay olarak yaş: $ageInMonths ay'),
            Text('Cinsiyet: $gender'),
            if (gender == 'Kadın' && isPregnant) Text('Gebelik Durumu: Evet'),
            if (!isBaby && height != null) Text('Boy: ${height?.toStringAsFixed(1)} cm'),
            if (!isBaby && weight != null) Text('Kilo: ${weight?.toStringAsFixed(1)} kg'),
            if (isGoingToHajjUmrah) Text('Hac/Umre: Gidecek'),
            if (!isBaby && profession != 'Ev hanımı') Text('Meslek: $profession'),
            SizedBox(height: 20),
            Divider(),
            Text(
              'Yapmanız Gerekenler:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _getHealthRecommendations(),
          ],
        ),
      ),
    );
  }

  Widget _getHealthRecommendations() {
    List<Widget> recommendations = [];

    // 0-2 yaş bebek için ay bazlı Asilar ve taramalar
    if (isBaby && ageInMonths != null) {
      if (ageInMonths! >= 0) {
        recommendations.add(_buildAsiWidget("Hepatit B (1. Doz)", "Doğumda", "Hastane"));
    }
    if (ageInMonths! >= 1) {
    recommendations.add(_buildAsiWidget("Hepatit B (2. Doz)", "1. Ayın Sonu", "Aile Hekimliği"));
    }
    if (ageInMonths! >= 2) {
    recommendations.add(_buildAsiWidget("BCG (1. Doz)", "2. Ayın Sonu", "Aile Hekimliği"));
    recommendations.add(_buildAsiWidget("KPA (1. Doz)", "2. Ayın Sonu", "Aile Hekimliği"));
    recommendations.add(_buildAsiWidget("DaBT-İPA-Hib (5’li karma Asi) (1. Doz)", "2. Ayın Sonu", "Aile Hekimliği"));
    }
    if (ageInMonths! >= 4) {
    recommendations.add(_buildAsiWidget("KPA (2. Doz)", "4. Ayın Sonu", "Aile Hekimliği"));
    recommendations.add(_buildAsiWidget("DaBT-İPA-Hib (5’li karma Asi) (2. Doz)", "4. Ayın Sonu", "Aile Hekimliği"));
    }
    if (ageInMonths! >= 6) {
    recommendations.add(_buildAsiWidget("Hepatit B (3. Doz)", "6. Ayın Sonu", "Aile Hekimliği"));
    recommendations.add(_buildAsiWidget("DaBT-İPA-Hib (5’li karma Asi) (3. Doz)", "6. Ayın Sonu", "Aile Hekimliği"));
    recommendations.add(_buildAsiWidget("OPA (1. Doz)", "6. Ayın Sonu", "Aile Hekimliği"));
    }
    if (ageInMonths! >= 12) {
    recommendations.add(_buildAsiWidget("KPA (Rapel)", "12. Ayın Sonu", "Aile Hekimliği"));
    recommendations.add(_buildAsiWidget("Su Çiçeği (1. Doz)", "12. Ayın Sonu", "Aile Hekimliği"));
    recommendations.add(_buildAsiWidget("KKK (1. Doz)", "12. Ayın Sonu", "Aile Hekimliği"));
    }
    if (ageInMonths! >= 18) {
    recommendations.add(_buildAsiWidget("DaBT-İPA-Hib (5’li karma Asi) (Rapel)", "18. Ayın Sonu", "Aile Hekimliği"));
    recommendations.add(_buildAsiWidget("OPA (2. Doz)", "18. Ayın Sonu", "Aile Hekimliği"));
    recommendations.add(_buildAsiWidget("Hepatit A (1. Doz)", "18. Ayın Sonu", "Aile Hekimliği"));
    }
    if (ageInMonths! >= 24) {
    recommendations.add(_buildAsiWidget("Hepatit A (2. Doz)", "24. Ayın Sonu", "Aile Hekimliği"));
    }
    }

    // 3-18 yaş arası arteriyel tansiyon ölçümü
    if (age != null && age! >= 3 && age! <= 18) {
    recommendations.add(_buildTaramaWidget("Arteriyel Tansiyon Ölçümü", "Yılda En Az 1 Kere", "Aile Hekimliği, Hastane"));
    }

    // 6-18 yaş arası obezite taraması
    if (age != null && age! >= 6 && age! <= 18) {
    recommendations.add(_buildTaramaWidget("Obezite Taraması (BKİ / Kilo/Boy Ölçümü)", "Yılda 1 Kez", "Aile Hekimliği"));
    }

    // 6-19 yaş çocuk izlem ve Hb/Htc ölçümü
    if (age != null && age! >= 6 && age! <= 19) {
    recommendations.add(_buildTaramaWidget("Çocuk İzlem", "6, 7-9, 10-14, 15-18 yaşlar", "Aile Hekimliği"));
    }
    if (age != null && age! >= 10 && age! <= 21) {
    recommendations.add(_buildTaramaWidget("Hb/Htc Ölçümü", "10-14, 15-18, 19-21 Yaşlar", "Aile Hekimliği"));
    }

    // 18 yaş ve üzeri için arteriyel tansiyon ölçümü
    if (age != null && age! >= 18) {
    recommendations.add(_buildTaramaWidget("Arteriyel Tansiyon Ölçümü", "Yılda En Az 1 Kere", "Aile Hekimliği, Hastane"));
    }

    // 35 yaş ve üzeri için serum lipid profil taraması ve tiroid fonksiyon taraması
    if (age != null && age! >= 35) {
    recommendations.add(_buildTaramaWidget("Serum Lipid Profil (TG, LDL, HDL)", "5 Yılda Bir", "Aile Hekimliği"));
    recommendations.add(_buildTaramaWidget("Tiroid Fonksiyon Taraması (TSH)", "5 Yılda Bir", "Aile Hekimliği"));
    }

    // 45 yaş ve üzeri için diyabet taraması
    if (age != null && age! >= 45) {
    recommendations.add(_buildTaramaWidget("Diyabet Taraması (AKŞ, HbA1c)", "45 Yaş Üzeri", "Aile Hekimliği"));
    }

    // 18-65 yaş arası için obezite taraması
    if (age != null && age! >= 18 && age! <= 65) {
    recommendations.add(_buildTaramaWidget("Obezite Taraması (BKİ / Bel Çevresi Ölçümü)", "Yılda 1 Kez", "Aile Hekimliği"));
    }

    // Kanser taramaları (Kadınlar için)
    if (gender == 'Kadın' && age != null) {
    if (age! >= 35) {
    recommendations.add(_buildTaramaWidget("KKMM (Kendi Kendine Meme Muayenesi)", "Ayda 1 Kere", "35 Yaş ve Üzeri Kadınlar, KETEM"));
    }
    if (age! >= 40) {
    recommendations.add(_buildTaramaWidget("Klinik Meme Muayenesi", "Yılda Bir", "40 Yaş ve Üzeri Kadınlar, Hastane"));
    recommendations.add(_buildTaramaWidget("Mamografi", "2 Yılda Bir", "40-69 Yaş Kadınlar, KETEM, Hastane"));
    }
    if (age! >= 30 && age! <= 65) {
    recommendations.add(_buildTaramaWidget("Serviks Kanser Taraması (HPV-DNA ve Smear)", "5 Yılda Bir", "30-65 Yaş Kadınlar, KETEM, Hastane"));
    }
    }

    // Kolon kanser taraması (50-70 yaş arası)
    if (age != null && age! >= 50 && age! <= 70) {
    recommendations.add(_buildTaramaWidget("Kolon Kanser Taraması (GGK)", "2 Yılda Bir", "50-70 Yaş, KETEM, Aile Hekimliği"));
    recommendations.add(_buildTaramaWidget("Kolon Kanser Taraması (Kolonoskopi)", "10 Yılda Bir", "50-70 Yaş, Hastane"));
    }

    // Koroner arter hastalık risk taraması (40 yaş ve üzeri)
    if (age != null && age! >= 40) {
    recommendations.add(_buildTaramaWidget("Koroner Arter Hastalık Risk Taraması", "1 Defa", "40 Yaş Üzeri, Aile Hekimliği"));
    recommendations.add(_buildTaramaWidget("Düşük KV Risk Taraması", "2 Yılda Bir", "40 Yaş Üzeri, Aile Hekimliği"));
    }

    // Aile hikayesinde 55 yaş ve altı KV hastalık öyküsü olanlar için
    if (age != null && age! < 40) {
    recommendations.add(_buildTaramaWidget("Koroner Arter Hastalık Risk Taraması", "1 Defa", "40 Yaş Altı, Aile Hekimliği"));
    }

    // Aspirin kullanımı (Erkekler 40-65 yaş, Kadınlar 55-65 yaş)
    if (gender == 'Erkek' && age != null && age! >= 40 && age! <= 65) {
    recommendations.add(_buildTaramaWidget("Aspirin Kullanımı", "81 mg, 40-65 Yaş Erkekler", "Aile Hekimliği"));
    }
    if (gender == 'Kadın' && age != null && age! >= 55 && age! <= 65) {
    recommendations.add(_buildTaramaWidget("Aspirin Kullanımı", "81 mg, 55-65 Yaş Kadınlar", "Aile Hekimliği"));
    }

    // Gebelik durumu
    if (isPregnant) {
    recommendations.add(_buildTaramaWidget("Gebelik İzlem", "İlk 14 hafta içinde, 18-24. hafta, 28-32. hafta, 36-38. hafta", "Aile Hekimliği"));
    recommendations.add(_buildTaramaWidget("D Vitamini Takviyesi", "12 Haftadan itibaren gebelikte", "Aile Hekimliği"));
    recommendations.add(_buildTaramaWidget("Demir Takviyesi", "16 Haftadan itibaren gebelikte", "Aile Hekimliği"));
    }

    return recommendations.isEmpty
    ? Text('Yapmanız gereken bir işlem bulunmamaktadır.')
        : Column(children: recommendations);
    }

  // Asi Widget'ı
  Widget _buildAsiWidget(String name, String zaman, String yer) {
    return Card(
      child: ListTile(
        title: Text(name),
        subtitle: Text('Zaman: $zaman\nYer: $yer'),
      ),
    );
  }

  // Tarama Widget'ı
  Widget _buildTaramaWidget(String name, String zaman, String yer) {
    return Card(
      child: ListTile(
        title: Text(name),
        subtitle: Text('Zaman: $zaman\nYer: $yer'),
      ),
    );
  }
}
