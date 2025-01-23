import 'package:flutter/material.dart';
import 'package:ksh_uygulamasi/beslenme_dusuk.dart';
import 'package:ksh_uygulamasi/beslenme_yuksek.dart';
import 'package:ksh_uygulamasi/cocuklar_beslenme.dart';
import 'package:ksh_uygulamasi/depresyon.dart';
import 'package:ksh_uygulamasi/erkekUreme.dart';
import 'package:ksh_uygulamasi/gebe_beslenme.dart';
import 'package:ksh_uygulamasi/sigara_sorulari.dart';
import 'package:ksh_uygulamasi/yasli_beslenme.dart';


class degerlendirme extends StatefulWidget {
   String name;
   int? age;
   int? ageInMonths;
   bool isBaby;
   String gender;
   bool isPregnant;
   double? height;
   double? weight;
   double? headCircumference;
   bool isGoingToHajjUmrah;
   bool isGoingToMilitary;
   bool isGoingToTravel;
   String? profession;
   int smokingScore;
   bool isMarriageApplicant;
   bool isSmoking;


  degerlendirme({
    this.name = 'Bilinmiyor',
    this.age,
    this.ageInMonths,
    required this.isBaby,
    required this.gender,
    required this.isPregnant,
    this.height,
    this.weight,
    this.headCircumference,
    required this.isGoingToHajjUmrah,
    required this.isGoingToMilitary,
    required this.isGoingToTravel,
    this.profession,
    required this.smokingScore,
    required this.isMarriageApplicant,
    required this.isSmoking,
  });

  @override
  State<degerlendirme> createState() => _degerlendirmeState();
}

class _degerlendirmeState extends State<degerlendirme> {
  void resetData() {
    setState(() {
      widget.name = 'Bilinmiyor';
      widget.age = null;
      widget.ageInMonths = null;
      widget.isBaby = false;
      widget.gender = '';
      widget.isPregnant = false;
      widget.height = null;
      widget.weight = null;
      widget.headCircumference = null;
      widget.isGoingToHajjUmrah = false;
      widget.isGoingToMilitary = false;
      widget.isGoingToTravel = false;
      widget.profession = null;
      widget.smokingScore = 0;
      widget.isMarriageApplicant = false;
      widget.isSmoking = false;
    });
  }

   Future<bool> handlePopScope() async {
     resetData(); // Verileri sıfırla
     Navigator.pop(context); // Sayfadan çık
     return Future.value(false);// Daha fazla işlem yapılmaz
   }

  String capitalizeFirstLetter(String? name) {
    if (name == null || name.isEmpty) return 'Bilinmiyor';
    return name.trim()[0].toUpperCase() + name.trim().substring(1).toLowerCase();
  }

  // Sigara bağımlılığı seviyesini hesaplama
  String getSmokingDependencyLevel() {
    if (widget.smokingScore <= 2) {
      return "Çok az bağımlılık";
    } else if (widget.smokingScore == 3 || widget.smokingScore == 4) {
      return "Az bağımlılık";
    } else if (widget.smokingScore == 5) {
      return "Orta derecede bağımlı";
    } else if (widget.smokingScore == 6 || widget.smokingScore == 7) {
      return "Yüksek bağımlılık";
    } else {
      return "Çok yüksek bağımlılık";
    }
  }

  // Kız çocuklar için kilo persentil tablosu (3 ay - 18 yaş)
  final List<List<double>> girlWeightTable = [
    [3.01, 3.29, 3.58, 3.88, 4.10, 4.35],  // 0 ay (doğum)
    [4.19, 4.45, 4.72, 5.00, 5.24, 5.55],  // 3 ay
    [5.97, 6.28, 6.61, 6.96, 7.28, 7.61],  // 6 ay
    [7.72, 8.09, 8.47, 8.87, 9.24, 9.65],  // 9 ay
    [8.86, 9.23, 9.61, 10.02, 10.39, 10.81], // 12 ay
    [10.79, 11.24, 11.74, 12.22, 12.74, 13.22],  // 18 ay
    [10.99, 11.44, 11.94, 12.49, 13.03, 13.51],  // 24 ay
    [12.06, 13.12, 14.25, 15.33, 16.47, 17.66],  // 30 ay
    [13.05, 14.18, 15.37, 16.51, 17.72, 18.93],  // 36 ay (3 yaş)
    [13.79, 15.01, 16.25, 17.45, 18.7, 19.91],   // 3.5 yaş
    [14.5, 16.0, 17.35, 18.5, 19.75, 20.95],     // 4 yaş
    [16.0, 17.3, 18.75, 19.9, 21.25, 22.4],      // 4.5 yaş
    [17.7, 19.5, 21.6, 22.9, 24.3, 26.1],        // 5 yaş
    [19.0, 21.5, 23.5, 25.5, 27.5, 29.5],        // 6 yaş
    [20.9, 23.5, 25.9, 28.3, 30.7, 33.1],        // 7 yaş
    [23.3, 26.2, 28.9, 31.6, 34.3, 36.9],        // 8 yaş
    [25.5, 28.5, 31.4, 34.4, 37.4, 40.3],        // 9 yaş
    [28.2, 31.4, 34.6, 37.8, 41.0, 44.1],        // 10 yaş
    [31.3, 34.8, 38.3, 41.8, 45.3, 48.7],        // 11 yaş
    [35.4, 39.3, 43.0, 46.7, 50.5, 54.2],        // 12 yaş
    [40.2, 44.5, 48.5, 52.4, 56.5, 60.4],        // 13 yaş
    [45.8, 50.2, 54.7, 59.2, 63.8, 68.2],        // 14 yaş
    [52.0, 56.8, 61.7, 66.4, 71.0, 75.5],        // 15 yaş
    [57.8, 62.9, 68.3, 73.4, 78.6, 83.7],        // 16 yaş
    [62.3, 67.6, 73.2, 78.5, 83.9, 89.2],        // 17 yaş
    [66.1, 71.6, 77.4, 83.0, 88.5, 94.0],        // 18 yaş
  ];

  // Erkek çocuklar için kilo persentil tablosu (3 ay - 18 yaş)
  final List<List<double>> boyWeightTable = [
    [2.58, 2.85, 3.13, 3.43, 3.73, 4.03],  // 0 ay (doğum)
    [3.23, 3.47, 3.70, 3.95, 4.18, 4.47],  // 3 ay
    [5.74, 6.09, 6.44, 6.81, 7.18, 7.56],  // 6 ay
    [7.63, 8.05, 8.50, 8.97, 9.44, 9.87],  // 9 ay
    [8.77, 9.24, 9.74, 10.24, 10.73, 11.22], // 12 ay
    [10.78, 11.45, 12.15, 12.88, 13.6, 14.31], // 18 ay
    [10.81, 11.87, 12.92, 13.95, 15.06, 16.17], // 24 ay
    [12.71, 13.80, 15.04, 16.29, 17.69, 18.97], // 30 ay
    [13.0, 14.8, 15.37, 16.52, 17.72, 18.93],   // 36 ay (3 yaş)
    [14.45, 15.5, 16.75, 17.9, 19.25, 20.4],    // 3.5 yaş
    [15.35, 17.5, 18.5, 19.75, 21.0, 22.2],     // 4 yaş
    [16.5, 18.1, 19.5, 20.75, 22.3, 23.6],      // 4.5 yaş
    [18.1, 19.95, 21.6, 23.3, 25.2, 27.0],      // 5 yaş
    [19.7, 21.9, 23.9, 25.9, 28.0, 30.0],       // 6 yaş
    [21.2, 23.5, 25.7, 28.0, 30.3, 32.5],       // 7 yaş
    [23.0, 25.5, 28.0, 30.5, 33.0, 35.4],       // 8 yaş
    [25.0, 27.7, 30.3, 32.9, 35.5, 38.1],       // 9 yaş
    [27.5, 30.8, 33.6, 36.4, 39.3, 42.0],       // 10 yaş
    [30.8, 34.3, 37.5, 40.7, 44.0, 47.2],       // 11 yaş
    [34.8, 38.4, 41.9, 45.6, 49.3, 53.0],       // 12 yaş
    [39.5, 43.3, 47.3, 51.4, 55.5, 59.7],       // 13 yaş
    [45.0, 49.1, 53.5, 57.9, 62.3, 66.7],       // 14 yaş
    [51.0, 55.5, 60.5, 65.5, 70.6, 75.6],       // 15 yaş
    [56.0, 60.5, 64.5, 68.6, 72.6, 76.5],       // 16 yaş
    [60.0, 64.6, 68.8, 73.1, 77.3, 81.5],       // 17 yaş
    [63.7, 68.3, 72.7, 77.0, 81.4, 85.8],       // 18 yaş
  ];

  // Kız çocuklar için boy persentil tablosu (3 ay - 18 yaş)
  final List<List<double>> girlHeightTable = [
    [45.6, 48.1, 49.3, 50.5, 51.7, 53.0],  // 0 ay (doğum)
    [55.6, 58.1, 59.3, 60.5, 61.7, 63.0],  // 3 ay
    [61.2, 63.5, 64.8, 66.1, 67.4, 68.8],  // 6 ay
    [67.8, 70.0, 71.4, 72.8, 74.2, 75.5],  // 9 ay
    [72.5, 75.0, 76.5, 78.0, 79.5, 81.0],  // 12 ay
    [77.5, 80.0, 81.6, 83.2, 84.8, 86.4],  // 18 ay
    [79.0, 81.5, 83.2, 84.8, 86.4, 88.0],  // 24 ay
    [89.0, 91.0, 92.5, 94.0, 95.5, 97.0],  // 36 ay (3 yaş)
    [96.0, 98.5, 100.0, 101.5, 103.0, 104.5], // 3.5 yaş
    [102.0, 105.0, 106.5, 108.0, 109.5, 111.0], // 4 yaş
    [107.0, 110.0, 111.5, 113.0, 114.5, 116.0], // 4.5 yaş
    [112.0, 115.0, 116.5, 118.0, 119.5, 121.0], // 5 yaş
    [117.0, 120.0, 121.5, 123.0, 124.5, 126.0], // 6 yaş
    [122.0, 125.0, 126.5, 128.0, 129.5, 131.0], // 7 yaş
    [126.5, 129.5, 131.0, 132.5, 134.0, 135.5], // 8 yaş
    [131.0, 134.0, 135.5, 137.0, 138.5, 140.0], // 9 yaş
    [135.5, 138.5, 140.0, 141.5, 143.0, 144.5], // 10 yaş
    [140.0, 143.0, 144.5, 146.0, 147.5, 149.0], // 11 yaş
    [145.0, 148.0, 149.5, 151.0, 152.5, 154.0], // 12 yaş
    [150.5, 153.5, 155.0, 156.5, 158.0, 159.5], // 13 yaş
    [155.5, 158.5, 160.0, 161.5, 163.0, 164.5], // 14 yaş
    [160.0, 163.0, 164.5, 166.0, 167.5, 169.0], // 15 yaş
    [164.5, 167.5, 169.0, 170.5, 172.0, 173.5], // 16 yaş
    [168.5, 171.5, 173.0, 174.5, 176.0, 177.5], // 17 yaş
    [171.5, 174.5, 176.0, 177.5, 179.0, 180.5], // 18 yaş
  ];

  // Erkek çocuklar için boy persentil tablosu (3 ay - 18 yaş)
  final List<List<double>> boyHeightTable = [
    [46.1, 48.5, 49.7, 50.9, 52.1, 53.4],  // 0 ay (doğum)
    [56.2, 58.6, 59.9, 61.2, 62.5, 63.8],  // 3 ay
    [61.2, 63.5, 64.8, 66.1, 67.4, 68.8],  // 6 ay
    [67.8, 70.0, 71.4, 72.8, 74.2, 75.5],  // 9 ay
    [73.0, 75.5, 77.0, 78.5, 80.0, 81.5],  // 12 ay
    [77.8, 80.5, 82.1, 83.8, 85.4, 87.0],  // 18 ay
    [79.0, 81.5, 83.2, 84.8, 86.4, 88.0],  // 24 ay
    [90.0, 92.0, 93.5, 95.0, 96.5, 98.0],  // 36 ay (3 yaş)
    [96.0, 98.5, 100.0, 101.5, 103.0, 104.5], // 3.5 yaş
    [102.0, 105.0, 106.5, 108.0, 109.5, 111.0], // 4 yaş
    [107.0, 110.0, 111.5, 113.0, 114.5, 116.0], // 4.5 yaş
    [112.0, 115.0, 116.5, 118.0, 119.5, 121.0], // 5 yaş
    [117.0, 120.0, 121.5, 123.0, 124.5, 126.0], // 6 yaş
    [122.0, 125.0, 126.5, 128.0, 129.5, 131.0], // 7 yaş
    [126.5, 129.5, 131.0, 132.5, 134.0, 135.5], // 8 yaş
    [131.0, 134.0, 135.5, 137.0, 138.5, 140.0], // 9 yaş
    [135.5, 138.5, 140.0, 141.5, 143.0, 144.5], // 10 yaş
    [140.0, 143.0, 144.5, 146.0, 147.5, 149.0], // 11 yaş
    [145.0, 148.0, 149.5, 151.0, 152.5, 154.0], // 12 yaş
    [150.5, 153.5, 155.0, 156.5, 158.0, 159.5], // 13 yaş
    [155.5, 158.5, 160.0, 161.5, 163.0, 164.5], // 14 yaş
    [160.0, 163.0, 164.5, 166.0, 167.5, 169.0], // 15 yaş
    [164.5, 167.5, 169.0, 170.5, 172.0, 173.5], // 16 yaş
    [168.5, 171.5, 173.0, 174.5, 176.0, 177.5], // 17 yaş
    [171.5, 174.5, 176.0, 177.5, 179.0, 180.5], // 18 yaş
  ];

  // Kız ve erkek çocuklar için baş çevresi tabloları
  final List<List<double>> girlHeadCircumferenceTable = [
    [31.0, 33.5, 34.7, 36.0, 37.2, 38.5], // 0 ay
    [37.5, 40.0, 41.2, 42.5, 43.7, 45.0], // 6 ay
    [45.5, 47.0, 48.0, 49.0, 50.0, 51.0], // 12 ay
    [49.5, 51.0, 52.0, 53.0, 54.0, 55.0], // 24 ay
  ];

  final List<List<double>> boyHeadCircumferenceTable = [
    [31.5, 34.0, 35.2, 36.5, 37.7, 39.0], // 0 ay
    [38.0, 40.5, 41.7, 43.0, 44.2, 45.5], // 6 ay
    [46.0, 47.5, 48.5, 49.5, 50.5, 51.5], // 12 ay
    [50.0, 51.5, 52.5, 53.5, 54.5, 55.5], // 24 ay
  ];

  // Verilen değerin hangi persentilde olduğunu bulan fonksiyon
  double calculatePercentile(double value, List<double> percentiles) {
    for (int i = 0; i < percentiles.length; i++) {
      if (value < percentiles[i]) {
        return (i + 1) * 10.0; // Persentil dilimi
      }
    }
    return 97.0; // En üst persentil
  }


  // Cinsiyet ve yaşa göre tablo seçimi ve persentil hesaplaması
  String calculateWeightPercentile() {
    if ((widget.ageInMonths == null && widget.age == null) || widget.weight == null) {
      return 'Veri yetersiz';
    }
    List<List<double>> selectedTable;

    // Cinsiyet ve yaşa göre tabloyu seç
    if (widget.gender == 'Kız') {
      selectedTable = girlWeightTable;
    } else {
      selectedTable = boyWeightTable;
    }

    // Yaşa göre tabloyu alıyoruz (örnek: 3 yaş = selectedTable[4])
    int index = widget.ageInMonths != null
        ? (widget.ageInMonths! ~/ 12) // Ay cinsinden yaşları yıl cinsine çeviriyoruz
        : widget.age! - 1;

    if (index < selectedTable.length) {
      double percentile = calculatePercentile(widget.weight!, selectedTable[index]);
      return '$percentile. persentil';
    }
    return 'Veri yetersiz';
  }

  // Boy persentil hesaplaması
  String calculateHeightPercentile() {
    List<List<double>> selectedTable;

    // Cinsiyet ve yaşa göre tabloyu seç
    if (widget.gender == 'Kız') {
      selectedTable = girlHeightTable;
    } else {
      selectedTable = boyHeightTable;
    }

    // Yaşa göre tabloyu alıyoruz (örnek: 3 yaş = selectedTable[4])
    int index = widget.ageInMonths != null
        ? (widget.ageInMonths! ~/ 12)
        : widget.age != null ? widget.age! - 1 : 0;

    if (index < selectedTable.length && widget.height != null) {
      double percentile = calculatePercentile(widget.height!, selectedTable[index]);
      return '$percentile. persentil';
    }
    return 'Veri yetersiz';
  }

  // Baş çevresi persentil hesaplaması
  String calculateHeadCircumferencePercentile() {
    List<List<double>> selectedTable;

    // Cinsiyet ve yaşa göre tabloyu seç
    if (widget.gender == 'Kız') {
      selectedTable = girlHeadCircumferenceTable;
    } else {
      selectedTable = boyHeadCircumferenceTable;
    }

    // Yaşa göre tabloyu alıyoruz
    int index = widget.ageInMonths != null
        ? (widget.ageInMonths! ~/ 12)
        : widget.age != null ? widget.age! - 1 : 0;

    if (index < selectedTable.length && widget.headCircumference != null) {
      double percentile = calculatePercentile(widget.headCircumference!, selectedTable[index]);
      return '$percentile. persentil';
    }
    return 'Veri yetersiz';
  }

  double calculateBMI() {
    double heightInMeters = widget.height! / 100;
    double bmi1 = widget.weight! / (heightInMeters * heightInMeters);
    return bmi1;
  }

  bool isButtonVisible_yuksek_kilo() {
    double bmi = calculateBMI();
    return bmi>=25.0;
  }

  bool isButtonVisible_dusuk_kilo() {
    double bmi = calculateBMI();
    return bmi <= 18.5;
  }

  bool isButtonVisibleDepresyon(){
    return widget.age!>=18;
  }
  bool isGenderErkek(){
    return widget.gender == 'Erkek';
  }
  bool isGenderKadin(){
    return widget.gender == 'Kadın';
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Name: ${widget.name}');
    debugPrint('Age: ${widget.age}');
    debugPrint('Age in Months: ${widget.ageInMonths}');
    debugPrint('Height: ${widget.height}');
    debugPrint('Weight: ${widget.weight}');
    debugPrint('Gender: ${widget.gender}');
    return
         Scaffold(
      appBar: AppBar(
        title: const Text('Sonuçlar'),
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () async {
            await handlePopScope(); // Verileri sıfırla ve çık
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Text(
              'Merhaba, ${capitalizeFirstLetter(widget.name)}',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),

            const SizedBox(height: 10),


            if (widget.isBaby && widget.ageInMonths != null) ...[
              Text('Ay olarak yaş: ${widget.ageInMonths} ay', style: _infoTextStyle()),
              if (widget.height != null)
                Text('Boy Persentili: ${calculatePercentile(widget.height!, [45, 50, 55, 60, 65, 70])}%', style: _infoTextStyle()),
              if (widget.weight != null)
                Text('Kilo Persentili: ${calculatePercentile(widget.weight!, [2.5, 3.0, 3.5, 4.0, 4.5])}%', style: _infoTextStyle()),
              if (widget.headCircumference != null)
                Text('Baş Çevresi Persentili: ${calculatePercentile(widget.headCircumference!, [32, 33, 34, 35, 36])}%', style: _infoTextStyle()),
            ],

            if (!widget.isBaby && widget.age != null && widget.age! <= 18) ...[
              Text('Yaş: ${widget.age}', style: _infoTextStyle()),
              if (widget.height != null)
                Text('Boy Persentili: ${calculatePercentile(widget.height!, [120, 130, 140, 150, 160, 170])}%', style: _infoTextStyle()),
              if (widget.weight != null)
                Text('Kilo Persentili: ${calculatePercentile(widget.weight!, [20, 25, 30, 35, 40, 45])}%', style: _infoTextStyle()),
            ],

            // Yaş ve Ay olarak yaş (Bebek veya Yetişkin kontrolü)
            if (!widget.isBaby && widget.age != null)
              Text('Yaş: ${widget.age}', style: _infoTextStyle()),

            if (widget.isBaby && widget.ageInMonths != null)
              Text('Ay olarak yaş: ${widget.ageInMonths} ay', style: _infoTextStyle()),

            // Eğer hem age hem de ageInMonths null ise uyarı göster
            if ((widget.isBaby && widget.ageInMonths == null) || (!widget.isBaby && widget.age == null))
              const Text('Yaş bilgisi eksik', style: TextStyle(color: Colors.redAccent)),

            // Cinsiyet
            Text('Cinsiyet: ${widget.gender}', style: _infoTextStyle()),

            // Hamilelik durumu kontrolü
            if (widget.gender == 'Kadın' && widget.isPregnant)
              Text('Gebelik Durumu: Evet', style: _infoTextStyle()),

            // Boy ve kilo kontrolleri
            if (!widget.isBaby && widget.height != null)
              Text('Boy: ${widget.height?.toStringAsFixed(1)} cm', style: _infoTextStyle()),

            if (!widget.isBaby && widget.height == null)
              const Text('Boy bilgisi eksik', style: TextStyle(color: Colors.redAccent)),

            if (!widget.isBaby && widget.weight != null)
              Text('Kilo: ${widget.weight?.toStringAsFixed(1)} kg', style: _infoTextStyle()),

            if (!widget.isBaby && widget.weight == null)
              const Text('Kilo bilgisi eksik', style: TextStyle(color: Colors.redAccent)),

            // Diğer bilgiler
            if (widget.isGoingToHajjUmrah)
              Text('Hac/Umre: Gidecek', style: _infoTextStyle()),

            if (widget.isGoingToMilitary)
              Text('Askerlik: Aşı Gerekli', style: _infoTextStyle()),

            if (widget.isGoingToTravel)
              Text('Seyahat: Aşı Gerekli', style: _infoTextStyle()),

            if (!widget.isBaby && widget.profession != 'Ev hanımı' && widget.profession != null)
              Text('Meslek: ${widget.profession}', style: _infoTextStyle()),

            // Sigara bağımlılığı testi sonucu
            const SizedBox(height: 20),
            const Divider(color: Colors.blueAccent),
            // Eğer smokingScore 0 ise, sigara bağımlılık düzeyi ile ilgili bilgileri gösterme
            if (widget.smokingScore > 0) ...[
              const Text(
                'Sigara Bağımlılık Düzeyi:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                getSmokingDependencyLevel(),
                style: _infoTextStyle(),
              ),
            ],

            if (widget.profession != null && widget.profession!.toLowerCase() == 'sağlık çalışanı') ...[
              const SizedBox(height: 20),
              const Divider(color: Colors.blueAccent),
              const Text(
                'Sağlık Çalışanları İçin Aşılar:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),

              const SizedBox(height: 10),
              _buildAsiWidget(
                  "Erişkin Tip Tetanoz-Difteri (Td)",
                  "3 Doz, Primer immünizasyon (1. doz ile 2. doz arasında en az 1 ay, 2. doz ile 3. doz arasında en az 6 ay). 10 yılda bir tekrarlanmalı.",
                  "Aile Hekimliği"
              ),
              _buildAsiWidget(
                  "Kızamık-Kızamıkçık-Kabakulak (KKK)",
                  "En az 1 ay ara ile 2 doz. Bağışıklık durumu bilinmiyorsa yapılmalı.",
                  "Aile Hekimliği"
              ),
              _buildAsiWidget(
                  "Mevsimsel İnfluenza (Grip aşısı)",
                  "Her yıl 1 doz.",
                  "Aile Hekimliği"
              ),
              _buildAsiWidget(
                  "Hepatit B",
                  "0, 1, 6 ay olmak üzere 3 doz. Antikor yanıtı kontrol edilmeli.",
                  "Aile Hekimliği"
              ),
              _buildAsiWidget(
                  "Hepatit A",
                  "6 ay ara ile 2 doz. Antikor düzeyi değerlendirilmelidir.",
                  "Aile Hekimliği"
              ),
              _buildAsiWidget(
                  "Suçiçeği",
                  "En az 4 hafta ara ile 2 doz. Aşı kaydı yoksa antikor düzeyi kontrol edilmeli.",
                  "Aile Hekimliği"
              ),
              _buildAsiWidget(
                  "Meningokok",
                  "Mikrobiyoloji laboratuvarında çalışanlar için 2 ay arayla 2 doz (55 yaş altı için), her iki aşı 5 yılda bir tekrarlanmalı.",
                  "Laboratuvar"
              ),
            ],
            const SizedBox(height: 10),
            if (widget.isMarriageApplicant) ...[
              const Divider(color: Colors.blueAccent),
              const Divider(color: Colors.blueAccent),
              const Text(
                'Evlilik Başvurusu Testleri:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 10),
              _buildTestWidget('HIV enfeksiyonları (AIDS)', 'Anti HIV Testi'),
              _buildTestWidget('Hepatit B taraması', 'HbsAg Testi'),
              _buildTestWidget('Hepatit C taraması', 'Anti HCV Testi'),
              _buildTestWidget('Sfilis (Frengi)', 'VDRL Testi'),
              _buildTestWidget('Anemi Testi', 'Hemogram (Tam Kan Sayımı)'),
              _buildTestWidget('Kan Uyuşmazlığı Testi', 'Kan Grubu Analizi'),
              _buildTestWidget('Akdeniz Anemisi (Talasemi)', 'Hemoglobin Elektroforezi Testi'),
              _buildTestWidget('SMA Tarama Testi', 'SMA Taşıyıcılık Testi'),
            ],
            const SizedBox(height: 20),
            const Text(
              'Yapmanız Gerekenler:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),

            if (widget.gender == 'Kadın' && widget.isPregnant) ...[
              const SizedBox(height: 20),
              const Text(
                '15-49 Yaş Kadın/Gebe Aşılamaları:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              _buildVaccineSchedule(
                'Td 1. Doz (Erişkin Tipi Difteri, Tetanoz)',
                'Gebeliğin 4. ayında - İlk karşılaşmada',
                'Aile Hekimliği',
              ),
              _buildVaccineSchedule(
                'Td 2. Doz (Erişkin Tipi Difteri, Tetanoz)',
                'Td 1’den en az 4 hafta sonra',
                'Aile Hekimliği',
              ),
              _buildVaccineSchedule(
                'Td 3. Doz (Erişkin Tipi Difteri, Tetanoz)',
                'Td 2’den en az 6 ay sonra',
                'Aile Hekimliği',
              ),
              _buildVaccineSchedule(
                'Td 4. Doz (Erişkin Tipi Difteri, Tetanoz)',
                'Td 3’ten en az 1 yıl sonra ya da bir sonraki gebelikte',
                'Aile Hekimliği',
              ),
              _buildVaccineSchedule(
                'Td 5. Doz (Erişkin Tipi Difteri, Tetanoz)',
                'Td 4’ten en az 1 yıl sonra ya da bir sonraki gebelikte',
                'Aile Hekimliği ve Gebe İzlem',
              ),
              const SizedBox(height: 20),
              const Text(
                'Gebe İzlem Süreçleri:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              _buildMonitoringSchedule('İlk 14 hafta içinde'),
              _buildMonitoringSchedule('18-24. hafta'),
              _buildMonitoringSchedule('28-32. hafta'),
              _buildMonitoringSchedule('36-38. hafta'),
            ],
            const SizedBox(height: 20),
            if (widget.gender == 'Kadın' && widget.isPregnant) ...[
              const Text(
              'Sağlıklı bir gebelik süreci için düzenli kontrollere devam ediniz.',
              style: TextStyle(fontSize: 16, color: Colors.blueGrey),
            ),
            ],

            _getHealthRecommendations(),
            const SizedBox(height: 10),


            Center(
              child: Visibility(
                visible: widget.isSmoking && isButtonVisibleDepresyon(),
                child: Text(
                  "Sigara Bağımlılık Testi ve Depresyon Testlerini doldurmak için aşağıdaki butonlara tıklayınız.",
                  textAlign: TextAlign.center, // Metni ortalamak için
                  style: TextStyle(
                    fontSize: 16.0, // Yazı boyutu
                    fontWeight: FontWeight.normal, // Yazı kalınlığı
                    color: Colors.black, // Yazı rengi
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Visibility(// sayfanın yenilenmesini ayarlaman lazım *********** yoksa bir kere tıklayınca değer kalıyor
              visible: widget.isSmoking,
              child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  SigaraSorulariEkrani(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Sigara Bağımlılık Düzeyi Testleri',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            ),
            const SizedBox(height: 10),
            Visibility(
              visible: isButtonVisibleDepresyon(),
                child:ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DepressionQuiz(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent,
                padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Beck Depresyon Testi ',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            ),
            const SizedBox(height: 10),
            Visibility(
              visible: isGenderErkek(),
              child:ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const erkekUreme(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Üreme Sağlığı Hakkında Bilgi Almak için Tıklayınız ',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Visibility(
              visible: isGenderKadin(),
              child:ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const erkekUreme(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Üreme Sağlığı Hakkında Bilgi Almak için Tıklayınız ',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            if (widget.height != null && widget.weight != null && widget.ageInMonths == null) ...[
              const SizedBox(height: 20),
              const Divider(color: Colors.blueAccent),
              const Text(
                'Obezite Durumu:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),

              const SizedBox(height: 10),
              _getBMIResult(),

              Visibility(
                visible: isButtonVisible_yuksek_kilo() ,
                child:ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const yuksekKilolu_hareket(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Fiziksel Hareket Önerileri İçin Tıklayınız',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              ),
              Visibility(
                visible: isButtonVisible_dusuk_kilo() ,
                child:ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const dusukKilolu_hareket(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Fiziksel Hareket Önerileri İçin Tıklayınız',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Visibility(
                visible: widget.isPregnant, // Show button only if pregnant
                child:ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GebeBeslenme(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Gebe Beslenme Önerileri',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Visibility(
                visible: widget.age != null && widget.age! > 65, // Show button only if pregnant
                child:ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const yasliBeslenme(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Yaşlılarda Beslenme Önerileri',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              Visibility(
                visible: widget.age != null && widget.age! >= 2 && widget.age!<=6, // Show button only if pregnant
                child:ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const cocukBeslenme(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Çocuklarda Beslenme Önerileri',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),


            ]
          ],
        ),
      ),

    );
  }

  TextStyle _infoTextStyle() {
    return const TextStyle(
      fontSize: 16,
      color: Colors.blueGrey,
    );
  }

  Widget _getBMIResult() {
    if (widget.height == null || widget.weight == null) {
      return const Text('Boy ve kilo bilgisi eksik.', style: TextStyle(color: Colors.redAccent));
    }

    double heightInMeters = widget.height! / 100;
    double bmi = widget.weight! / (heightInMeters * heightInMeters);

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
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildBMIRange(String category, String range, Color color) {
    return Card(
      color: color,
      child: ListTile(
        title: Text(
          category,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        subtitle: Text(range, style: const TextStyle(color: Colors.black)),
      ),
    );
  }

  Widget _getHealthRecommendations() {
    List<Widget> recommendations = [];

    // Askerlik ve seyahat aşıları
    if (widget.isGoingToMilitary) {
      recommendations.add(_buildAsiWidget("Erişkin Tip Tetanoz-Difteri (Td)", "Askerlik öncesi", "Aile Hekimliği"));
      recommendations.add(_buildAsiWidget("Menenjit Aşısı (Meningokok)", "Askerlik öncesi", "Aile Hekimliği"));
      recommendations.add(_buildAsiWidget("KKK (Kızamık-Kızamıkçık-Kabakulak)", "1980-1991 yılları arasında doğmuş olup askere gidecekler için", "Aile Hekimliği"));
      recommendations.add(_buildAsiWidget("Hep-B (Hepatit B - Eğer hiç yapılmadıysa)", "Askerlik öncesi", "Aile Hekimliği"));
    }

    if (widget.isGoingToTravel) {
      recommendations.add(_buildAsiWidget("Sarı Humma", "Orta ve Güney Amerika ile Afrika’nın tropikal bölgelerine gidenlere zorunlu", "Aile Hekimliği"));
      recommendations.add(_buildAsiWidget("Tifo", "Seyahat öncesi", "Aile Hekimliği"));
      recommendations.add(_buildAsiWidget("Kolera", "Seyahat öncesi", "Aile Hekimliği"));
      recommendations.add(_buildAsiWidget("Hepatit A", "Seyahat öncesi", "Aile Hekimliği"));
      recommendations.add(_buildAsiWidget("Kuduz", "Seyahat öncesi", "Aile Hekimliği"));
      recommendations.add(_buildAsiWidget("Japon Ensefaliti", "Seyahat öncesi", "Aile Hekimliği"));
      recommendations.add(_buildAsiWidget("Kene Kaynaklı Ensefalit", "Seyahat öncesi", "Aile Hekimliği"));
    }

    // 0-2 yaş bebek için aşı ve taramalar (Orijinal kod)
    if (widget.isBaby && widget.ageInMonths != null) {
      if (widget.ageInMonths! >= 0) {
        recommendations.add(_buildAsiWidget("Hepatit B (1. Doz)", "Doğumda", "Hastane"));
        recommendations.add(_buildTaramaWidget("Göz muayenesi ve Kırmızı Refle Testi", "0-3 Ay", "Aile Hekimliği"));
        recommendations.add(_buildTaramaWidget("Neonatal Tarama Programı (Topuk Kanı)", "Doğumdan Sonraki 24 Saat", "Hastane"));
      }
      if (widget.ageInMonths! >= 1) {
        recommendations.add(_buildAsiWidget("Hepatit B (2. Doz)", "1. Ayın Sonu", "Aile Hekimliği"));
      }
      if (widget.ageInMonths! >= 2) {
        recommendations.add(_buildAsiWidget("BCG (1. Doz)", "2. Ayın Sonu", "Aile Hekimliği"));
        recommendations.add(_buildAsiWidget("KPA (Konjuge Pnömokok Aşısı) (1. Doz)", "2. Ayın Sonu", "Aile Hekimliği"));
        recommendations.add(_buildAsiWidget("DaBT-İPA-Hib (Difteri, Aselüler Boğmaca, Tetanoz, İnaktif Polio, Hemofilus İnfluenza Tip B) (1. Doz)", "2. Ayın Sonu", "Aile Hekimliği"));
      }
      if (widget.ageInMonths! >= 4) {
        recommendations.add(_buildAsiWidget("KPA (Konjuge Pnömokok Aşısı) (2. Doz)", "4. Ayın Sonu", "Aile Hekimliği"));
        recommendations.add(_buildAsiWidget("DaBT-İPA-Hib (Difteri, Aselüler Boğmaca, Tetanoz, İnaktif Polio, Hemofilus İnfluenza Tip B) (2. Doz)", "4. Ayın Sonu", "Aile Hekimliği"));
        recommendations.add(_buildTaramaWidget("Gelişimsel Kalça Displazisi (Manuel Muayene)", "30-55 Gün Arası", "Aile Hekimliği"));
        recommendations.add(_buildTaramaWidget("Gelişimsel Kalça Displazisi (USG)", "İlk 4-6 Hafta", "Hastane"));
      }
      if (widget.ageInMonths! >= 6) {
        recommendations.add(_buildAsiWidget("Hepatit B (3. Doz)", "6. Ayın Sonu", "Aile Hekimliği"));
        recommendations.add(_buildAsiWidget("DaBT-İPA-Hib (Difteri, Aselüler Boğmaca, Tetanoz, İnaktif Polio, Hemofilus İnfluenza Tip B) (3. Doz)", "6. Ayın Sonu", "Aile Hekimliği"));
        recommendations.add(_buildAsiWidget("OPA (Oral Polio) (1. Doz)", "6. Ayın Sonu", "Aile Hekimliği"));
        recommendations.add(_buildTaramaWidget("Demir Profilaksisi", "1 mg/kg/Gün, 4-12 Ay Bebek", "Aile Hekimliği"));
        recommendations.add(_buildTaramaWidget("D Vitamini Profilaksisi", "400 Iu, 0-12 Ay Bebek", "Aile Hekimliği"));
        if (widget.gender == 'Erkek') {
          recommendations.add(_buildTaramaWidget("İnmeyen Testis Muayenesi", "Her Muayenede, 6 Ay-1 Yaş", "Aile Hekimliği"));
        }
      }
      if (widget.ageInMonths! >= 12) {
        recommendations.add(_buildAsiWidget("KPA (Konjuge Pnömokok Aşısı) (Rapel)", "12. Ayın Sonu", "Aile Hekimliği"));
        recommendations.add(_buildAsiWidget("Su Çiçeği (1. Doz)", "12. Ayın Sonu", "Aile Hekimliği"));
        recommendations.add(_buildAsiWidget("KKK (Kızamık-Kızamıkçık-Kabakulak) (1. Doz)", "12. Ayın Sonu", "Aile Hekimliği"));
      }
      if (widget.ageInMonths! >= 18) {
        recommendations.add(_buildAsiWidget("DaBT-İPA-Hib (Difteri, Aselüler Boğmaca, Tetanoz, İnaktif Polio, Hemofilus İnfluenza Tip B) (Rapel)", "18. Ayın Sonu", "Aile Hekimliği"));
        recommendations.add(_buildAsiWidget("OPA (Oral Polio) (2. Doz)", "18. Ayın Sonu", "Aile Hekimliği"));
        recommendations.add(_buildAsiWidget("Hepatit A (1. Doz)", "18. Ayın Sonu", "Aile Hekimliği"));
      }
      if (widget.ageInMonths! >= 24) {
        recommendations.add(_buildAsiWidget("Hepatit A (2. Doz)", "24. Ayın Sonu", "Aile Hekimliği"));
      }
    }

    // Diğer yaşlara göre tarama programları ve aşılar
    if (widget.age != null && widget.age! >= 3 && widget.age! <= 18) {
      recommendations.add(_buildTaramaWidget("Arteriyel Tansiyon Ölçümü", "Yılda En Az 1 Kere", "Aile Hekimliği, Hastane"));
    }

    if (widget.age != null && widget.age! >= 6 && widget.age! <= 18) {
      recommendations.add(_buildTaramaWidget("Obezite Taraması (BKİ / Kilo/Boy Ölçümü)", "Yılda 1 Kez", "Aile Hekimliği"));
    }

    if (widget.age != null && widget.age! == 3) {
      recommendations.add(_buildTaramaWidget("Flor Vernik", "Anasınıfı/İlkokul 1. sınıf, yılda 2 kez", "TSM (Toplum Sağlığı Merkezi)"));
    }

    if (widget.age != null && widget.age! >= 6 && widget.age! <= 19) {
      recommendations.add(_buildTaramaWidget("Çocuk İzlem", "6, 7-9, 10-14, 15-18 yaşlar", "Aile Hekimliği"));
    }

    if (widget.age != null && widget.age! >= 10 && widget.age! <= 21) {
      recommendations.add(_buildTaramaWidget("Hb/Htc Ölçümü (Hemoglobin/Hematokrit)", "10-14, 15-18, 19-21 Yaşlar", "Aile Hekimliği"));
    }

    if (widget.age != null && widget.age! >= 18) {
      recommendations.add(_buildTaramaWidget("Arteriyel Tansiyon Ölçümü", "Yılda En Az 1 Kere", "Aile Hekimliği, Hastane"));
    }

    if (widget.age != null && widget.age! >= 35) {
      recommendations.add(_buildTaramaWidget("Serum Lipid Profil (TG (Trigiliserid), LDL (Düşük yoğunluklu lipoprotein), HDL (Yüksek yoğunluklu lipoprotein))", "5 Yılda Bir", "Aile Hekimliği"));
      recommendations.add(_buildTaramaWidget("Tiroid Fonksiyon Taraması (TSH (Tiroid Stimülan Hormon))", "5 Yılda Bir", "Aile Hekimliği"));
    }

    if (widget.age != null && widget.age! >= 45) {
      recommendations.add(_buildTaramaWidget("Diyabet Taraması (AKŞ (Açlık Kan Şekeri), HbA1c)", "45 Yaş Üzeri", "Aile Hekimliği"));
    }

    if (widget.age != null && widget.age! >= 18 && widget.age! <= 65) {
      recommendations.add(_buildTaramaWidget("Obezite Taraması (BKİ (Beden Kitle İndeksi) / Bel Çevresi Ölçümü)", "Yılda 1 Kez", "Aile Hekimliği"));
    }

    // Meme kanseri taramaları ve muayeneleri
    if (widget.gender == 'Kadın' && widget.age != null) {
      if (widget.age! >= 35) {
        recommendations.add(_buildPembeTaramaWidget("KKMM (Kendi Kendine Meme Muayenesi)", "Ayda 1 Kere", "35 Yaş ve Üzeri Kadınlar, KETEM"));
      }
      if (widget.age! >= 40) {
        recommendations.add(_buildPembeTaramaWidget("Klinik Meme Muayenesi", "Yılda Bir", "40 Yaş ve Üzeri Kadınlar, Hastane"));
        recommendations.add(_buildPembeTaramaWidget("Mamografi", "2 Yılda Bir", "40-69 Yaş Kadınlar, KETEM, Hastane"));
      }
    }

    if (widget.gender == 'Kadın'&& widget.age != null && widget.age! >= 30 && widget.age! <= 65) {
      recommendations.add(_buildTaramaWidget("Serviks Kanser Taraması (HPV-DNA (Human Papilloma Virüs-Deoksiribo Nükleik Asit) ve Smear)", "5 Yılda Bir", "30-65 Yaş Kadınlar, KETEM, Hastane"));
    }
    if (widget.age != null && widget.age! >= 50 && widget.age! <= 70) {
      recommendations.add(_buildTaramaWidget("Kolon Kanser Taraması (GGK (Gaitada Gizli Kan))", "2 Yılda Bir", "50-70 Yaş, KETEM, Aile Hekimliği"));
      recommendations.add(_buildTaramaWidget("Kolon Kanser Taraması (Kolonoskopi)", "10 Yılda Bir", "50-70 Yaş, Hastane"));
    }

    if (widget.age != null && widget.age! >= 40) {
      recommendations.add(_buildTaramaWidget("Koroner Arter Hastalık Risk Taraması", "1 Defa", "40 Yaş Üzeri, Aile Hekimliği"));
      recommendations.add(_buildTaramaWidget("Düşük KV (Kardiyovasküler) Risk Taraması", "2 Yılda Bir", "40 Yaş Üzeri, Aile Hekimliği"));
    }

    if (widget.age != null && widget.age! < 40) {
      recommendations.add(_buildTaramaWidget("Koroner Arter Hastalık Risk Taraması", "1 Defa", "40 Yaş Altı, Aile Hekimliği"));
    }

    if (widget.gender == 'Erkek' && widget.age != null && widget.age! >= 40 && widget.age! <= 65) {
      recommendations.add(_buildTaramaWidget("Aspirin Kullanımı", "81 mg, 40-65 Yaş Erkekler", "Aile Hekimliği"));
    }
    if (widget.gender == 'Kadın' && widget.age != null && widget.age! >= 55 && widget.age! <= 65) {
      recommendations.add(_buildTaramaWidget("Aspirin Kullanımı", "81 mg, 55-65 Yaş Kadınlar", "Aile Hekimliği"));
    }

    if (widget.isPregnant) {
      recommendations.add(_buildTaramaWidget("Gebelik İzlem", "İlk 14 hafta içinde, 18-24. hafta, 28-32. hafta, 36-38. hafta", "Aile Hekimliği"));
      recommendations.add(_buildTaramaWidget("D Vitamini Takviyesi", "12 Haftadan itibaren gebelikte", "Aile Hekimliği"));
      recommendations.add(_buildTaramaWidget("Demir Takviyesi", "16 Haftadan itibaren gebelikte", "Aile Hekimliği"));
    }

    if (widget.isGoingToHajjUmrah) {
      recommendations.add(_buildAsiWidget("Meningokok Aşısı", "Hac/Umreden Yaklaşık 1 Ay Önce", "Toplum Sağlığı Merkezi"));
    }

    return recommendations.isEmpty
        ? const Text('Yapmanız gereken bir işlem bulunmamaktadır.', style: TextStyle(color: Colors.blueGrey))
        : Column(children: recommendations);
  }

  Widget _buildAsiWidget(String name, String zaman, String yer) {
    return Card(
      color: Colors.lightBlue.shade50,
      child: ListTile(
        title: Text(name, style: const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold)),
        subtitle: Text('Zaman: $zaman\nYer: $yer', style: const TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildTaramaWidget(String name, String zaman, String yer) {
    return Card(
      color: Colors.lightBlue.shade50,
      child: ListTile(
        title: Text(name, style: const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold)),
        subtitle: Text('Zaman: $zaman\nYer: $yer', style: const TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold)),
      ),
    );
  }

  // Meme ile ilgili taramalar için pembe widget
  Widget _buildPembeTaramaWidget(String name, String zaman, String yer) {
    return Card(
      color: Colors.pink.shade50, // Pembe arka plan
      child: ListTile(
        title: Text(name, style: const TextStyle(color: Colors.pink, fontWeight: FontWeight.bold)), // Pembe başlık
        subtitle: Text('Zaman: $zaman\nYer: $yer', style: const TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
Widget _buildVaccineSchedule(String title, String time, String place) {
  return Card(
    color: Colors.lightBlue.shade50,
    child: ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
      ),
      subtitle: Text(
        'Zaman: $time\nYer: $place',
        style: const TextStyle(
          color: Colors.blueGrey,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget _buildMonitoringSchedule(String time) {
  return ListTile(
    leading: const Icon(
      Icons.check_circle_outline,
      color: Colors.blueAccent,
    ),
    title: Text(
      time,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.blueGrey,
      ),
    ),
  );
}
Widget _buildTestWidget(String testName, String testDetails) {
  return Card(
    color: Colors.lightBlue.shade50,
    child: ListTile(
      title: Text(
        testName,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
      ),
      subtitle: Text(
        testDetails,
        style: const TextStyle(
          color: Colors.blueGrey,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}




