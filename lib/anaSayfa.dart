import 'package:flutter/material.dart';
import 'package:ksh_uygulamasi/sonuc_ekrani.dart';

class anaSayfa extends StatefulWidget {
  @override
  _anaSayfaState createState() => _anaSayfaState();
}

class _anaSayfaState extends State<anaSayfa> {
  final _formKey = GlobalKey<FormState>();

  // Form verileri
  String? _name;
  String? _gender;
  bool _isPregnant = false;
  double? _height;
  double? _weight;
  bool _isGoingToHajjUmrah = false;
  String? _profession;

  // Yaş ve 0-2 yaş bebek seçimi
  bool _isBaby = false;
  int? _ageInMonths; // Ay cinsinden yaş
  int? _age; // Yaş, ay girilmezse bu kullanılacak

  // Kadın seçilirse hamilelik durumu sorulacak
  bool get showPregnancyField => _gender == 'Kadın';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bilgi Girişi'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'İsim Soyisim'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen isim soyisim giriniz';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value;
                },
              ),
              CheckboxListTile(
                title: Text('0-2 Yaş Bebek'),
                value: _isBaby,
                onChanged: (value) {
                  setState(() {
                    _isBaby = value!;
                    _age = null;  // Eğer bebek seçilirse yaş sıfırlanmalı
                  });
                },
              ),
              if (_isBaby)
                TextFormField(
                  decoration: InputDecoration(labelText: 'Ay olarak yaş'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || int.tryParse(value) == null) {
                      return 'Lütfen geçerli bir ay giriniz';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _ageInMonths = int.tryParse(value!);
                  },
                ),
              if (!_isBaby)
                TextFormField(
                  decoration: InputDecoration(labelText: 'Yaş'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (_isBaby) {
                      return null;
                    } else if (value == null || int.tryParse(value) == null) {
                      return 'Lütfen geçerli bir yaş giriniz';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _age = int.tryParse(value!);
                  },
                ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Cinsiyet'),
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
                  title: Text('Hamile misiniz?'),
                  value: _isPregnant,
                  onChanged: (value) {
                    setState(() {
                      _isPregnant = value!;
                    });
                  },
                ),
              if (!_isBaby)
                TextFormField(
                  decoration: InputDecoration(labelText: 'Boy (cm)'),
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
                  decoration: InputDecoration(labelText: 'Kilo (kg)'),
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
                  decoration: InputDecoration(labelText: 'Meslek'),
                  onSaved: (value) {
                    _profession = value;
                  },
                ),
              CheckboxListTile(
                title: Text('Hac/Umreye gidecek misiniz?'),
                value: _isGoingToHajjUmrah,
                onChanged: (value) {
                  setState(() {
                    _isGoingToHajjUmrah = value!;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => degerlendirme(
                          name: _name!,
                          age: _age,
                          ageInMonths: _ageInMonths,
                          isBaby: _isBaby,
                          gender: _gender!,
                          isPregnant: _isPregnant,
                          height: _height,
                          weight: _weight,
                          isGoingToHajjUmrah: _isGoingToHajjUmrah,
                          profession: _profession,
                        ),
                      ),
                    );
                  }
                },
                child: Text('Sonuçları Göster'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
