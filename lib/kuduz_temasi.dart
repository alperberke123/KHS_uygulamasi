import 'package:flutter/material.dart';

class kuduzTemasi extends StatefulWidget {
  const kuduzTemasi({super.key});

  @override
  State<kuduzTemasi> createState() => _kuduzTemasiState();
}

class _kuduzTemasiState extends State<kuduzTemasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("KUDUZ RİSKLİ TEMAS:",textAlign: TextAlign.start,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15),
              child: Text("""

0., 3., 7. günlerde birer doz ve 14 ile 28. günler arasında dördüncü doz veya
0. gün 2 doz, 7. ve 21. günlerde birer doz olmak		İLK BAŞVURU ACİL
          """,textAlign: TextAlign.center,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
            ),

          ],
        ),
      ),
    );
  }
}
