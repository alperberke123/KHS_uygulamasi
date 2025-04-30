import 'package:flutter/material.dart';

class DataPage extends StatelessWidget {
  const DataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Koruyucu Sağlık Hizmetleri'),
        backgroundColor: Colors.lightGreen,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildSectionTitle("Çocukluk Aşı Takvimi"),
              _buildSectionContent("""
• Hepatit B (1. Doz) - Doğumda - Hastane

• Hepatit B (2. Doz) - 1. Ayın Sonu - Aile Hekimliği

• BCG (1. Doz) - 2. Ayın Sonu - Aile Hekimliği

• KPA (Konjuge Pnömokok Aşısı) (1. Doz) - 2. Ayın Sonu - Aile Hekimliği

• DaBT-İPA-Hib (Difteri, Aselüler Boğmaca, Tetanoz, İnaktif Polio, Hib) (1. Doz) - 2. Ayın Sonu - Aile Hekimliği

• KPA (Konjuge Pnömokok Aşısı) (2. Doz) - 4. Ayın Sonu - Aile Hekimliği

• DaBT-İPA-Hib (2. Doz) - 4. Ayın Sonu - Aile Hekimliği

• Hepatit B (3. Doz) - 6. Ayın Sonu - Aile Hekimliği

• DaBT-İPA-Hib (3. Doz) - 6. Ayın Sonu - Aile Hekimliği

• OPA (Oral Polio Aşısı) (1. Doz) - 6. Ayın Sonu - Aile Hekimliği

• KPA (Konjuge Pnömokok Aşısı) (Rapel) - 12. Ayın Sonu - Aile Hekimliği

• Su Çiçeği (1. Doz) - 12. Ayın Sonu - Aile Hekimliği

• KKK (Kızamık-Kızamıkçık-Kabakulak) (1. Doz) - 12. Ayın Sonu - Aile Hekimliği

• DaBT-İPA-Hib (Rapel) - 18. Ayın Sonu - Aile Hekimliği

• OPA (Oral Polio Aşısı) (2. Doz) - 18. Ayın Sonu - Aile Hekimliği

• Hepatit A (1. Doz) - 18. Ayın Sonu - Aile Hekimliği

• Hepatit A (2. Doz) - 24. Ayın Sonu - Aile Hekimliği

• KKK (2. Doz) - 48. Ay - Aile Hekimliği

• DaBT-İPA (Difteri, Boğmaca, Tetanoz, Polio) (Rapel) - 48. Ay - Aile Hekimliği

• Td (Erişkin Tip Difteri, Tetanoz) (Rapel) - 13 Yaş - Aile Hekimliği
              """),

              _buildSectionTitle("15-49 Yaş Kadın/Gebe Aşılamaları"),
              _buildSectionContent("""
• Td (Erişkin Tip Difteri, Tetanoz) 1. Doz - Gebeliğin 4. Ayı - Aile Hekimliği

• Td 2. Doz - İlk dozdan 4 hafta sonra - Aile Hekimliği

• Td 3. Doz - İkinci dozdan 6 ay sonra - Aile Hekimliği

• Td 4. Doz - Üçüncü dozdan 1 yıl sonra veya bir sonraki gebelikte - Aile Hekimliği

• Td 5. Doz - Dördüncü dozdan 1 yıl sonra veya bir sonraki gebelikte - Aile Hekimliği
              """),

              _buildSectionTitle("65 Yaş Üzeri Kişilerde Aşılama"),
              _buildSectionContent("""
• Grip Aşısı (İnfluenza) - Yılda 1 Doz - Aile Hekimliği

• Pnömokok Aşısı (13 Valanlı Konjuge) - Tek Doz - Aile Hekimliği

• Pnömokok Aşısı (23 Valanlı) - Konjuge aşıdan 1 yıl sonra - Aile Hekimliği
              """),

              _buildSectionTitle("Hac-Umre Aşısı"),
              _buildSectionContent("""
• Meningokok Aşısı - Tek Doz - Hac/Umre Öncesi - TSM (Toplum Sağlığı Merkezi)
              """),

              _buildSectionTitle("Neonatal Tarama Programı"),
              _buildSectionContent("""
• Topuk Kanı - Doğumdan sonra 24 saat içinde - Hastane

• Topuk Kanı - 3-5. günlerde - Aile Hekimliği
              """),

              _buildSectionTitle("Yenidoğan İşitme Tarama Programı"),
              _buildSectionContent("""
• Her bebek - Doğum sonrası taburculuk öncesi - Hastane
              """),

              _buildSectionTitle("Gelişimsel Kalça Displazisi"),
              _buildSectionContent("""
• Manuel Muayene - 30-55 gün arası - Aile Hekimliği

• Ultrasonografi (USG) - Yenidoğan - İlk 4-6 hafta içinde - Hastane
              """),

              _buildSectionTitle("Obezite Tarama Programı"),
              _buildSectionContent("""
• BKİ (Beden Kitle İndeksi) - Kilo ve boy ölçümü - Yılda 1 Kez - 6-18 yaş arası - Aile Hekimliği
              """),

              _buildSectionTitle("Çocuğun Psikososyal Gelişiminin Desteklenmesi Programı (ÇPGD)"),
              _buildSectionContent("""
• Her izlemde: Bilişsel, dil, sosyal, duygusal, kaba-motor ve ince-motor gelişimin taranması - 0-6 yaş arası - Aile Hekimliği
              """),

              _buildSectionTitle("Kanser Taramaları"),
              _buildSectionContent("""
• KKMM (Kendi Kendine Meme Muayenesi) - Ayda 1 Kere - 35 Yaş Üzeri Kadınlar - KETEM (Kanser Erken Teşhis, Tarama ve Eğitim Merkezi)

• Klinik Meme Muayenesi - Yılda Bir - 40 Yaş Üzeri Kadınlar - Hastane

• Mamografi - 2 Yılda Bir - 40-69 Yaş Kadınlar - KETEM, Hastane

• Serviks Kanser Taraması (HPV-DNA ve Smear) - 5 Yılda Bir - 30-65 Yaş Kadınlar - KETEM, Hastane

• Bağırsak Kanser Taraması (GGK) - 2 Yılda Bir - 50-70 Yaş - KETEM, Aile Hekimliği

• Bağırsak Kanser Taraması (Kolonoskopi) - 10 Yılda Bir - 50-70 Yaş - Hastane
              """),

              _buildSectionTitle("Koroner Arter Hastalık Riski Tarama Programı"),
              _buildSectionContent("""
• Her birey - KV risk değerlendirmesi - 1 Defa - 40 Yaş Üzeri - Aile Hekimliği

• Düşük KV risk - 2 Yılda Bir - 40 Yaş Üzeri - Aile Hekimliği
              """),

              _buildSectionTitle("Gebelere Vitamin ve Demir Takviyesi"),
              _buildSectionContent("""
• D Vitamini - 12. haftadan itibaren - 1200 IU - Aile Hekimliği

• Demir - 16. haftadan itibaren - 40-60 mg - Aile Hekimliği
              """),

              _buildSectionTitle("Obezite Tarama Programı (18-65 Yaş)"),
              _buildSectionContent("""
• BKİ / Kilo / Boy / Bel çevresi ölçümü - Yılda 1 Kez - 18-65 Yaş - Aile Hekimliği
              """),

              _buildSectionTitle("Okul Çağı İşitme Tarama Programı"),
              _buildSectionContent("""
• Her çocuk - İlkokul 1. Sınıf - 6-7 Yaş - TSM, SHM, İlçe SM
              """),

              _buildSectionTitle("Ulusal Görme Tarama Programı"),
              _buildSectionContent("""
• Göz muayenesi ve kırmızı refle testi - 0-3 Ay - Aile Hekimliği

• LEA sembol ve kırmızı refle testi (Görme keskinliği testi) - 36-48 Ay - Aile Hekimliği

• LEA sembol ve kırmızı refle testi (Görme keskinliği testi) - 6-7 Yaş - Aile Hekimliği
              """),

              _buildSectionTitle("Demir Profilaksisi"),
              _buildSectionContent("""
• Demir - 1 mg/kg/Gün - 4-12 Ay Bebek - Aile Hekimliği
              """),

              _buildSectionTitle("D Vitamini Profilaksisi"),
              _buildSectionContent("""
• D Vitamini - 400 IU - 0-12 Ay Bebek - Aile Hekimliği
              """),

              _buildSectionTitle("İnmemiş Testis Muayenesi"),
              _buildSectionContent("""
• Testis muayenesi - Her muayenede - 6 Ay-1 Yaş - Aile Hekimliği
              """),

              _buildSectionTitle("Arteriyel Tansiyon Ölçümü"),
              _buildSectionContent("""
• Her birey - Yılda En Az 1 Kez - 18 Yaş ve Üzeri - Aile Hekimliği, Hastane
              """),

              _buildSectionTitle("Serum Lipid Profil (TG, LDL, HDL)"),
              _buildSectionContent("""
• Serum Lipid Profil (TG, LDL, HDL) - 5 Yılda Bir - 35 Yaş ve Üzeri - Aile Hekimliği
              """),

              _buildSectionTitle("Diabet Taraması"),
              _buildSectionContent("""
• Açlık Kan Şekeri (AKŞ), HbA1c (Hemoglobin A1c) - 45 Yaş Üzeri - Aile Hekimliği
              """),

              _buildSectionTitle("Tiroit Fonksiyon Taraması"),
              _buildSectionContent("""
• TSH (Tiroid Stimülan Hormon) - 5 Yılda Bir - 35 Yaş Üzeri - Aile Hekimliği
              """),

              _buildSectionTitle("Gebe İzlem"),
              _buildSectionContent("""
• Gebelik boyunca 4 izlem: İlk 14 hafta, 18-24. hafta, 28-32. hafta, 36-38. hafta - Aile Hekimliği
              """),

              _buildSectionTitle("Yaşlılıkta Osteoporoz"),
              _buildSectionContent("""
• Biyokimyasal testler - Yılda 1 Kez - 65 Yaş ve Üzeri - Aile Hekimliği, Hastane

• DEXA (Dual-Energy X-ray Absorptiometry) - 1 Kez - 65 Yaş Üstü Kadın / 70 Yaş Üstü Erkek
              """),

              _buildSectionTitle("Ağız-Diş Sağlığı Taramaları"),
              _buildSectionContent("""
• Flor Vernik - Yılda 2 Kez - 60 Ay Çocuklar - TSM

• Flor Jel - Yılda 2 Kez - 6-9 Yaş Çocuklar - TSM
              """),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20), // Daha fazla boşluk eklendi
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.lightGreen,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15), // Her içeriğin altına boşluk eklendi
      child: Text(
        content,
        style: const TextStyle(fontSize: 16, color: Colors.black87),
        textAlign: TextAlign.start,
      ),
    );
  }
}
