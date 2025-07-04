import 'package:flutter/material.dart';
import 'package:ksh_uygulamasi/sonuc_ekrani.dart';
import 'package:ksh_uygulamasi/check_sorulari.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ksh_uygulamasi/services/notification_service.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  _AnasayfaState createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _userId;

  // Controller'ları ekleyelim
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _ageInMonthsController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _headCircumferenceController = TextEditingController();
  final TextEditingController _professionController = TextEditingController();

  String? _name;
  String? _gender;
  bool _isPregnant = false;
  bool _isMarriageApplicant = false;
  double? _headCircumference;
  double? _height;
  double? _weight;
  bool _isGoingToHajjUmrah = false;
  bool _isGoingToMilitary = false;
  bool _isGoingToTravel = false;
  String? _profession;
  final int _smokingScore = 0;
  bool _isBaby = false;
  int? _ageInMonths;
  int? _age;
  bool _isSmoking = false;

  bool get showPregnancyField {
    return _gender == 'Kadın' && (_age != null && _age! >= 15 && _age! <= 50);
  }

  bool get showMilitaryField {
    return _gender == 'Erkek' && (_age != null && _age! >= 18);
  }

  bool get showMarriageField {
    return _age != null && _age! >= 16;
  }

  bool get showSigaraField {
    return _age != null && _age! >= 13;
  }

  @override
  void initState() {
    super.initState();
    _initializeUser();
  }

  @override
  void dispose() {
    // Controller'ları temizleyelim
    _nameController.dispose();
    _ageController.dispose();
    _ageInMonthsController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _headCircumferenceController.dispose();
    _professionController.dispose();
    super.dispose();
  }

  Future<void> _initializeUser() async {
    try {
      // Mevcut kullanıcıyı al
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        _userId = currentUser.uid;
        await _loadUserData();
      } else {
        // Eğer kullanıcı yoksa yeni bir anonim kullanıcı oluştur
        UserCredential userCredential = await _auth.signInAnonymously();
        _userId = userCredential.user?.uid;
        
        if (_userId != null) {
          await _loadUserData();
        }
      }
    } catch (e) {
      print('Kullanıcı oluşturulurken hata: $e');
    }
  }

  Future<void> _loadUserData() async {
    try {
      if (_userId == null) return;
      
      final docSnapshot = await _firestore.collection('users').doc(_userId).get();
      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        setState(() {
          _name = data['name'] as String? ?? '';
          _gender = data['gender'] as String? ?? '';
          _isPregnant = data['isPregnant'] as bool? ?? false;
          _isMarriageApplicant = data['isMarriageApplicant'] as bool? ?? false;
          _headCircumference = (data['headCircumference'] as num?)?.toDouble();
          _height = (data['height'] as num?)?.toDouble();
          _weight = (data['weight'] as num?)?.toDouble();
          _isGoingToHajjUmrah = data['isGoingToHajjUmrah'] as bool? ?? false;
          _isGoingToMilitary = data['isGoingToMilitary'] as bool? ?? false;
          _isGoingToTravel = data['isGoingToTravel'] as bool? ?? false;
          _profession = data['profession'] as String? ?? '';
          _isBaby = data['isBaby'] as bool? ?? false;
          _ageInMonths = data['ageInMonths'] as int?;
          _age = data['age'] as int?;
          _isSmoking = data['isSmoking'] as bool? ?? false;

          // Controller'ları güncelle
          _nameController.text = _name ?? '';
          _ageController.text = _age?.toString() ?? '';
          _ageInMonthsController.text = _ageInMonths?.toString() ?? '';
          _heightController.text = _height?.toString() ?? '';
          _weightController.text = _weight?.toString() ?? '';
          _headCircumferenceController.text = _headCircumference?.toString() ?? '';
          _professionController.text = _profession ?? '';
        });
      }
    } catch (e) {
      print('Kullanıcı bilgileri yüklenirken hata oluştu: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Sayfası'),
        backgroundColor: Colors.lightGreen,
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
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.lightGreen,
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.lightGreen,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Kişisel Bilgileriniz',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightGreen,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Temel Bilgiler',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.lightGreen,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              labelText: 'İsim Soyisim',
                              labelStyle: TextStyle(color: Colors.blueGrey),
                            ),
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.sentences,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return null;
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _name = _nameController.text;
                            },
                          ),
                          CheckboxListTile(
                            title: const Text(
                                '0 ila 2 yaş bebekler için aşı, tarama programları hakkında bilgi alabilmek için tıklayınız.'),
                            activeColor: Colors.lightGreen,
                            value: _isBaby,
                            onChanged: (value) {
                              setState(() {
                                _isBaby = value ?? false;
                                if (_isBaby) {
                                  _age = null;
                                  _headCircumference = null;
                                  _height = null;
                                  _weight = null;
                                } else {
                                  _ageInMonths = null;
                                }
                              });
                            },
                          ),
                          if (_isBaby) ...[
                            TextFormField(
                              controller: _ageInMonthsController,
                              decoration: const InputDecoration(
                                labelText: 'Ay olarak yaş',
                                labelStyle: TextStyle(color: Colors.blueGrey),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null ||
                                    int.tryParse(value) == null) {
                                  return 'Lütfen geçerli bir ay giriniz';
                                } else if (int.tryParse(value)! > 24) {
                                  return 'Lütfen 0 ile 24 arasında bir ay giriniz';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                if (value != null && value.isNotEmpty) {
                                  _ageInMonths = int.tryParse(value);
                                }
                              },
                            ),
                            TextFormField(
                              controller: _heightController,
                              decoration: const InputDecoration(
                                labelText: 'Boy (cm)',
                                labelStyle: TextStyle(color: Colors.blueGrey),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null ||
                                    double.tryParse(value) == null) {
                                  return 'Lütfen geçerli bir boy giriniz';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                if (value != null && value.isNotEmpty) {
                                  _height = double.tryParse(value);
                                }
                              },
                            ),
                            TextFormField(
                              controller: _weightController,
                              decoration: const InputDecoration(
                                labelText: 'Kilo (kg)',
                                labelStyle: TextStyle(color: Colors.blueGrey),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null ||
                                    double.tryParse(value) == null) {
                                  return 'Lütfen geçerli bir kilo giriniz';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                if (value != null && value.isNotEmpty) {
                                  _weight = double.tryParse(value);
                                }
                              },
                            ),
                            TextFormField(
                              controller: _headCircumferenceController,
                              decoration: const InputDecoration(
                                labelText: 'Baş Çevresi (cm)',
                                labelStyle: TextStyle(color: Colors.blueGrey),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null ||
                                    double.tryParse(value) == null) {
                                  return 'Lütfen geçerli bir baş çevresi giriniz';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                if (value != null && value.isNotEmpty) {
                                  _headCircumference = double.tryParse(value);
                                }
                              },
                            ),
                          ],
                          if (!_isBaby)
                            TextFormField(
                              controller: _heightController,
                              decoration: const InputDecoration(
                                labelText: 'Boy (cm)',
                                labelStyle: TextStyle(color: Colors.blueGrey),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null ||
                                    double.tryParse(value) == null) {
                                  return 'Lütfen geçerli bir boy giriniz';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                if (value != null && value.isNotEmpty) {
                                  _height = double.tryParse(value);
                                }
                              },
                            ),
                          if (!_isBaby)
                            TextFormField(
                              controller: _weightController,
                              decoration: const InputDecoration(
                                labelText: 'Kilo (kg)',
                                labelStyle: TextStyle(color: Colors.blueGrey),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null ||
                                    double.tryParse(value) == null) {
                                  return 'Lütfen geçerli bir kilo giriniz';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                if (value != null && value.isNotEmpty) {
                                  _weight = double.tryParse(value);
                                }
                              },
                            ),
                          if (!_isBaby)
                            TextFormField(
                              controller: _professionController,
                              decoration: const InputDecoration(
                                labelText: 'Meslek',
                                labelStyle: TextStyle(color: Colors.blueGrey),
                              ),
                              onSaved: (value) {
                                _profession = _professionController.text;
                              },
                            ),
                          if (!_isBaby)
                            TextFormField(
                              controller: _ageController,
                              decoration: const InputDecoration(
                                labelText: 'Yaş',
                                labelStyle: TextStyle(color: Colors.blueGrey),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null ||
                                    int.tryParse(value) == null) {
                                  return 'Lütfen geçerli bir yaş giriniz';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                if (value != null && value.isNotEmpty) {
                                  _age = int.tryParse(_ageController.text);
                                }
                              },
                            ),
                          DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              labelText: 'Cinsiyet',
                              labelStyle: TextStyle(color: Colors.blueGrey),
                            ),
                            value: _gender,
                            items: ['Kadın', 'Erkek']
                                .map((gender) => DropdownMenuItem(
                                      value: gender,
                                      child: Text(gender),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _gender = value;
                              });
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Lütfen cinsiyet seçiniz';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      print('Butona basıldı');
                      
                      if (_formKey.currentState!.validate()) {
                        print('Form doğrulaması başarılı');
                        _formKey.currentState!.save();
                        
                        try {
                          // Önce state değişkenlerini güncelle
                          setState(() {
                            _name = _nameController.text;
                            _age = int.tryParse(_ageController.text);
                            _ageInMonths = int.tryParse(_ageInMonthsController.text);
                            _height = double.tryParse(_heightController.text);
                            _weight = double.tryParse(_weightController.text);
                            _headCircumference = double.tryParse(_headCircumferenceController.text);
                            _profession = _professionController.text;
                          });

                          if (_userId == null) {
                            throw Exception('Kullanıcı ID bulunamadı');
                          }

                          // Sonra Firestore'a kaydet
                          final userData = {
                            'name': _name ?? '',
                            'gender': _gender ?? '',
                            'isPregnant': _isPregnant,
                            'isMarriageApplicant': _isMarriageApplicant,
                            'headCircumference': _headCircumference,
                            'height': _height,
                            'weight': _weight,
                            'isGoingToHajjUmrah': _isGoingToHajjUmrah,
                            'isGoingToMilitary': _isGoingToMilitary,
                            'isGoingToTravel': _isGoingToTravel,
                            'profession': _profession ?? '',
                            'isBaby': _isBaby,
                            'ageInMonths': _ageInMonths,
                            'age': _age,
                            'isSmoking': _isSmoking,
                          };

                          await _firestore.collection('users').doc(_userId).set(userData, SetOptions(merge: true));
                          print('Veriler Firestore\'a kaydedildi');

                          // Bildirimleri planla
                          final notificationService = NotificationService();
                          
                          if (_isBaby && _ageInMonths != null) {
                            // Bebek için bildirimleri planla
                            await notificationService.scheduleBabyScreenings(
                              DateTime.now().subtract(Duration(days: _ageInMonths! * 30)),
                            );
                          } else if (_age != null) {
                            // Yetişkin için bildirimleri planla
                            final birthDate = DateTime.now().subtract(Duration(days: _age! * 365));
                            await notificationService.scheduleUserHealthScreenings(
                              birthDate: birthDate,
                              isPregnant: _isPregnant,
                              hasChronicDisease: _isSmoking, // Sigara içenler için kronik hastalık taramaları
                            );
                          }

                          if (mounted) {
                            // CheckSorulari sayfasına geç
                            print('CheckSorulari sayfasına geçiliyor...');
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CheckSorulari(
                                  gender: _gender,
                                  age: _age,
                                  isBaby: _isBaby,
                                  weight: _weight,
                                  height: _height,
                                  name: _name,
                                  ageInMonths: _ageInMonths,
                                  headCircumference: _headCircumference,
                                  profession: _profession,
                                  smokingScore: _smokingScore,
                                  isMarriageApplicant: _isMarriageApplicant,
                                  isSmoking: _isSmoking,
                                ),
                              ),
                            );

                            print('CheckSorulari sayfasından dönüldü');
                            print('Result: $result');

                            if (result != null && mounted) {
                              setState(() {
                                _isPregnant = result['isPregnant'] ?? false;
                                _isMarriageApplicant = result['isMarriageApplicant'] ?? false;
                                _isGoingToHajjUmrah = result['isGoingToHajjUmrah'] ?? false;
                                _isGoingToMilitary = result['isGoingToMilitary'] ?? false;
                                _isGoingToTravel = result['isGoingToTravel'] ?? false;
                                _isSmoking = result['isSmoking'] ?? false;
                              });

                              print('State güncellendi, Degerlendirme sayfasına geçiliyor...');
                              
                              // Degerlendirme sayfasına geç
                              if (mounted) {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Degerlendirme(
                                      name: _name ?? 'Bilinmiyor',
                                      age: _age ?? 0,
                                      ageInMonths: _ageInMonths,
                                      isBaby: _isBaby,
                                      gender: _gender ?? 'Belirtilmedi',
                                      isPregnant: _isPregnant,
                                      headCircumference: _headCircumference,
                                      height: _height ?? 0.0,
                                      weight: _weight ?? 0.0,
                                      isGoingToHajjUmrah: _isGoingToHajjUmrah,
                                      isGoingToMilitary: _isGoingToMilitary,
                                      isGoingToTravel: _isGoingToTravel,
                                      profession: _profession ?? 'Bilinmiyor',
                                      smokingScore: _smokingScore,
                                      isMarriageApplicant: _isMarriageApplicant,
                                      isSmoking: _isSmoking,
                                    ),
                                  ),
                                );
                                print('Degerlendirme sayfasına geçildi');
                              }
                            }
                          }
                        } catch (e) {
                          print('Hata oluştu: $e');
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Hata oluştu: $e')),
                            );
                          }
                        }
                      } else {
                        print('Form doğrulaması başarısız');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Lütfen tüm gerekli alanları doldurun')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreen,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'Değerlendirmeye Devam Et',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
