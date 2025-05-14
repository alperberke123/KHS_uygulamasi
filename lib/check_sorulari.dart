import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CheckSorulari extends StatefulWidget {
  final String? gender;
  final int? age;
  final bool isBaby;

  const CheckSorulari({
    Key? key,
    required this.gender,
    required this.age,
    required this.isBaby,
  }) : super(key: key);

  @override
  _CheckSorulariState createState() => _CheckSorulariState();
}

class _CheckSorulariState extends State<CheckSorulari> {
  bool _isPregnant = false;
  bool _isMarriageApplicant = false;
  bool _isGoingToHajjUmrah = false;
  bool _isGoingToMilitary = false;
  bool _isGoingToTravel = false;
  bool _isSmoking = false;

  bool get showPregnancyField {
    return widget.gender == 'Kadın' &&
        (widget.age != null && widget.age! >= 15 && widget.age! <= 50);
  }

  bool get showMilitaryField {
    return widget.gender == 'Erkek' &&
        (widget.age != null && widget.age! >= 18);
  }

  bool get showMarriageField {
    return widget.age != null && widget.age! >= 16;
  }

  bool get showSigaraField {
    return widget.age != null && widget.age! >= 13;
  }

  void _saveToFirebase() async {
    try {
      CollectionReference userCollection =
          FirebaseFirestore.instance.collection('user_responses');

      // Veriyi Firestore'a kaydediyoruz
      await userCollection.add({
        'gender': widget.gender,
        'age': widget.age,
        'isPregnant': _isPregnant,
        'isMarriageApplicant': _isMarriageApplicant,
        'isGoingToHajjUmrah': _isGoingToHajjUmrah,
        'isGoingToMilitary': _isGoingToMilitary,
        'isGoingToTravel': _isGoingToTravel,
        'isSmoking': _isSmoking,
      });

      // Veri kaydedildikten sonra başarılı bir mesaj gösterilebilir
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Veriler başarıyla kaydedildi!")));
    } catch (e) {
      // Hata olursa hata mesajını gösteriyoruz
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Hata oluştu: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ek Bilgiler'),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Lütfen aşağıdaki soruları yanıtlayınız:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightGreen,
                  ),
                ),
                const SizedBox(height: 20),
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
                    title: const Text('Evlilik başvurunuz varsa tıklayınız.'),
                    activeColor: Colors.lightGreen,
                    value: _isMarriageApplicant,
                    onChanged: (value) {
                      setState(() {
                        _isMarriageApplicant = value!;
                      });
                    },
                  ),
                CheckboxListTile(
                  title: const Text('Hac veya Umreye gidecekseniz tıklayınız.'),
                  activeColor: Colors.lightGreen,
                  value: _isGoingToHajjUmrah,
                  onChanged: (value) {
                    setState(() {
                      _isGoingToHajjUmrah = value!;
                    });
                  },
                ),
                if (showMilitaryField)
                  CheckboxListTile(
                    title: const Text(
                        'Üç ay içinde askere gidecekseniz tıklayınız.'),
                    activeColor: Colors.lightGreen,
                    value: _isGoingToMilitary,
                    onChanged: (value) {
                      setState(() {
                        _isGoingToMilitary = value!;
                      });
                    },
                  ),
                CheckboxListTile(
                  title: const Text(
                      'Üç ay içinde yurtdışına seyahate gidecekseniz tıklayınız.'),
                  activeColor: Colors.lightGreen,
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
                    activeColor: Colors.lightGreen,
                    value: _isSmoking,
                    onChanged: (value) {
                      setState(() {
                        _isSmoking = value!;
                      });
                    },
                  ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      _saveToFirebase();
                      Navigator.pop(context, {
                        'isPregnant': _isPregnant,
                        'isMarriageApplicant': _isMarriageApplicant,
                        'isGoingToHajjUmrah': _isGoingToHajjUmrah,
                        'isGoingToMilitary': _isGoingToMilitary,
                        'isGoingToTravel': _isGoingToTravel,
                        'isSmoking': _isSmoking,
                      });
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
                        Icon(Icons.save, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'Kaydet ve Devam Et',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
