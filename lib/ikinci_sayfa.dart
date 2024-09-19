import 'package:flutter/material.dart';
import 'package:ksh_uygulamasi/anaSayfa.dart';
import 'package:ksh_uygulamasi/her_seyi_gosteren_sayfa.dart';
import 'package:ksh_uygulamasi/hic_asi_olmadim.dart';
import 'package:ksh_uygulamasi/kuduz_temasi.dart';

class sayfa2 extends StatefulWidget {
  const sayfa2({super.key});

  @override
  State<sayfa2> createState() => _sayfa2State();
}

class _sayfa2State extends State<sayfa2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(

          children: [
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Yakın zamanda kuduz açısından riskli bir temas gerçekleştirdiyseniz tıklayınız.",textAlign: TextAlign.center,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500),),
            ),
            SizedBox(
              width: 175,
              height: 40,
              child: ElevatedButton(
                child: Text("Kuduz Riskli Temas",style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  shape: LinearBorder(),
                  backgroundColor: Colors.redAccent,
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => kuduzTemasi()));
                },
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Hiç aşı olmadıysanız aşağıdaki butona tıklayabilirisiniz.",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500),),
            ),
            SizedBox(
              height: 40,
              width: 175,
              child: ElevatedButton(
                child: Text("Hiç Aşı Olmadım",style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  shape: LinearBorder(),
                  backgroundColor: Colors.redAccent,
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => asi_olmadim()));
                },
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("KHS hakkında genel bilgi sahibi olmak için",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500)),
            ),
            SizedBox(
              width: 175,
              height: 40,
              child: ElevatedButton(
                child: Text("Genel Olarak KHS",style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  shape: LinearBorder(),
                  backgroundColor: Colors.redAccent,
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DataPage()));
                },
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Kişisel bilgilerinizi girmek için aşağıadki butona tıkalayın",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500)),
            ),
            SizedBox(
              width: 175,
              height: 40,
              child: ElevatedButton(
                child: Text("Devam Et",style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  shape: LinearBorder(),
                  backgroundColor: Colors.redAccent,
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => anaSayfa()));
                },
              ),
            ),
            Spacer(),

          ],
        ),
      ),
    );
  }
}
