import 'package:flutter/material.dart';
import 'package:ksh_uygulamasi/her_seyi_gosteren_sayfa.dart';
import 'package:ksh_uygulamasi/hic_asi_olmadim.dart';
import 'package:ksh_uygulamasi/kuduz_temasi.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ksh_uygulamasi/sonuc_ekrani.dart';

class Sayfa2 extends StatefulWidget {
  const Sayfa2({super.key});

  @override
  State<Sayfa2> createState() => _Sayfa2State();
}

class _Sayfa2State extends State<Sayfa2> {
  Future<Map<String, dynamic>?> _loadUserData() async {
    try {
      const userId = 'default_user';
      final docSnapshot = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      if (docSnapshot.exists) {
        return docSnapshot.data();
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
                          'Sonuçları Görüntüle',
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
