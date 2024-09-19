import 'package:flutter/material.dart';

class asi_olmadim extends StatefulWidget {
  const asi_olmadim({super.key});

  @override
  State<asi_olmadim> createState() => _asi_olmadimState();
}

class _asi_olmadimState extends State<asi_olmadim> {
  var tfController = TextEditingController();
  String sonucYazi ="";
  String _asiPlan = "";

  void updateText(){
    setState(() {
      int yas = int.parse(tfController.text) ;
    if(yas>=1 && yas<= 6){
      _asiPlan = """
1-6 Yaş Aşı Planı: 
- DaBT-İPA-Hib, Hep B, TCT, Suçiçeği, Hep A - İlk Karşılaşma 
- KKK, TCT sonucuna göre gerekiyorsa BCG - İlk Karşılaşmadan 2 Gün Sonra
- DaBT-İPA-Hib, Hep B, OPA, KPA - İlk Karşılaşmadan 2 Ay Sonra
- DaBT-İPA-Hib, Hep B, OPA, Hep A - İlk Karşılaşmadan 8 Ay Sonra
        """;
    }
    if (yas >= 6 && yas < 14) {

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

  }else if(yas <0){
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
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
             Row(
               children: [
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Text("Yaşınızı Giriniz :"),
                 ),
                 Expanded(
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: TextField(
                       controller: tfController,
                       keyboardType: TextInputType.number,
                       decoration: InputDecoration(
                         hintText: "Yaşınızı Giriniz",
                       ),
                     ),
                   ),
                 ),
               ],
             ),
              ElevatedButton(onPressed: updateText, child: Text("Devam Et",style: TextStyle(color: Colors.white),),
              style: ElevatedButton.styleFrom(
                shape: LinearBorder(),
                backgroundColor: Colors.red,
              ),
              ),
              SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("$_asiPlan", style: TextStyle(fontSize: 20),),
              ),
          
            ],
          ),
        ),
      ),
    );
  }
}
