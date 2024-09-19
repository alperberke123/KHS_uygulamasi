import 'package:flutter/material.dart';

class DataPage extends StatefulWidget {
  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  String? selectedGender; // Cinsiyet seçimi
  String? selectedAgeGroup; // Yaş grubu seçimi
  String? selectedCategory; // Kategori seçimi

  // Dosyadaki tüm verileri ekledik
  final List<Map<String, String>> data = [
    {'Yaş Grubu': '0-6 Yaş', 'Cinsiyet': 'Erkek', 'Kategori': 'Aşılama', 'Program': 'HEPATİT B', 'Doz': '1. Doz', 'Zaman': '0.Ay (Doğumda)', 'Yer': 'HASTANE'},
    {'Yaş Grubu': '0-6 Yaş', 'Cinsiyet': 'Erkek', 'Kategori': 'Aşılama', 'Program': 'HEPATİT B', 'Doz': '2. Doz', 'Zaman': '1. Ayın Sonu', 'Yer': 'AİLE HEKİMLİĞİ'},
    {'Yaş Grubu': '0-6 Yaş', 'Cinsiyet': 'Erkek', 'Kategori': 'Aşılama', 'Program': 'BCG', 'Doz': '1. Doz', 'Zaman': '2. Ayın Sonu', 'Yer': 'AİLE HEKİMLİĞİ'},
    {'Yaş Grubu': '6-12 Yaş', 'Cinsiyet': 'Kız', 'Kategori': 'Aşılama', 'Program': 'DaBT-İPA-Hib', 'Doz': '1. Doz', 'Zaman': '2. Ayın Sonu', 'Yer': 'AİLE HEKİMLİĞİ'},
    {'Yaş Grubu': 'Yetişkin', 'Cinsiyet': 'Kadın', 'Kategori': 'Tarama', 'Program': 'Mamografi', 'Doz': 'Tek Doz', 'Zaman': '2 Yılda 1', 'Yer': 'KETEM'},
    {'Yaş Grubu': 'Yetişkin', 'Cinsiyet': 'Kadın', 'Kategori': 'Tarama', 'Program': 'Serviks Kanser Taraması', 'Doz': 'Tek Doz', 'Zaman': '5 Yılda 1', 'Yer': 'KETEM'},
    {'Yaş Grubu': '65 Yaş Üzeri', 'Cinsiyet': 'Erkek', 'Kategori': 'Profilaksi', 'Program': 'Grip Aşısı', 'Doz': 'Tek Doz', 'Zaman': 'Yılda 1', 'Yer': 'AİLE HEKİMLİĞİ'},
    {'Yaş Grubu': '65 Yaş Üzeri', 'Cinsiyet': 'Kadın', 'Kategori': 'Profilaksi', 'Program': 'Pnömokok Aşısı', 'Doz': 'Tek Doz', 'Zaman': '5 Yılda 1', 'Yer': 'AİLE HEKİMLİĞİ'},
    // Diğer veriler buraya eklenebilir...
  ];

  @override
  Widget build(BuildContext context) {
    // Filtrelenmiş veri listesi
    List<Map<String, String>> filteredData = data.where((item) {
      return (selectedGender == null || item['Cinsiyet'] == selectedGender) &&
          (selectedAgeGroup == null || item['Yaş Grubu'] == selectedAgeGroup) &&
          (selectedCategory == null || item['Kategori'] == selectedCategory);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Koruyucu Sağlık Hizmetleri Verileri'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Yaş Grubu, Cinsiyet ve Kategori Seçimi
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    hint: Text('Yaş Grubu Seçin'),
                    value: selectedAgeGroup,
                    onChanged: (value) {
                      setState(() {
                        selectedAgeGroup = value;
                      });
                    },
                    items: ['0-6 Yaş', '6-12 Yaş', 'Yetişkin', '65 Yaş Üzeri'].map((ageGroup) {
                      return DropdownMenuItem<String>(
                        value: ageGroup,
                        child: Text(ageGroup),
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                  child: DropdownButton<String>(
                    hint: Text('Cinsiyet Seçin'),
                    value: selectedGender,
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value;
                      });
                    },
                    items: ['Erkek', 'Kadın'].map((gender) {
                      return DropdownMenuItem<String>(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                  child: DropdownButton<String>(
                    hint: Text('Kategori Seçin'),
                    value: selectedCategory,
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value;
                      });
                    },
                    items: ['Aşılama', 'Tarama', 'Profilaksi'].map((category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            // Filtrelenmiş verilerin gösterildiği tablo
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Table(
                  border: TableBorder.all(),
                  columnWidths: {
                    0: FixedColumnWidth(100.0),
                    1: FixedColumnWidth(80.0),
                    2: FixedColumnWidth(100.0),
                    3: FixedColumnWidth(150.0),
                    4: FixedColumnWidth(150.0),
                    5: FixedColumnWidth(150.0),
                  },
                  children: [
                    TableRow(
                      decoration: BoxDecoration(color: Colors.grey[300]),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Yaş Grubu', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Cinsiyet', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Kategori', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Program', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Doz', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Zaman', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    ...filteredData.map((row) {
                      return TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(row['Yaş Grubu']!),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(row['Cinsiyet']!),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(row['Kategori']!),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(row['Program']!),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(row['Doz']!),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(row['Zaman']!),
                          ),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
