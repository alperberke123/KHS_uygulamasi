import 'package:flutter/material.dart';

class DataPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Koruyucu Sağlık Hizmetleri'),
        backgroundColor: Colors.blueAccent, // Mavi tonuyla uyumlu hale getirildi
        centerTitle: true, // Başlık ortalandı
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // İçerikleri tam genişlikte hizalar
            children: <Widget>[
              // Çocukluk Aşı Takvimi
              _buildSectionTitle("ÇOCUKLUK AŞI TAKVİMİ"),
              _buildSectionContent("""
- HEPATİT B (1. Doz) - 0. Ay (Doğumda) - Hastane
- HEPATİT B (2. Doz) - 1. Ayın Sonu - Aile Hekimliği
- BCG (1. Doz) - 2. Ayın Sonu - Aile Hekimliği
- KPA (1. Doz) - 2. Ayın Sonu - Aile Hekimliği
- DaBT-İPA-Hib (5’li karma aşı) (1. Doz) - 2. Ayın Sonu - Aile Hekimliği
- KPA (2. Doz) - 4. Ayın Sonu - Aile Hekimliği
- DaBT-İPA-Hib (5’li karma aşı) (2. Doz) - 4. Ayın Sonu - Aile Hekimliği
- HEPATİT B (3. Doz) - 6. Ayın Sonu - Aile Hekimliği
- DaBT-İPA-Hib (5’li karma aşı) (3. Doz) - 6. Ayın Sonu - Aile Hekimliği
- OPA (1. Doz) - 6. Ayın Sonu - Aile Hekimliği
- KPA (Rapel) - 12. Ayın Sonu - Aile Hekimliği
- SU ÇİÇEĞİ (1. Doz) - 12. Ayın Sonu - Aile Hekimliği
- KKK (1. Doz) - 12. Ayın Sonu - Aile Hekimliği
- DaBT-İPA-Hib (Rapel) - 18. Ayın Sonu - Aile Hekimliği
- OPA (2. Doz) - 18. Ayın Sonu - Aile Hekimliği
- HEPATİT A (1. Doz) - 18. Ayın Sonu - Aile Hekimliği
- HEPATİT A (2. Doz) - 24. Ayın Sonu - Aile Hekimliği
- KKK (2. Doz) - 48. Ay - Aile Hekimliği
- DaBT-İPA (Rapel) - 48. Ay - Aile Hekimliği
- Td (Rapel) - 13 Yaş - Aile Hekimliği
              """),

              // 15-49 Yaş Kadın/Gebe Aşılamaları
              _buildSectionTitle("15-49 YAŞ KADIN/GEBE AŞILAMALARI"),
              _buildSectionContent("""
- Td 1.Doz - Gebeliğin 4. Ayında - Aile Hekimliği
- Td 2.Doz - Td 1’den En Az 4 Hafta Sonra - Aile Hekimliği
- Td 3.Doz - Td 2’den En Az 6 Ay Sonra - Aile Hekimliği
- Td 4.Doz - Td 3’den En Az 1 Yıl Sonra Ya Da Bir Sonraki Gebelikte - Aile Hekimliği
- Td 5.Doz - Td 4’ten En Az 1 Yıl Sonra Ya Da Bir Sonraki Gebelikte - Aile Hekimliği
              """),

              // 65 Yaş Üzeri Aşılama
              _buildSectionTitle("65 YAŞ ÜZERİ KİŞİLERDE AŞILAMA"),
              _buildSectionContent("""
- Grip Aşısı (İnfluenza) - Tek Doz - Yılda 1 Kere - Aile Hekimliği
- Pnömokok Aşısı (13 Valanlı Konjuge) - Tek Doz - Aile Hekimliği
- Pnömokok Aşısı (23 Valanlı) - Tek Doz - Konjuge Aşıdan 1 Yıl Sonra - Aile Hekimliği
              """),

              // Hac-Umre Aşısı
              _buildSectionTitle("HAC-UMRE AŞISI"),
              _buildSectionContent("""
- Meningokok Aşısı - Tek Doz - Hac-Umreden Yaklaşık 1 Ay Önce - Toplum Sağlığı Merkezi
              """),

              // Neonatal Tarama Programı
              _buildSectionTitle("NEONATAL TARAMA PROGRAMI"),
              _buildSectionContent("""
- Topuk Kanı - Doğumdan Sonraki 24 Saat İçinde - Hastane
- Topuk Kanı - 3-5. Günlerde - Aile Hekimliği
              """),

              // Yenidoğan İşitme Tarama Programı
              _buildSectionTitle("YENİDOĞAN İŞİTME TARAMA PROGRAMI"),
              _buildSectionContent("""
- Her bebek - Doğum Sonrası Taburculuk Öncesi - Hastane
              """),

              // Gelişimsel Kalça Displazisi
              _buildSectionTitle("GELİŞİMSEL KALÇA DİSPLAZİSİ"),
              _buildSectionContent("""
- Manuel Muayene - 4. Bebek İzlemi - 30-55 Gün Arası - Aile Hekimliği
- Ultrasonografi (USG) - Yenidoğan - İlk 4-6 Hafta İçinde - Hastane
              """),

              // Obezite Tarama Programı
              _buildSectionTitle("OBEZİTE TARAMASI"),
              _buildSectionContent("""
- Kilo/Boy Ölçümü-BKİ hesaplaması - Yılda 1 Kez - 6-18 Yaş Arası - Aile Hekimliği
              """),

              // ÇPGD Programı
              _buildSectionTitle("ÇOCUĞUN PSİKOSOSYAL GELİŞİMİNİN DESTEKLENMESİ PROGRAMI (ÇPGD)"),
              _buildSectionContent("""
- Bilişsel Gelişim, Dil Gelişimi, Sosyal ve Duygusal Gelişim, Kaba-Motor ve İnce-Motor Gelişimin Taranması, Otizm taraması - Her İzlemde - 0-6 Yaş - Aile Hekimliği
              """),

              // Kanser Tarama Programı
              _buildSectionTitle("KANSER TARAMALARI"),
              _buildSectionContent("""
- KKMM Eğitim Sonrası (Kişinin Kendisi) - Ayda 1 Kere - 35 Yaş ve Üzeri Kadın - KETEM
- Klinik Meme Muayenesi - Yılda Bir - 40 Yaş ve Üzeri Kadın - Hastane
- Mamografi - 2 Yılda Bir - 40-69 Yaş Kadın - KETEM, Hastane
- Serviks Kanser Taraması (HPV-DNA ve Smear) - 5 Yılda Bir - 30-65 Yaş Kadın - KETEM, Hastane
- Kolon Kanser Taraması (GGK) - 2 Yılda Bir - 50-70 Yaş - KETEM, Aile Hekimliği
- Kolon Kanser Taraması (Kolonoskopi) - 10 Yılda Bir - 50-70 Yaş - Hastane
              """),

              // Koroner Arter Hastalık Riski Tarama Programı
              _buildSectionTitle("KORONER ARTER HASTALIK RİSK TARAMASI SCORE TÜRKİYE"),
              _buildSectionContent("""
- Her birey başvuru sebebinden bağımsız KV risk değerlendirmesi - 1 Defa - 40 Yaş Üzeri - Aile Hekimliği
- Düşük KV risk - 2 Yılda Bir - 40 Yaş Üzeri - Aile Hekimliği
              """),

              // Gebelere Vitamin ve Demir Takviyesi
              _buildSectionTitle("GEBELERE VİTAMİN VE DEMİR TAKVİYESİ"),
              _buildSectionContent("""
- Gebelikte D Vitamini Takviyesi - 12 Haftalıktan itibaren - 1200 IU - Aile Hekimliği
- Gebelikte Demir Takviyesi - 16 Haftalıktan itibaren - 40-60 mg - Aile Hekimliği
              """),

              // Obezite Tarama Programı (18-65 Yaş)
              _buildSectionTitle("OBEZİTE TARAMASI (18-65 YAŞ ARASI)"),
              _buildSectionContent("""
- Boy/Kilo /BKİ/Bel çevresi ölçümü - Yılda 1 Kez - 18-65 Yaş - Aile Hekimliği
              """),

              // Okul Çağı İşitme Tarama Programı
              _buildSectionTitle("OKUL ÇAĞI İŞİTME TARAMA PROGRAMI"),
              _buildSectionContent("""
- Her çocuk - İlkokul 1. Sınıf - 6-7 Yaş - TSM, SHM, İlçe SM
              """),

              // Ulusal Görme Tarama Programı
              _buildSectionTitle("ULUSAL GÖRME TARAMA PROGRAMI"),
              _buildSectionContent("""
- Göz muayenesi ve kırmızı refle testi - 0-3 Ay Bebek - Aile Hekimliği
- LEA sembol ve kırmızı refle testi - 36-48 Ay Bebek - Aile Hekimliği
- LEA sembol ve kırmızı refle testi - 6-7 Yaş Çocuk - Aile Hekimliği
              """),

              // Demir Profilaksisi
              _buildSectionTitle("DEMİR PROFİLAKSİSİ"),
              _buildSectionContent("""
- Demir - 1 mg/kg/Gün - 4-12 Ay Bebek - Aile Hekimliği
              """),

              // D Vitamini Profilaksisi
              _buildSectionTitle("D VİTAMİNİ PROFİLAKSİSİ"),
              _buildSectionContent("""
- D Vitamini - 400 Iu - 0-12 Ay Bebek - Aile Hekimliği
              """),

              // İnmemiş Testis Muayenesi
              _buildSectionTitle("İNMEMİŞ TESTİS MUAYENESİ"),
              _buildSectionContent("""
- Testis muayenesi - Her Muayenede - 6 Ay-1 Yaş - Aile Hekimliği
              """),

              // Arteriyel Tansiyon Ölçümü
              _buildSectionTitle("ARTERİYEL TANSİYON ÖLÇÜMÜ"),
              _buildSectionContent("""
- Her birey - Yılda En Az 1 Kez - 18 Yaş ve Üzeri - Aile Hekimliği, Hastane
              """),

              // Serum Lipid Profil (TG, LDL, HDL)
              _buildSectionTitle("SERUM LİPİD PROFİL (TG,LDL,HDL)"),
              _buildSectionContent("""
- Her birey - 5 Yılda Bir - 35 Yaş ve Üzeri - Aile Hekimliği
              """),

              // Diabet Taraması
              _buildSectionTitle("DİABET TARAMASI"),
              _buildSectionContent("""
- Her birey (AKŞ, HbA1c) - 45 Yaş Üzeri - Aile Hekimliği
              """),

              // Tiroit Fonksiyon Taraması
              _buildSectionTitle("TİROİD FONKSİYON TARAMASI"),
              _buildSectionContent("""
- TSH - 5 Yılda Bir - 35 Yaş Üzeri - Aile Hekimliği
              """),

              // Gebe İzlem
              _buildSectionTitle("GEBE İZLEM"),
              _buildSectionContent("""
- İlk 14 hafta içinde
- 18-24. hafta
- 28-32. hafta
- 36-38. hafta - Gebelik boyunca 4 kez - 15-49 Yaş Üreme Çağı - Aile Hekimliği
              """),

              // Yaşlılıkta Osteoporoz
              _buildSectionTitle("YAŞLILIKTA OSTEOPOROZ"),
              _buildSectionContent("""
- Biyokimyasal testler - Yılda 1 kez - 65 Yaş ve Üzeri - Aile Hekimliği, Hastane
- DEXA - 1 kez - 65 Yaş Üstü Kadın/70 Yaş Üstü Erkek
              """),

              // Ağız-Diş Sağlığı Tarama Programı
              _buildSectionTitle("AĞIZ-DİŞ SAĞLIĞI TARAMALARI"),
              _buildSectionContent("""
- Flor vernik - Anasınıfı/İlkokul 1/Yılda 2 kez - 60 ay - TSM
- Flor jel - İlkokul 2-3-4/Yılda 2 kez - 6-9 Yaş - TSM
              """),
            ],
          ),
        ),
      ),
    );
  }

  // Başlık oluşturma fonksiyonu
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent, // Başlıklara mavi renk uygulandı
        ),
        textAlign: TextAlign.center, // Başlıkları ortaladım
      ),
    );
  }

  // İçerik oluşturma fonksiyonu
  Widget _buildSectionContent(String content) {
    return Text(
      content,
      style: const TextStyle(fontSize: 16, color: Colors.black87),
      textAlign: TextAlign.start, // İçerikleri sola hizalı bıraktım
    );
  }
}
