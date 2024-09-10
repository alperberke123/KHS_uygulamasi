import 'package:flutter/material.dart';

class anaSayfa extends StatefulWidget {
  const anaSayfa({super.key});

  @override
  State<anaSayfa> createState() => _anaSayfaState();
}

class _anaSayfaState extends State<anaSayfa> {

  var tfController = TextEditingController();
  var tfController2 = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Anasayfa"),
        backgroundColor: Colors.orangeAccent ,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Padding(
                  padding:  EdgeInsets.only(top: 20,left: 8),
                  child: Text("Ad ve Soyad :"),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: tfController2,
                      decoration: InputDecoration(
                        hintText: "Adınızı Giriniz",
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Padding(
                  padding:  EdgeInsets.only(top: 20,left: 8),
                  child: Text("Doğum Tarihi :"),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: tfController,
                      decoration: InputDecoration(
                        hintText: "Doğum Tarihinizi Seçiniz",
                      ),
                      readOnly: true,
                      onTap: (){
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        ).then((alinanTarih) {
                          setState(() {
                            tfController.text = "${alinanTarih!.day}/${alinanTarih.month}/${alinanTarih.year}";
                          }
                          );
                        }
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [

              ],
            ),
          ],
        ),
      ),
    );
  }
}
