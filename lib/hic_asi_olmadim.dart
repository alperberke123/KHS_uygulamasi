import 'package:flutter/material.dart';

class AsiOlmadim extends StatefulWidget {
  const AsiOlmadim({super.key});

  @override
  State<AsiOlmadim> createState() => _AsiOlmadimState();
}

class _AsiOlmadimState extends State<AsiOlmadim> {
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
        title: const Text("Hiç Aşı Olmadım"),
        backgroundColor: Colors.lightGreen, // Yeşil tonlu AppBar
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Yaşınızı Giriniz",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightGreen), // Yeşil metin rengi
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: tfController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Yaşınızı Giriniz",
                  filled: true,
                  fillColor: Colors.green.shade50,
                  // Metin kutusunun arka planı açık yeşil
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 16,
                  ),
                ),
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: updateText,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    backgroundColor: Colors.lightGreen,
                    // Butonun arka plan rengi yeşil
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Devam Et",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              if (_asiPlan.isNotEmpty)
                Card(
                  color: Colors.green.shade50, // Kartın arka planı açık yeşil
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      _asiPlan,
                      style:
                          const TextStyle(fontSize: 18, color: Colors.black87),
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
