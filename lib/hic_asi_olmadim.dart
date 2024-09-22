import 'package:flutter/material.dart';

class asi_olmadim extends StatefulWidget {
  const asi_olmadim({super.key});

  @override
  State<asi_olmadim> createState() => _asi_olmadimState();
}

class _asi_olmadimState extends State<asi_olmadim> {
  var tfController = TextEditingController();
  String _asiPlan = "";

  void updateText() {
    setState(() {
      int yas = int.parse(tfController.text);
      if (yas >= 1 && yas <= 6) {
        _asiPlan = """
1-6 Yaş Aşı Planı: 
- DaBT-İPA-Hib, Hep B, TCT, Suçiçeği, Hep A - İlk Karşılaşma 
- KKK, TCT sonucuna göre gerekiyorsa BCG - İlk Karşılaşmadan 2 Gün Sonra
- DaBT-İPA-Hib, Hep B, OPA, KPA - İlk Karşılaşmadan 2 Ay Sonra
- DaBT-İPA-Hib, Hep B, OPA, Hep A - İlk Karşılaşmadan 8 Ay Sonra
        """;
      } else if (yas >= 6 && yas < 14) {
        _asiPlan = """
6-13 Yaş Aşı Planı:
- DaBT-İPA, Hep B, KKK, Suçiçeği, Hep A - İlk Karşılaşma
- DaBT-İPA, OPA, Hep B, KKK - İlk Karşılaşmadan 2 Ay Sonra
- DaBT-İPA, OPA, Hep B, Hep A - İlk Karşılaşmadan 8 Ay Sonra
        """;
      } else if (yas >= 14) {
        _asiPlan = """
14 Yaş ve Üzeri Aşı Planı:
- Td, OPA, Hep B, KKK, Suçiçeği, Hep A - İlk Karşılaşma
- Td, OPA, Hep B, KKK - İlk Karşılaşmadan 2 Ay Sonra
- Td, Hep B, Hep A - İlk Karşılaşmadan 8 Ay Sonra
        """;
      } else if (yas < 0) {
        _asiPlan = "Hatalı değer girişi yaptınız.";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hiç Aşı Olmadım"),
        backgroundColor: Colors.orangeAccent,
      ),
      // Klavye açıldığında ekranın boyutunu ayarlamak için:
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Yaşınızı Giriniz",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextField(
                controller: tfController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Yaşınızı Giriniz",
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 16,
                  ),
                ),
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: updateText,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  backgroundColor: Colors.orangeAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "Devam Et",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              SizedBox(height: 40),
              if (_asiPlan.isNotEmpty)
                Card(
                  color: Colors.orange[50],
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      _asiPlan,
                      style: TextStyle(fontSize: 18, color: Colors.black87),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
