import 'package:flutter/material.dart';
import 'package:ksh_uygulamasi/sonuc_ekrani.dart';
import 'package:ksh_uygulamasi/depresyon.dart';

class anasayfa extends StatefulWidget {
  @override
  _anasayfaState createState() => _anasayfaState();
}

class _anasayfaState extends State<anasayfa> {
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
  int _smokingScore = 0;
  bool _isBaby = false;
  int? _ageInMonths;
  int? _age;
  bool _isSmoking =false;


  bool get showPregnancyField {
    return _gender == 'Kadın' && (_age != null && _age! >= 15);
  }

  bool get showMilitaryField {
    return _gender == 'Erkek' && (_age != null && _age! >= 18);
  }
  bool get showMarriageField {
    return _age != null && _age! >= 16;
  }
  bool get showSigaraField {
    return _age !=null && _age! >=13;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bilgi Girişi'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
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

                },
                onSaved: (value) {
                  _name = value;
                },
              ),
              CheckboxListTile(
                title: const Text('0 ila 2 yaş bebekler için aşı, tarama programları hakkında bilgi alabilmek için tıklayınız.'),
                activeColor: Colors.blueAccent,
                value: _isBaby,
                onChanged: (value) {
                  setState(() {
                    _isBaby = value!;
                    if (_isBaby) {
                      _age = null;
                      _headCircumference = null;
                    } else {
                      _ageInMonths = null;
                    }
                    _height = null;
                    _weight = null;
                  });
                },
              ),
              if (_isBaby)
                ...[
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Ay olarak yaş',
                      labelStyle: TextStyle(color: Colors.blueGrey),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || int.tryParse(value) == null) {
                        return 'Lütfen geçerli bir ay giriniz';
                      } else if (int.tryParse(value)! > 24) {
                        return 'Lütfen 0 ile 24 arasında bir ay giriniz';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _ageInMonths = int.tryParse(value!);
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Boy (cm)',
                      labelStyle: TextStyle(color: Colors.blueGrey),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || double.tryParse(value) == null) {
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
                      if (value == null || double.tryParse(value) == null) {
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
                      if (value == null || double.tryParse(value) == null) {
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
                    labelText: 'Yaş',
                    labelStyle: TextStyle(color: Colors.blueGrey),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || int.tryParse(value) == null) {
                      return 'Lütfen geçerli bir yaş giriniz';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _age = int.tryParse(value!);
                  },
                  onChanged: (value) {
                    setState(() {
                      _age = int.tryParse(value);
                    });
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
                    if (_gender != 'Kadın') {
                      _isPregnant = false; // Reset pregnancy checkbox when not female
                    }
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
                  activeColor: Colors.blueAccent,
                  value: _isPregnant,
                  onChanged: (value) {
                    setState(() {
                      _isPregnant = value!;
                    });
                  },
                ),
              if (showMarriageField)
                CheckboxListTile(
                  title: const Text('Evlilik başvurunuz varsa tıklayınız.'),
                  activeColor: Colors.blueAccent,
                  value: _isMarriageApplicant,
                  onChanged: (value) {
                    setState(() {
                      _isMarriageApplicant = value!;
                    });
                  },
                ),
              if (!_isBaby)
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Boy (cm)',
                    labelStyle: TextStyle(color: Colors.blueGrey),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || double.tryParse(value) == null) {
                      return 'Lütfen geçerli bir boy giriniz';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _height = double.tryParse(value!);
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
                    if (value == null || double.tryParse(value) == null) {
                      return 'Lütfen geçerli bir kilo giriniz';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _weight = double.tryParse(value!);
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
              CheckboxListTile(
                title: const Text('Hac veya Umreye gidecekseniz tıklayınız.'),
                activeColor: Colors.blueAccent,
                value: _isGoingToHajjUmrah,
                onChanged: (value) {
                  setState(() {
                    _isGoingToHajjUmrah = value!;
                  });
                },
              ),
              if (showMilitaryField)
                CheckboxListTile(
                  title: const Text('Üç ay içinde askere gidecekseniz tıklayınız.'),
                  activeColor: Colors.blueAccent,
                  value: _isGoingToMilitary,
                  onChanged: (value) {
                    setState(() {
                      _isGoingToMilitary = value!;
                    });
                  },
                ),
              CheckboxListTile(
                title: const Text('Üç ay içinde yurtdışına seyahate gidecekseniz tıklayınız.  '),
                activeColor: Colors.blueAccent,
                value: _isGoingToTravel,
                onChanged: (value) {
                  setState(() {
                    _isGoingToTravel = value!;
                  });
                },
              ),
              if (showSigaraField)
                CheckboxListTile(
                  title: const Text('Sigara içiyorsanız tıklayınız'),
                  activeColor: Colors.blueAccent,
                  value: _isSmoking,
                  onChanged: (value) {
                    setState(() {
                      _isSmoking = value!;
                    });
                  },
                ),



              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    String greetingName = (_name == null || _name!.isEmpty) ? "" : "$_name";

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => degerlendirme(
                          name: greetingName,
                          age: _isBaby ? null : _age,
                          ageInMonths: _isBaby ? _ageInMonths : null,
                          isBaby: _isBaby,
                          gender: _gender!,
                          isPregnant: _isPregnant,
                          headCircumference: _isBaby ? _headCircumference : null,
                          height: _height,
                          weight: _weight,
                          isGoingToHajjUmrah: _isGoingToHajjUmrah,
                          isGoingToMilitary: _isGoingToMilitary,
                          isGoingToTravel: _isGoingToTravel,
                          profession: _profession,
                          smokingScore: _smokingScore,
                          isMarriageApplicant:_isMarriageApplicant,
                          isSmoking:_isSmoking,

                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Sonuçları Göster',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}