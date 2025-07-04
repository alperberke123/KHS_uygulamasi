import 'package:flutter/material.dart';
import 'package:ksh_uygulamasi/her_seyi_gosteren_sayfa.dart';
import 'package:ksh_uygulamasi/hic_asi_olmadim.dart';
import 'package:ksh_uygulamasi/kuduz_temasi.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ksh_uygulamasi/sonuc_ekrani.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ksh_uygulamasi/gebe_beslenme.dart';
import 'package:ksh_uygulamasi/yasli_beslenme.dart';
import 'package:ksh_uygulamasi/cocuklar_beslenme.dart';

class Sayfa2 extends StatefulWidget {
  const Sayfa2({super.key});

  @override
  State<Sayfa2> createState() => _Sayfa2State();
}

class _Sayfa2State extends State<Sayfa2> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Map<String, dynamic>?> _loadUserData() async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        // Eğer kullanıcı oturum açmamışsa, anonim oturum aç
        UserCredential userCredential = await _auth.signInAnonymously();
        currentUser = userCredential.user;
      }

      if (currentUser != null) {
        final docSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .get();
        if (docSnapshot.exists) {
          return docSnapshot.data();
        }
      }
      return null;
    } catch (e) {
      print('Veri yüklenirken hata oluştu: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sağlığımı Takipteyim'),
        backgroundColor: Colors.lightGreen,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green.shade50, Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Değerlendirme Sonuçları Kartı
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.assessment,
                        size: 50,
                        color: Colors.lightGreen,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Değerlendirme Sonuçlarım',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightGreen,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Kaydettiğiniz bilgiler doğrultusunda değerlendirme sonuçlarınızı görüntüleyin',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.green,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          final userData = await _loadUserData();
                          if (userData != null) {
                            if (context.mounted) {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Degerlendirme(
                                    name: userData['name'] ?? 'Bilinmiyor',
                                    age: userData['age'],
                                    ageInMonths: userData['ageInMonths'],
                                    isBaby: userData['isBaby'] ?? false,
                                    gender: userData['gender'] ?? 'Belirtilmedi',
                                    isPregnant: userData['isPregnant'] ?? false,
                                    headCircumference: userData['headCircumference']?.toDouble(),
                                    height: userData['height']?.toDouble(),
                                    weight: userData['weight']?.toDouble(),
                                    isGoingToHajjUmrah: userData['isGoingToHajjUmrah'] ?? false,
                                    isGoingToMilitary: userData['isGoingToMilitary'] ?? false,
                                    isGoingToTravel: userData['isGoingToTravel'] ?? false,
                                    profession: userData['profession'],
                                    smokingScore: userData['smokingScore'] ?? 0,
                                    isMarriageApplicant: userData['isMarriageApplicant'] ?? false,
                                    isSmoking: userData['isSmoking'] ?? false,
                                  ),
                                ),
                              );
                            }
                          } else {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Henüz kayıtlı bilgi bulunmamaktadır. Lütfen önce profil bilgilerinizi giriniz.'),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightGreen,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 4,
                        ),
                        child: const Text(
                          'Değerlendirme Sonuçlarına Giriş',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                // Diğer Seçenekler Grid
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: [
                    _buildGridCard(
                      "Kuduz Riskli Temas",
                      Icons.pets,
                      () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const KuduzTemasi()));
                      },
                    ),
                    _buildGridCard(
                      "Hiç Aşı Olmadım",
                      Icons.vaccines,
                      () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AsiOlmadim()));
                      },
                    ),
                    _buildGridCard(
                      "Genel Bilgi",
                      Icons.info_outline,
                      () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DataPage()));
                      },
                    ),
                  ],
                ),
                StepCard(),
                SizedBox(height: 10),
                PortionCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGridCard(String title, IconData icon, VoidCallback onTap) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.green.shade50, Colors.white],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: Colors.lightGreen,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StepCard extends StatefulWidget {
  @override
  _StepCardState createState() => _StepCardState();
}

class _StepCardState extends State<StepCard> {
  final TextEditingController _stepController = TextEditingController();
  bool _isLoading = false;
  String? _userName;
  int _todaySteps = 0;
  String? _todayDocId;

  @override
  void initState() {
    super.initState();
    _fetchUserNameAndTodaySteps();
  }

  Future<void> _fetchUserNameAndTodaySteps() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    setState(() {
      _userName = userDoc.data()?['name'] ?? '';
    });
    final now = DateTime.now();
    final dateString = "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
    final query = await FirebaseFirestore.instance.collection('steps')
      .where('userId', isEqualTo: user.uid)
      .where('date', isEqualTo: dateString)
      .get();
    if (query.docs.isNotEmpty) {
      // Birden fazla belge varsa, hepsinin adım sayılarını topla ve ilk belgeye yaz, diğerlerini sil
      int totalSteps = 0;
      for (var doc in query.docs) {
        totalSteps += (doc.data()['steps'] ?? 0) as int;
      }
      // İlk belgeye toplamı yaz, diğerlerini sil
      final firstDoc = query.docs.first;
      await FirebaseFirestore.instance.collection('steps').doc(firstDoc.id).update({'steps': totalSteps});
      for (int i = 1; i < query.docs.length; i++) {
        await FirebaseFirestore.instance.collection('steps').doc(query.docs[i].id).delete();
      }
      setState(() {
        _todaySteps = totalSteps;
        _todayDocId = firstDoc.id;
      });
    } else {
      setState(() {
        _todaySteps = 0;
        _todayDocId = null;
      });
    }
  }

  Future<void> _showInfoDialog(String message) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Text(message, textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Tamam'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreen,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveStep() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Kullanıcı oturumu bulunamadı!"))
      );
      return;
    }
    final stepText = _stepController.text.trim();
    if (stepText.isEmpty || int.tryParse(stepText) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Lütfen geçerli bir adım sayısı giriniz."))
      );
      return;
    }
    final steps = int.parse(stepText);
    setState(() { _isLoading = true; });
    final now = DateTime.now();
    final dateString = "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
    // O gün için tüm belgeleri çek
    final query = await FirebaseFirestore.instance.collection('steps')
      .where('userId', isEqualTo: user.uid)
      .where('date', isEqualTo: dateString)
      .get();
    if (query.docs.isNotEmpty) {
      // Birden fazla belge varsa, hepsinin adım sayılarını topla ve ilk belgeye ekle, diğerlerini sil
      int totalSteps = steps;
      for (var doc in query.docs) {
        totalSteps += (doc.data()['steps'] ?? 0) as int;
      }
      final firstDoc = query.docs.first;
      await FirebaseFirestore.instance.collection('steps').doc(firstDoc.id).update({
        'steps': totalSteps,
        'timestamp': FieldValue.serverTimestamp(),
      });
      for (int i = 1; i < query.docs.length; i++) {
        await FirebaseFirestore.instance.collection('steps').doc(query.docs[i].id).delete();
      }
      setState(() { _todaySteps = totalSteps; _todayDocId = firstDoc.id; });
    } else {
      // Yoksa yeni kayıt oluştur
      final docRef = await FirebaseFirestore.instance.collection('steps').add({
        'userId': user.uid,
        'userName': _userName ?? '',
        'date': dateString,
        'steps': steps,
        'timestamp': FieldValue.serverTimestamp(),
      });
      setState(() { _todaySteps = steps; _todayDocId = docRef.id; });
    }
    setState(() { _isLoading = false; });
    _stepController.clear();
    // Motive edici mesajlar
    String message = '';
    if (_todaySteps >= 10000) {
      message = 'Harikasınız! Bugün 10000+ adım attınız!';
    } else if (_todaySteps >= 6000) {
      message = 'Tebrikler! 6000+ adım attınız!';
    } else if (_todaySteps >= 3000) {
      message = 'Güzel! 3000+ adım attınız, devam edin!';
    } else {
      message = 'Daha fazla hareket etmeye çalışın!';
    }
    await _showInfoDialog(message);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 18),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.directions_walk, color: Colors.lightGreen, size: 32),
                SizedBox(width: 10),
                Text(
                  "Günlük Adım Sayınızı Girin",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.green[700]),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              "Bugünkü toplam adımınız: $_todaySteps",
              style: TextStyle(fontSize: 15, color: Colors.green[800], fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _stepController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Adım Sayısı",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _saveStep,
                child: _isLoading
                    ? SizedBox(height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : Text("Kaydet", style: TextStyle(fontSize: 15)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PortionCard extends StatefulWidget {
  @override
  _PortionCardState createState() => _PortionCardState();
}

class _PortionCardState extends State<PortionCard> {
  final TextEditingController _dairyController = TextEditingController();
  final TextEditingController _proteinController = TextEditingController();
  final TextEditingController _vegFruitController = TextEditingController();
  final TextEditingController _carbController = TextEditingController();
  final TextEditingController _waterController = TextEditingController();
  bool _isLoading = false;
  String? _userName;
  Map<String, dynamic> _todayPortions = {
    'dairy': 0,
    'protein': 0,
    'vegFruit': 0,
    'carb': 0,
    'water': 0.0,
  };
  String? _todayDocId;
  bool _isPregnant = false;
  int? _age;

  @override
  void initState() {
    super.initState();
    _fetchUserNameAndTodayPortions();
  }

  Future<void> _fetchUserNameAndTodayPortions() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    setState(() {
      _userName = userDoc.data()?['name'] ?? '';
      _isPregnant = userDoc.data()?['isPregnant'] ?? false;
      _age = userDoc.data()?['age'];
    });
    final now = DateTime.now();
    final dateString = "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
    final query = await FirebaseFirestore.instance.collection('portions')
      .where('userId', isEqualTo: user.uid)
      .where('date', isEqualTo: dateString)
      .get();
    if (query.docs.isNotEmpty) {
      int dairy = 0, protein = 0, vegFruit = 0, carb = 0;
      double water = 0.0;
      for (var doc in query.docs) {
        dairy += (doc.data()['dairy'] ?? 0) as int;
        protein += (doc.data()['protein'] ?? 0) as int;
        vegFruit += (doc.data()['vegFruit'] ?? 0) as int;
        carb += (doc.data()['carb'] ?? 0) as int;
        water += (doc.data()['water'] ?? 0).toDouble();
      }
      final firstDoc = query.docs.first;
      await FirebaseFirestore.instance.collection('portions').doc(firstDoc.id).update({
        'dairy': dairy,
        'protein': protein,
        'vegFruit': vegFruit,
        'carb': carb,
        'water': water,
      });
      for (int i = 1; i < query.docs.length; i++) {
        await FirebaseFirestore.instance.collection('portions').doc(query.docs[i].id).delete();
      }
      setState(() {
        _todayPortions = {
          'dairy': dairy,
          'protein': protein,
          'vegFruit': vegFruit,
          'carb': carb,
          'water': water,
        };
        _todayDocId = firstDoc.id;
      });
    } else {
      setState(() {
        _todayPortions = {
          'dairy': 0,
          'protein': 0,
          'vegFruit': 0,
          'carb': 0,
          'water': 0.0,
        };
        _todayDocId = null;
      });
    }
  }

  Future<void> _showInfoDialog(String message) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Text(message, textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Tamam'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreen,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showPortionInfo() async {
    await _showInfoDialog(
      'Süt grubu: (1 porsiyon: 1 orta boy su bardağı süt ya da yoğurt, 1 kase sütten yapılan tatlı, 2 kibrit kutusu büyüklüğünde peynir)\n\n'
      'Et, yumurta ve kuru baklagiller grubu: (1 porsiyon: 2-3 köfte kadar et, balık, tavuk; 2 adet yumurta, 1 tabak kuru baklagil yemeği ve 1 tabak etli ya da kıymalı sebze yemeği)\n\n'
      'Sebze ve meyve: (1 porsiyon: 1 orta büyüklükteki elma, portakal, yarım su bardağı çilek, kiraz vb., 3-6 adet kayısı, erik gibi meyveler ve 1 tabak sebze yemeği, 1 tabak salata)\n\n'
      'Karbonhidratlar (Tahıl ve türevleri): (1 porsiyon: 1 ince dilim ekmek, 3-5 yemek kaşığı pilav, makarna, 3-4 adet kalem böreği ve 1 orta dilim tepsi böreği)\n\n'
      'Su: 1 su bardağı 200ml'
    );
  }

  bool get _shouldShowPregnant => _isPregnant == true;
  bool get _shouldShowElderly => _age != null && _age! >= 65;
  bool get _shouldShowChild => _age != null && _age! <= 6;
  bool get _shouldDisableInputs => _shouldShowPregnant || _shouldShowElderly || _shouldShowChild;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _shouldDisableInputs ? 0.5 : 1.0,
      child: Card(
        margin: EdgeInsets.only(bottom: 18),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.restaurant, color: Colors.lightGreen, size: 32),
                  SizedBox(width: 10),
                  Text(
                    "Günlük Porsiyon Takibi",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.green[700]),
                  ),
                  Spacer(),
                   Row( // This nested Row groups the "Porsiyon Bilgisi" text and info icon
          children: [
            Text(
              "Porsiyon Bilgisi",
              style: TextStyle(fontSize: 14, color: Colors.lightGreen),
            ),
            SizedBox(width: 5), // Optional: Add a small space between text and icon
            IconButton(
              icon: Icon(Icons.info_outline, color: Colors.lightGreen),
              tooltip: 'Porsiyon Bilgisi',
              onPressed: _shouldDisableInputs ? null : _showPortionInfo,
            ),
          ],
        ),
      ],
    ),
              SizedBox(height: 8),
              Text(
                "Bugünkü toplam: Süt grubu: "+_todayPortions['dairy'].toString()+", Et-yumurta-baklagil: "+_todayPortions['protein'].toString()+", Sebze-meyve: "+_todayPortions['vegFruit'].toString()+", Karbonhidratlar: "+_todayPortions['carb'].toString()+", Su: "+_todayPortions['water'].toString()+" ml",
                style: TextStyle(fontSize: 15, color: Colors.green[800], fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10),
              if (_shouldShowPregnant)
                _buildRedirectButton(
                  label: 'Gebe Beslenme Önerileri',
                  color: Colors.pinkAccent,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => GebeBeslenme())),
                ),
              if (_shouldShowElderly)
                _buildRedirectButton(
                  label: '65 Yaş Üzeri İçin Beslenme Önerileri',
                  color: Colors.blueAccent,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => YasliBeslenme())),
                ),
              if (_shouldShowChild)
                _buildRedirectButton(
                  label: 'Çocuklar İçin Beslenme Önerileri',
                  color: Colors.blueAccent,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CocukBeslenme())),
                ),
              if (!_shouldDisableInputs) ...[
                Row(children: [
                  Expanded(child: TextField(
                    controller: _dairyController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Süt grubu (2 porsiyon)",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    ),
                  )),
                  SizedBox(width: 8),
                  Expanded(child: TextField(
                    controller: _proteinController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Et, yumurta ve kuru baklagiller (2-3 porsiyon)",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    ),
                  )),
                ]),
                SizedBox(height: 8),
                Row(children: [
                  Expanded(child: TextField(
                    controller: _vegFruitController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Sebze ve meyve (5-6 porsiyon)",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    ),
                  )),
                  SizedBox(width: 8),
                  Expanded(child: TextField(
                    controller: _carbController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Karbonhidratlar (4-6 porsiyon)",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    ),
                  )),
                ]),
                SizedBox(height: 8),
                TextField(
                  controller: _waterController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Su (ml, 2 litre = 2000 ml)",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _savePortions,
                    child: _isLoading
                        ? SizedBox(height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                        : Text("Kaydet", style: TextStyle(fontSize: 15)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreen,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRedirectButton({required String label, required Color color, required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: EdgeInsets.symmetric(vertical: 14),
            elevation: 2,
          ),
          child: Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Future<void> _savePortions() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      await _showInfoDialog("Kullanıcı oturumu bulunamadı!");
      return;
    }
    int? dairy = int.tryParse(_dairyController.text.trim());
    int? protein = int.tryParse(_proteinController.text.trim());
    int? vegFruit = int.tryParse(_vegFruitController.text.trim());
    int? carb = int.tryParse(_carbController.text.trim());
    double? water = double.tryParse(_waterController.text.trim());
    if ([dairy, protein, vegFruit, carb, water].contains(null)) {
      await _showInfoDialog("Lütfen tüm alanlara geçerli bir sayı giriniz.");
      return;
    }
    setState(() { _isLoading = true; });
    final now = DateTime.now();
    final dateString = "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
    final query = await FirebaseFirestore.instance.collection('portions')
      .where('userId', isEqualTo: user.uid)
      .where('date', isEqualTo: dateString)
      .get();
    if (query.docs.isNotEmpty) {
      int totalDairy = dairy! + (query.docs.fold(0, (sum, doc) => sum + (doc.data()['dairy'] ?? 0) as int));
      int totalProtein = protein! + (query.docs.fold(0, (sum, doc) => sum + (doc.data()['protein'] ?? 0) as int));
      int totalVegFruit = vegFruit! + (query.docs.fold(0, (sum, doc) => sum + (doc.data()['vegFruit'] ?? 0) as int));
      int totalCarb = carb! + (query.docs.fold(0, (sum, doc) => sum + (doc.data()['carb'] ?? 0) as int));
      double totalWater = water! + (query.docs.fold(0.0, (sum, doc) => sum + (doc.data()['water'] ?? 0).toDouble()));
      final firstDoc = query.docs.first;
      await FirebaseFirestore.instance.collection('portions').doc(firstDoc.id).update({
        'dairy': totalDairy,
        'protein': totalProtein,
        'vegFruit': totalVegFruit,
        'carb': totalCarb,
        'water': totalWater,
        'timestamp': FieldValue.serverTimestamp(),
      });
      for (int i = 1; i < query.docs.length; i++) {
        await FirebaseFirestore.instance.collection('portions').doc(query.docs[i].id).delete();
      }
      setState(() {
        _todayPortions = {
          'dairy': totalDairy,
          'protein': totalProtein,
          'vegFruit': totalVegFruit,
          'carb': totalCarb,
          'water': totalWater,
        };
        _todayDocId = firstDoc.id;
      });
    } else {
      final docRef = await FirebaseFirestore.instance.collection('portions').add({
        'userId': user.uid,
        'userName': _userName ?? '',
        'date': dateString,
        'dairy': dairy,
        'protein': protein,
        'vegFruit': vegFruit,
        'carb': carb,
        'water': water,
        'timestamp': FieldValue.serverTimestamp(),
      });
      setState(() {
        _todayPortions = {
          'dairy': dairy!,
          'protein': protein!,
          'vegFruit': vegFruit!,
          'carb': carb!,
          'water': water!,
        };
        _todayDocId = docRef.id;
      });
    }
    setState(() { _isLoading = false; });
    _dairyController.clear();
    _proteinController.clear();
    _vegFruitController.clear();
    _carbController.clear();
    _waterController.clear();
    // Bilgilendirici mesajlar
    String message = '';
    // Süt grubu
    if (_todayPortions['dairy'] >= 2) {
      message += 'Süt grubu tüketiminiz yeterli!\n';
    } else {
      message += 'Süt grubu tüketiminizi artırabilirsiniz.\n';
    }
    // Et, yumurta ve kuru baklagiller
    if (_todayPortions['protein'] >= 2 && _todayPortions['protein'] <= 3) {
      message += 'Et, yumurta ve kuru baklagiller tüketiminiz ideal!\n';
    } else if (_todayPortions['protein'] > 3) {
      message += 'Et, yumurta ve kuru baklagiller tüketiminiz fazla!\n';
    } else {
      message += 'Biraz daha et, yumurta ve kuru baklagil tüketebilirsiniz.\n';
    }
    // Sebze ve meyve
    if (_todayPortions['vegFruit'] >= 5 && _todayPortions['vegFruit'] <= 6) {
      message += 'Sebze ve meyve tüketiminiz harika!\n';
    } else if (_todayPortions['vegFruit'] > 6) {
      message += 'Sebze ve meyve tüketiminiz fazla!\n';
    } else {
      message += 'Daha fazla sebze ve meyve tüketmeye çalışın.\n';
    }
    // Karbonhidratlar
    if (_todayPortions['carb'] >= 4 && _todayPortions['carb'] <= 6) {
      message += 'Karbonhidrat tüketiminiz ideal.\n';
    } else if (_todayPortions['carb'] > 6) {
      message += 'Karbonhidratı fazla kaçırdınız!\n';
    } else {
      message += 'Biraz daha karbonhidrat tüketebilirsiniz.\n';
    }
    // Su
    double kalanSu = 2.0 - (_todayPortions['water'] / 1000.0);
    if (_todayPortions['water'] >= 2000) {
      message += 'Su tüketiminiz çok iyi!';
    } else if (_todayPortions['water'] > 0) {
      message += '2 litreye ulaşmak için ${kalanSu.toStringAsFixed(2)} litre kaldı!';
    } else {
      message += 'Su içmeyi unutmayın!';
    }
    await _showInfoDialog(message.trim());
  }
}
