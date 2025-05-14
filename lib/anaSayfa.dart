import 'package:flutter/material.dart';
import 'package:ksh_uygulamasi/sonuc_ekrani.dart';
import 'package:ksh_uygulamasi/check_sorulari.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  _AnasayfaState createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  final _formKey = GlobalKey<FormState>();

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
                              _name = value;
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
                                _height = double.tryParse(value!);
                              },
                            ),
                            TextFormField(
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
                                _weight = double.tryParse(value!);
                              },
                            ),
                            TextFormField(
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
                                _headCircumference = double.tryParse(value!);
                              },
                            ),
                          ],
                          if (!_isBaby)
                            TextFormField(
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
                                } else {
                                  _height = null;
                                }
                              },
                            ),
                          if (!_isBaby)
                            TextFormField(
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
                                } else {
                                  _weight = null;
                                }
                              },
                            ),
                          if (!_isBaby)
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Meslek',
                                labelStyle: TextStyle(color: Colors.blueGrey),
                              ),
                              onSaved: (value) {
                                _profession = value;
                              },
                            ),
                          if (!_isBaby)
                            TextFormField(
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
                                _age = int.tryParse(value ?? '0');
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
                          if (showPregnancyField)
                            CheckboxListTile(
                              title: const Text('Hamileyseniz tıklayınız.'),
                              activeColor: Colors.lightGreen,
                              value: _isPregnant,
                              onChanged: (value) {
                                setState(() {
                                  _isPregnant = value!;
                                });
                              },
                            ),
                          if (showMarriageField)
                            CheckboxListTile(
                              title: const Text(
                                  'Evlilik başvurunuz varsa tıklayınız.'),
                              activeColor: Colors.lightGreen,
                              value: _isMarriageApplicant,
                              onChanged: (value) {
                                setState(() {
                                  _isMarriageApplicant = value!;
                                });
                              },
                            ),
                          if (showSigaraField)
                            CheckboxListTile(
                              title:
                                  const Text('Sigara içiyorsanız tıklayınız'),
                              activeColor: Colors.lightGreen,
                              value: _isSmoking,
                              onChanged: (value) {
                                setState(() {
                                  _isSmoking = value!;
                                });
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CheckSorulari(
                              gender: _gender,
                              age: _age,
                              isBaby: _isBaby,
                            ),
                          ),
                        );

                        if (result != null) {
                          setState(() {
                            _isPregnant = result['isPregnant'] ?? false;
                            _isMarriageApplicant =
                                result['isMarriageApplicant'] ?? false;
                            _isGoingToHajjUmrah =
                                result['isGoingToHajjUmrah'] ?? false;
                            _isGoingToMilitary =
                                result['isGoingToMilitary'] ?? false;
                            _isGoingToTravel =
                                result['isGoingToTravel'] ?? false;
                            _isSmoking = result['isSmoking'] ?? false;
                          });

                          String greetingName =
                              (_name == null || _name!.isEmpty)
                                  ? 'Bilinmiyor'
                                  : _name!;
                          int age = _isBaby ? 0 : (_age ?? 0);
                          int? ageInMonths =
                              _isBaby ? (_ageInMonths ?? 0) : null;
                          double height = _height ?? 0.0;
                          double weight = _weight ?? 0.0;
                          double? headCircumference =
                              _isBaby ? (_headCircumference ?? 0.0) : null;

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Degerlendirme(
                                name: greetingName,
                                age: age,
                                ageInMonths: ageInMonths,
                                isBaby: _isBaby,
                                gender: _gender ?? 'Belirtilmedi',
                                isPregnant: _isPregnant,
                                headCircumference: headCircumference,
                                height: height,
                                weight: weight,
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
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreen,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 15),
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
