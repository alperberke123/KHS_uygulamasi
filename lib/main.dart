import 'package:flutter/material.dart';
import 'package:ksh_uygulamasi/ikinci_sayfa.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.orangeAccent,
        useMaterial3: true,
      ),
      home:  bilgilendirmeSayfasi(),
    );
  }
}

class bilgilendirmeSayfasi extends StatefulWidget {
  const bilgilendirmeSayfasi({super.key});

  @override
  State<bilgilendirmeSayfasi> createState() => _bilgilendirmeSayfasiState();
}

class _bilgilendirmeSayfasiState extends State<bilgilendirmeSayfasi> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Text("UYGULAMAMIZ HAKKINDA",style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),),
            SizedBox(
              width: 20,
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("Uyglumamız Koruyucu Sağlık Hizmetleri hakkında insanları bilgilendirmeyi amaçlamaktadır. Bu şekilde insanlar hem "
                  "ileride oluşabilecek hastalıklara erken önlem almış olacaklar hem de şuan halihazırda var olabilecek hastalıklara "
                  "karşı bilgilendirilmiş olacaklar."
              ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400)),
            ),
            Spacer(),
            ElevatedButton(
              child: Text("Diğer sayfa için tıklayınız",style: TextStyle(color: Colors.white),),
              style: ElevatedButton.styleFrom(
                  shape: LinearBorder(),
                backgroundColor: Colors.red,

              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => sayfa2()));
              },
            ),
            Spacer(),
            
          ],
        ),
      ),
    );
  }
}

