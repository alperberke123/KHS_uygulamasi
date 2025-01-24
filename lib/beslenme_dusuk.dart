import 'package:flutter/material.dart';

class dusukKilolu_hareket extends StatefulWidget {
  const dusukKilolu_hareket({super.key});

  @override
  State<dusukKilolu_hareket> createState() => _dusukKilolu_hareketState();
}

class _dusukKilolu_hareketState extends State<dusukKilolu_hareket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fiziksel Aktivite Önerileri'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            const Text(
            '18 Yaş Üstü',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
          ),
          const SizedBox(height: 10),
          const Text(
            'Normal ve normal altı kilolu çıkanlar için:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
              '• Haftanın en az 5 günü ve günde en az 30 dakika orta şiddetli fiziksel aktiviteler'
             ' VEYA'
             ' • Haftanın en az 3 günü ve günde en az 20 dakika şiddetli fiziksel aktiviteler.',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 10),

        const SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => _buildActivityDetails(),
            );
          },
          child: const Row(
            children: [
              Text(
                'Ayrıntılı bilgi için tıklayınız ',
                style: TextStyle(fontSize: 16, color: Colors.blue, decoration: TextDecoration.underline),
              ),
            ],
          ),
        ),
        const Divider(height: 30, color: Colors.black),
        const Text(
          '6-17 Yaş Grubu',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
        ),
        const SizedBox(height: 10),
        const Text(
            '• Günde en az 60 dakika orta ve yüksek şiddetli fiziksel aktivite yapılmalıdır.'
            '• Kemik ve kasların güçlendirilmesini sağlayan yüksek şiddetli fiziksel aktiviteler haftada en az 3 gün yapılmalıdır.',
        style: TextStyle(fontSize: 16),
      ),
      const SizedBox(height: 20),
      const Text(
        'Aktivite Örnekleri:',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      const Text(
          '6-9 Yaş: Belli mesafeye fırlatma, bir topa vurmak.'
         ' 10-17 Yaş: Basketbol, futbol gibi sporlar.',
      style: TextStyle(fontSize: 16),
    ),
    const Divider(height: 30, color: Colors.black),
    const Text(
    '2-5 Yaş Grubu',
    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orange),
    ),
    const SizedBox(height: 10),
    const Text(
    '• Fırlatma, yakalama, koşma, sıçrama gibi aktiviteler önerilmektedir.',
    style: TextStyle(fontSize: 16),
    ),
    ],
    ),
    ),
    ),
    );
  }

  Widget _buildActivityDetails() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Orta Şiddette Fiziksel Aktiviteler',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text('• Tempolu yürüyüş (saatte yaklaşık 5 km)'),
          Text('• Bahçe işleri'),
          Text('• Ev işleri (süpürme, silme)'),
          Text('• Bisiklet (saatte 16 km)'),
          Text('• Hafif ritimde halk oyunları'),
          Text('• Salon dansları'),
          Text('• Tenis (çift)'),
          SizedBox(height: 20),
          Text(
            'Şiddetli Fiziksel Aktiviteler',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text('• Koşu/jogging (saatte 8 km)'),
          Text('• Bisiklet (saatte 16 km)'),
          Text('• Yüzme'),
          Text('• Aerobik egzersizler'),
          Text('• Çok hızlı yürüme (saatte 7 km hız ile)'),
          Text('• Ağırlık kaldırma'),
          Text('• Basketbol'),
        ],
      ),
    );
  }
}
