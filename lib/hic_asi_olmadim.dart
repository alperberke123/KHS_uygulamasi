import 'package:flutter/material.dart';

class asi_olmadim extends StatefulWidget {
  const asi_olmadim({super.key});

  @override
  State<asi_olmadim> createState() => _asi_olmadimState();
}

class _asi_olmadimState extends State<asi_olmadim> {
  var tfController = TextEditingController();
  String sonucYazi ="Yaşınızı Giriniz";

  void updateText(){
    setState(() {
      int yas = int.parse(tfController.text) ;

      if(yas >= 1 && yas<=6 ){
        sonucYazi = "Şunları yap";
      }if(yas>6 && yas<=14){
        sonucYazi ="Bunları yap";
      } if(yas>14){
        sonucYazi = "Onları yap";
      }else if(yas<0){
        sonucYazi = "Geçerli bir değer giriniz";
      }if(yas>120){
        sonucYazi ="Geçerli bir değer giriniz";
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
        child: Column(
          children: [
            SizedBox(height: 75,),
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

            SizedBox(height: 150),
            Text("$sonucYazi", style: TextStyle(fontSize: 24),),

          ],
        ),
      ),
    );
  }
}
