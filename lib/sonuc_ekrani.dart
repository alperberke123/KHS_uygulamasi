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
  final bool isGoingToMilitary; // Askerlik durumu
  final bool isGoingToTravel; // Seyahat durumu
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
    required this.isGoingToMilitary, // Askerlik durumu
    required this.isGoingToTravel, // Seyahat durumu
    this.profession,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sonuçlar'),
        backgroundColor: Colors.blueAccent, // Mavi AppBar rengi
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Text(
              'Merhaba, $name!',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent, // Başlık rengi mavi
              ),
            ),
            const SizedBox(height: 10),
            if (!isBaby) Text('Yaş: $age', style: _infoTextStyle()),
            if (isBaby) Text('Ay olarak yaş: $ageInMonths ay', style: _infoTextStyle()),
            Text('Cinsiyet: $gender', style: _infoTextStyle()),
            if (gender == 'Kadın' && isPregnant) Text('Gebelik Durumu: Evet', style: _infoTextStyle()),
            if (!isBaby && height != null) Text('Boy: ${height?.toStringAsFixed(1)} cm', style: _infoTextStyle()),
            if (!isBaby && weight != null) Text('Kilo: ${weight?.toStringAsFixed(1)} kg', style: _infoTextStyle()),
            if (isGoingToHajjUmrah) Text('Hac/Umre: Gidecek', style: _infoTextStyle()),
            if (isGoingToMilitary) Text('Askerlik: Aşı Gerekli', style: _infoTextStyle()), // Askerlik bilgisi eklendi
            if (isGoingToTravel) Text('Seyahat: Aşı Gerekli', style: _infoTextStyle()), // Seyahat bilgisi eklendi
            if (!isBaby && profession != 'Ev hanımı') Text('Meslek: $profession', style: _infoTextStyle()),
            const SizedBox(height: 20),
            const Divider(color: Colors.blueAccent),
            const Text(
              'Yapmanız Gerekenler:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent, // Alt başlık rengi mavi
              ),
            ),
            const SizedBox(height: 10),
            _getHealthRecommendations(),
            if (height != null && weight != null) ...[
              const SizedBox(height: 20),
              const Divider(color: Colors.blueAccent),
              const Text(
                'Obezite Durumu:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent, // Alt başlık rengi mavi
                ),
              ),
              const SizedBox(height: 10),
              _getBMIResult(),
            ]
          ],
        ),
      ),
    );
  }

  TextStyle _infoTextStyle() {
    return const TextStyle(
      fontSize: 16,
      color: Colors.blueGrey, // Bilgilendirme metinleri mavi-gri
    );
  }

  // Vücut Kitle İndeksi (BMI) hesaplama ve sonuç gösterme
  Widget _getBMIResult() {
    if (height == null || weight == null) {
      return const Text('Boy ve kilo bilgisi eksik.', style: TextStyle(color: Colors.redAccent));
    }

    double heightInMeters = height! / 100; // Boyu metreye çevirme
    double bmi = weight! / (heightInMeters * heightInMeters); // BMI hesaplama

    String bmiCategory;
    if (bmi < 18.5) {
      bmiCategory = 'Zayıf';
    } else if (bmi >= 18.5 && bmi < 25.0) {
      bmiCategory = 'Normal kilolu';
    } else if (bmi >= 25.0 && bmi < 30.0) {
      bmiCategory = 'Fazla kilolu';
    } else if (bmi >= 30.0 && bmi < 40.0) {
      bmiCategory = 'Obez';
    } else {
      bmiCategory = 'İleri derecede obez (morbid obez)';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('BMI: ${bmi.toStringAsFixed(1)} kg/m²', style: _infoTextStyle()),
        Text('Durum: $bmiCategory', style: _infoTextStyle()),
      ],
    );
  }

  Widget _getHealthRecommendations() {
    List<Widget> recommendations = [];

    // Askerlik ve seyahat aşıları
    if (isGoingToMilitary) {
      recommendations.add(_buildAsiWidget("Erişkin Tip Tetanoz-Difteri (Td)", "Askerlik öncesi", "Aile Hekimliği"));
      recommendations.add(_buildAsiWidget("Menenjit Aşısı (Meningokok)", "Askerlik öncesi", "Aile Hekimliği"));
      recommendations.add(_buildAsiWidget("KKK (Kızamık-Kızamıkçık-Kabakulak)", "1980-1991 yılları arasında doğmuş olup askere gidecekler için", "Aile Hekimliği"));
      recommendations.add(_buildAsiWidget("Hep-B (Hepatit B - Eğer hiç yapılmadıysa)", "Askerlik öncesi", "Aile Hekimliği"));
    }

    if (isGoingToTravel) {
      recommendations.add(_buildAsiWidget("Sarı Humma", "Orta ve Güney Amerika ile Afrika’nın tropikal bölgelerine gidenlere zorunlu", "Aile Hekimliği"));
      recommendations.add(_buildAsiWidget("Tifo", "Seyahat öncesi", "Aile Hekimliği"));
      recommendations.add(_buildAsiWidget("Kolera", "Seyahat öncesi", "Aile Hekimliği"));
      recommendations.add(_buildAsiWidget("Hepatit A", "Seyahat öncesi", "Aile Hekimliği"));
      recommendations.add(_buildAsiWidget("Kuduz", "Seyahat öncesi", "Aile Hekimliği"));
      recommendations.add(_buildAsiWidget("Japon Ensefaliti", "Seyahat öncesi", "Aile Hekimliği"));
      recommendations.add(_buildAsiWidget("Kene Kaynaklı Ensefalit", "Seyahat öncesi", "Aile Hekimliği"));
    }

    // 0-2 yaş bebek için aşı ve taramalar (Orijinal kod)
    if (isBaby && ageInMonths != null) {
      if (ageInMonths! >= 0) {
        recommendations.add(_buildAsiWidget("Hepatit B (1. Doz)", "Doğumda", "Hastane"));
        recommendations.add(_buildTaramaWidget("Göz muayenesi ve Kırmızı Refle Testi", "0-3 Ay", "Aile Hekimliği"));
        recommendations.add(_buildTaramaWidget("Neonatal Tarama Programı (Topuk Kanı)", "Doğumdan Sonraki 24 Saat", "Hastane"));
      }
      if (ageInMonths! >= 1) {
        recommendations.add(_buildAsiWidget("Hepatit B (2. Doz)", "1. Ayın Sonu", "Aile Hekimliği"));
      }
      if (ageInMonths! >= 2) {
        recommendations.add(_buildAsiWidget("BCG (1. Doz)", "2. Ayın Sonu", "Aile Hekimliği"));
        recommendations.add(_buildAsiWidget("KPA (Konjuge Pnömokok Aşısı) (1. Doz)", "2. Ayın Sonu", "Aile Hekimliği"));
        recommendations.add(_buildAsiWidget("DaBT-İPA-Hib (Difteri, Aselüler Boğmaca, Tetanoz, İnaktif Polio, Hemofilus İnfluenza Tip B) (1. Doz)", "2. Ayın Sonu", "Aile Hekimliği"));
      }
      if (ageInMonths! >= 4) {
        recommendations.add(_buildAsiWidget("KPA (Konjuge Pnömokok Aşısı) (2. Doz)", "4. Ayın Sonu", "Aile Hekimliği"));
        recommendations.add(_buildAsiWidget("DaBT-İPA-Hib (Difteri, Aselüler Boğmaca, Tetanoz, İnaktif Polio, Hemofilus İnfluenza Tip B) (2. Doz)", "4. Ayın Sonu", "Aile Hekimliği"));
        recommendations.add(_buildTaramaWidget("Gelişimsel Kalça Displazisi (Manuel Muayene)", "30-55 Gün Arası", "Aile Hekimliği"));
        recommendations.add(_buildTaramaWidget("Gelişimsel Kalça Displazisi (USG)", "İlk 4-6 Hafta", "Hastane"));
      }
      if (ageInMonths! >= 6) {
        recommendations.add(_buildAsiWidget("Hepatit B (3. Doz)", "6. Ayın Sonu", "Aile Hekimliği"));
        recommendations.add(_buildAsiWidget("DaBT-İPA-Hib (Difteri, Aselüler Boğmaca, Tetanoz, İnaktif Polio, Hemofilus İnfluenza Tip B) (3. Doz)", "6. Ayın Sonu", "Aile Hekimliği"));
        recommendations.add(_buildAsiWidget("OPA (Oral Polio) (1. Doz)", "6. Ayın Sonu", "Aile Hekimliği"));
        recommendations.add(_buildTaramaWidget("Demir Profilaksisi", "1 mg/kg/Gün, 4-12 Ay Bebek", "Aile Hekimliği"));
        recommendations.add(_buildTaramaWidget("D Vitamini Profilaksisi", "400 Iu, 0-12 Ay Bebek", "Aile Hekimliği"));
        if (gender == 'Erkek') {
          recommendations.add(_buildTaramaWidget("İnmeyen Testis Muayenesi", "Her Muayenede, 6 Ay-1 Yaş", "Aile Hekimliği"));
        }
      }
      if (ageInMonths! >= 12) {
        recommendations.add(_buildAsiWidget("KPA (Konjuge Pnömokok Aşısı) (Rapel)", "12. Ayın Sonu", "Aile Hekimliği"));
        recommendations.add(_buildAsiWidget("Su Çiçeği (1. Doz)", "12. Ayın Sonu", "Aile Hekimliği"));
        recommendations.add(_buildAsiWidget("KKK (Kızamık-Kızamıkçık-Kabakulak) (1. Doz)", "12. Ayın Sonu", "Aile Hekimliği"));
      }
      if (ageInMonths! >= 18) {
        recommendations.add(_buildAsiWidget("DaBT-İPA-Hib (Difteri, Aselüler Boğmaca, Tetanoz, İnaktif Polio, Hemofilus İnfluenza Tip B) (Rapel)", "18. Ayın Sonu", "Aile Hekimliği"));
        recommendations.add(_buildAsiWidget("OPA (Oral Polio) (2. Doz)", "18. Ayın Sonu", "Aile Hekimliği"));
        recommendations.add(_buildAsiWidget("Hepatit A (1. Doz)", "18. Ayın Sonu", "Aile Hekimliği"));
      }
      if (ageInMonths! >= 24) {
        recommendations.add(_buildAsiWidget("Hepatit A (2. Doz)", "24. Ayın Sonu", "Aile Hekimliği"));
      }
    }
    // Diğer yaşlara göre tarama programları ve aşılar
    if (age != null && age! >= 3 && age! <= 18) {
      recommendations.add(_buildTaramaWidget("Arteriyel Tansiyon Ölçümü", "Yılda En Az 1 Kere", "Aile Hekimliği, Hastane"));
    }

    if (age != null && age! >= 6 && age! <= 18) {
      recommendations.add(_buildTaramaWidget("Obezite Taraması (BKİ / Kilo/Boy Ölçümü)", "Yılda 1 Kez", "Aile Hekimliği"));
    }

    if (age != null && age! == 3) {
      recommendations.add(_buildTaramaWidget("Flor Vernik", "Anasınıfı/İlkokul 1. sınıf, yılda 2 kez", "TSM (Toplum Sağlığı Merkezi)"));
    }

    if (age != null && age! >= 6 && age! <= 19) {
      recommendations.add(_buildTaramaWidget("Çocuk İzlem", "6, 7-9, 10-14, 15-18 yaşlar", "Aile Hekimliği"));
    }

    if (age != null && age! >= 10 && age! <= 21) {
      recommendations.add(_buildTaramaWidget("Hb/Htc Ölçümü (Hemoglobin/Hematokrit)", "10-14, 15-18, 19-21 Yaşlar", "Aile Hekimliği"));
    }

    if (age != null && age! >= 18) {
      recommendations.add(_buildTaramaWidget("Arteriyel Tansiyon Ölçümü", "Yılda En Az 1 Kere", "Aile Hekimliği, Hastane"));
    }

    if (age != null && age! >= 35) {
      recommendations.add(_buildTaramaWidget("Serum Lipid Profil (TG (Trigiliserid), LDL (Düşük yoğunluklu lipoprotein), HDL (Yüksek yoğunluklu lipoprotein))", "5 Yılda Bir", "Aile Hekimliği"));
      recommendations.add(_buildTaramaWidget("Tiroid Fonksiyon Taraması (TSH (Tiroid Stimülan Hormon))", "5 Yılda Bir", "Aile Hekimliği"));
    }

    if (age != null && age! >= 45) {
      recommendations.add(_buildTaramaWidget("Diyabet Taraması (AKŞ (Açlık Kan Şekeri), HbA1c)", "45 Yaş Üzeri", "Aile Hekimliği"));
    }

    if (age != null && age! >= 18 && age! <= 65) {
      recommendations.add(_buildTaramaWidget("Obezite Taraması (BKİ (Beden Kitle İndeksi) / Bel Çevresi Ölçümü)", "Yılda 1 Kez", "Aile Hekimliği"));
    }

    if (gender == 'Kadın' && age != null) {
      if (age! >= 35) {
        recommendations.add(_buildTaramaWidget("KKMM (Kendi Kendine Meme Muayenesi)", "Ayda 1 Kere", "35 Yaş ve Üzeri Kadınlar, KETEM (Kanser Erken Teşhis, Tarama ve Eğitim Merkezi)"));
      }
      if (age! >= 40) {
        recommendations.add(_buildTaramaWidget("Klinik Meme Muayenesi", "Yılda Bir", "40 Yaş ve Üzeri Kadınlar, Hastane"));
        recommendations.add(_buildTaramaWidget("Mamografi", "2 Yılda Bir", "40-69 Yaş Kadınlar, KETEM, Hastane"));
      }
      if (age! >= 30 && age! <= 65) {
        recommendations.add(_buildTaramaWidget("Serviks Kanser Taraması (HPV-DNA (Human Papilloma Virüs-Deoksiribo Nükleik Asit) ve Smear)", "5 Yılda Bir", "30-65 Yaş Kadınlar, KETEM, Hastane"));
      }
    }

    if (age != null && age! >= 50 && age! <= 70) {
      recommendations.add(_buildTaramaWidget("Kolon Kanser Taraması (GGK (Gaitada Gizli Kan))", "2 Yılda Bir", "50-70 Yaş, KETEM, Aile Hekimliği"));
      recommendations.add(_buildTaramaWidget("Kolon Kanser Taraması (Kolonoskopi)", "10 Yılda Bir", "50-70 Yaş, Hastane"));
    }

    if (age != null && age! >= 40) {
      recommendations.add(_buildTaramaWidget("Koroner Arter Hastalık Risk Taraması", "1 Defa", "40 Yaş Üzeri, Aile Hekimliği"));
      recommendations.add(_buildTaramaWidget("Düşük KV (Kardiyovasküler) Risk Taraması", "2 Yılda Bir", "40 Yaş Üzeri, Aile Hekimliği"));
    }

    if (age != null && age! < 40) {
      recommendations.add(_buildTaramaWidget("Koroner Arter Hastalık Risk Taraması", "1 Defa", "40 Yaş Altı, Aile Hekimliği"));
    }

    if (gender == 'Erkek' && age != null && age! >= 40 && age! <= 65) {
      recommendations.add(_buildTaramaWidget("Aspirin Kullanımı", "81 mg, 40-65 Yaş Erkekler", "Aile Hekimliği"));
    }
    if (gender == 'Kadın' && age != null && age! >= 55 && age! <= 65) {
      recommendations.add(_buildTaramaWidget("Aspirin Kullanımı", "81 mg, 55-65 Yaş Kadınlar", "Aile Hekimliği"));
    }

    if (isPregnant) {
      recommendations.add(_buildTaramaWidget("Gebelik İzlem", "İlk 14 hafta içinde, 18-24. hafta, 28-32. hafta, 36-38. hafta", "Aile Hekimliği"));
      recommendations.add(_buildTaramaWidget("D Vitamini Takviyesi", "12 Haftadan itibaren gebelikte", "Aile Hekimliği"));
      recommendations.add(_buildTaramaWidget("Demir Takviyesi", "16 Haftadan itibaren gebelikte", "Aile Hekimliği"));
    }

    if (isGoingToHajjUmrah) {
      recommendations.add(_buildAsiWidget("Meningokok Asisı", "Hac/Umreden Yaklaşık 1 Ay Önce", "Toplum Sağlığı Merkezi"));
    }

    return recommendations.isEmpty
        ? const Text('Yapmanız gereken bir işlem bulunmamaktadır.', style: TextStyle(color: Colors.blueGrey))
        : Column(children: recommendations);
  }

  Widget _buildAsiWidget(String name, String zaman, String yer) {
    return Card(
      color: Colors.lightBlue.shade50, // Mavi tonlu kart
      child: ListTile(
        title: Text(name, style: const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold)),
        subtitle: Text('Zaman: $zaman\nYer: $yer', style: const TextStyle(color: Colors.blueGrey)),
      ),
    );
  }

  Widget _buildTaramaWidget(String name, String zaman, String yer) {
    return Card(
      color: Colors.lightBlue.shade50, // Mavi tonlu kart
      child: ListTile(
        title: Text(name, style: const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold)),
        subtitle: Text('Zaman: $zaman\nYer: $yer', style: const TextStyle(color: Colors.blueGrey)),
      ),
    );
  }
}
