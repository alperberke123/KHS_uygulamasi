import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';
import 'dart:developer' as developer;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  
  // Bildirim ID'lerini takip etmek için sayaç
  int _notificationId = 0;
  
  // Bildirim kanallarını oluştur
  Future<void> _createNotificationChannels() async {
    const AndroidNotificationChannel specialDaysChannel = AndroidNotificationChannel(
      'special_days_channel',
      'Özel Günler',
      description: 'Özel günler için bildirimler',
      importance: Importance.high,
    );

    const AndroidNotificationChannel yearlyScreeningChannel = AndroidNotificationChannel(
      'yearly_screening_channel',
      'Yıllık Taramalar',
      description: 'Yıllık sağlık taramaları için bildirimler',
      importance: Importance.high,
    );

    const AndroidNotificationChannel ageBasedScreeningChannel = AndroidNotificationChannel(
      'age_based_screening_channel',
      'Yaşa Bağlı Taramalar',
      description: 'Yaşa bağlı sağlık taramaları için bildirimler',
      importance: Importance.high,
    );

    const AndroidNotificationChannel babyScreeningChannel = AndroidNotificationChannel(
      'baby_screening_channel',
      'Bebek Taramaları',
      description: 'Bebekler için aylık sağlık taramaları',
      importance: Importance.high,
    );

    const AndroidNotificationChannel testChannel = AndroidNotificationChannel(
      'test_channel',
      'Test Bildirimleri',
      description: 'Test bildirimleri için kanal',
      importance: Importance.max,
      enableVibration: true,
      playSound: true,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(specialDaysChannel);
    
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(yearlyScreeningChannel);
    
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(ageBasedScreeningChannel);
    
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(babyScreeningChannel);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(testChannel);
  }

  Future<void> init() async {
    try {
      developer.log('Bildirim servisi başlatılıyor...');
      
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

      await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse response) {
          developer.log('Bildirime tıklandı: ${response.payload}');
        },
      );

      // Bildirim kanallarını oluştur
      await _createNotificationChannels();
      developer.log('Bildirim kanalları oluşturuldu');

    // Timezone verilerini yükle ve cihazın timezone'unu ayarla
    tz.initializeTimeZones();
    final String deviceTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(deviceTimeZone));
      
      developer.log('Bildirim servisi başlatıldı. Timezone: $deviceTimeZone');
      
      // Tüm bekleyen bildirimleri temizle
      await flutterLocalNotificationsPlugin.cancelAll();
      developer.log('Tüm bekleyen bildirimler temizlendi');

      // Bildirim izinlerini kontrol et
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      if (androidImplementation != null) {
        final bool? granted = await androidImplementation.requestNotificationsPermission();
        developer.log('Bildirim izinleri: ${granted == true ? 'Verildi' : 'Verilmedi'}');
      }
      
    } catch (e) {
      developer.log('Bildirim servisi başlatılırken hata: $e');
    }
  }

  tz.TZDateTime _scheduleAtFutureTime({
    required int year,
    required int month,
    required int day,
    int hour = 9,
    int minute = 0,
  }) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    // Test için her zaman 10 saniye sonraya ayarla
    return now.add(const Duration(seconds: 10));
  }

  Future<void> scheduleSpecialDayNotification({
    required String title,
    required String message,
    required tz.TZDateTime scheduledDate,
  }) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      _notificationId++,
      title,
      message,
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'special_days_channel',
          'Özel Günler',
          channelDescription: 'Özel günler için bildirimler',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
  }

  Future<void> scheduleYearlyScreeningNotification({
    required String title,
    required String message,
    required tz.TZDateTime scheduledDate,
  }) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      1, // Benzersiz ID
      title,
      message,
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'yearly_screening_channel',
          'Yıllık Taramalar',
          channelDescription: 'Yıllık sağlık taramaları için bildirimler',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
  }

  Future<void> scheduleAgeBasedScreeningNotification({
    required String title,
    required String message,
    required tz.TZDateTime scheduledDate,
    required int age,
  }) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      2, // Benzersiz ID
      title,
      message,
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'age_based_screening_channel',
          'Yaşa Bağlı Taramalar',
          channelDescription: 'Yaşa bağlı sağlık taramaları için bildirimler',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
  }

  Future<void> scheduleBabyMonthlyScreeningNotification({
    required String title,
    required String message,
    required tz.TZDateTime scheduledDate,
    required int month,
  }) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      3, // Benzersiz ID
      title,
      message,
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'baby_screening_channel',
          'Bebek Taramaları',
          channelDescription: 'Bebekler için aylık sağlık taramaları',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
  }

  Future<void> showTestNotification() async {
    try {
      developer.log('Test bildirimi gönderiliyor...');
      
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'test_channel',
        'Test Bildirimleri',
        channelDescription: 'Test bildirimleri için kanal',
        importance: Importance.max,
        priority: Priority.high,
        enableVibration: true,
        playSound: true,
      );
      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
      
      await flutterLocalNotificationsPlugin.show(
        0,
        'Test Bildirimi',
        'Bu bir test bildirimidir',
        platformChannelSpecifics,
      );
      developer.log('Test bildirimi başarıyla gönderildi');
    } catch (e) {
      developer.log('Test bildirimi gönderilirken hata: $e');
    }
  }

  Future<void> scheduleTestNotification() async {
    try {
      developer.log('Zamanlanmış test bildirimi planlanıyor...');
      
      final now = tz.TZDateTime.now(tz.local);
      final scheduledDate = now.add(const Duration(seconds: 10));
      
      developer.log('Bildirim zamanı: $scheduledDate');

      // Önce mevcut bildirimi iptal et
      await flutterLocalNotificationsPlugin.cancel(_notificationId);

      await flutterLocalNotificationsPlugin.zonedSchedule(
        _notificationId++,
        'Zamanlanmış Test Bildirimi',
        'Bu bildirim 10 saniye sonra gönderildi',
        scheduledDate,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'test_channel',
            'Test Bildirimleri',
            channelDescription: 'Test bildirimleri için kanal',
            importance: Importance.max,
            priority: Priority.high,
            enableVibration: true,
            playSound: true,
            category: AndroidNotificationCategory.alarm,
            fullScreenIntent: true,
            visibility: NotificationVisibility.public,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: null,
      );
      developer.log('Zamanlanmış test bildirimi başarıyla planlandı. ID: ${_notificationId - 1}');
    } catch (e) {
      developer.log('Zamanlanmış test bildirimi planlanırken hata: $e');
    }
  }

  Future<void> scheduleAllSpecialDays() async {
    try {
      final now = tz.TZDateTime.now(tz.local);
      developer.log('Özel gün bildirimleri planlanıyor. Şu anki zaman: $now');

    // Sabit tarihli özel günler
    final specialDays = [
        {'date': DateTime(now.year, 2, 4), 'title': 'Dünya Kanser Günü', 'message': '4 Şubat Dünya Kanser Günü!'},
        {'date': DateTime(now.year, 2, 9), 'title': 'Sigarayı Bırakma Günü', 'message': '9 Şubat Sigarayı Bırakma Günü!'},
        {'date': DateTime(now.year, 3, 3), 'title': 'Dünya Kulak ve İşitme Günü', 'message': '3 Mart Dünya Kulak ve İşitme Günü!'},
        {'date': DateTime(now.year, 3, 4), 'title': 'Dünya Obezite Günü', 'message': '4 Mart Dünya Obezite Günü!'},
        {'date': DateTime(now.year, 3, 24), 'title': 'Dünya Tüberküloz Günü', 'message': '24 Mart Dünya Tüberküloz Günü!'},
        {'date': DateTime(now.year, 4, 2), 'title': 'Dünya Otizm Farkındalık Günü', 'message': '2 Nisan Dünya Otizm Farkındalık Günü!'},
        {'date': DateTime(now.year, 4, 15), 'title': 'Büyümenin İzlenmesi Günü', 'message': '15 Nisan Büyümenin İzlenmesi Günü!'},
        {'date': DateTime(now.year, 4, 17), 'title': 'Dünya Hemofili Günü', 'message': '17 Nisan Dünya Hemofili Günü!'},
        {'date': DateTime(now.year, 5, 8), 'title': 'Dünya Talasemi Günü', 'message': '8 Mayıs Dünya Talasemi Günü!'},
        {'date': DateTime(now.year, 5, 10), 'title': 'Dünya Sağlık İçin Hareket Et Günü', 'message': '10 Mayıs Dünya Sağlık İçin Hareket Et Günü!'},
        {'date': DateTime(now.year, 5, 17), 'title': 'Dünya Hipertansiyon Günü', 'message': '17 Mayıs Dünya Hipertansiyon Günü!'},
        {'date': DateTime(now.year, 5, 31), 'title': 'Dünya Tütünsüz Günü', 'message': '31 Mayıs Dünya Tütünsüz Günü!'},
        {'date': DateTime(now.year, 6, 1), 'title': 'Ulusal Fenilketonüri Günü', 'message': '1 Haziran Ulusal Fenilketonüri Günü!'},
        {'date': DateTime(now.year, 6, 26), 'title': 'Dünya Uyuşturucu Kullanımı ve Kaçakçılığı ile Mücadele Günü', 'message': '26 Haziran Dünya Uyuşturucu Kullanımı ve Kaçakçılığı ile Mücadele Günü!'},
        {'date': DateTime(now.year, 7, 28), 'title': 'Dünya Hepatit Günü', 'message': '28 Temmuz Dünya Hepatit Günü!'},
        {'date': DateTime(now.year, 9, 10), 'title': 'Dünya İntiharı Önleme Günü', 'message': '10 Eylül Dünya İntiharı Önleme Günü!'},
        {'date': DateTime(now.year, 9, 26), 'title': 'Dünya Doğum Kontrol Günü', 'message': '26 Eylül Dünya Doğum Kontrol Günü!'},
        {'date': DateTime(now.year, 9, 27), 'title': 'Dünya Okul Süt Günü', 'message': '27 Eylül Dünya Okul Süt Günü!'},
        {'date': DateTime(now.year, 9, 28), 'title': 'Dünya Kuduz Günü', 'message': '28 Eylül Dünya Kuduz Günü!'},
        {'date': DateTime(now.year, 9, 29), 'title': 'Dünya Kalp Günü', 'message': '29 Eylül Dünya Kalp Günü!'},
        {'date': DateTime(now.year, 10, 1), 'title': 'Dünya Yaşlılar Günü', 'message': '1 Ekim Dünya Yaşlılar Günü!'},
        {'date': DateTime(now.year, 10, 3), 'title': 'Dünya Yürüyüş Günü', 'message': '3 Ekim Dünya Yürüyüş Günü!'},
        {'date': DateTime(now.year, 10, 10), 'title': 'Dünya Ruh Sağlığı Günü', 'message': '10 Ekim Dünya Ruh Sağlığı Günü!'},
        {'date': DateTime(now.year, 10, 13), 'title': 'Uluslararası Afet Risklerinin Azaltılması Günü', 'message': '13 Ekim Uluslararası Afet Risklerinin Azaltılması Günü!'},
        {'date': DateTime(now.year, 10, 15), 'title': 'Dünya El Yıkama Günü', 'message': '15 Ekim Dünya El Yıkama Günü!'},
        {'date': DateTime(now.year, 11, 14), 'title': 'Dünya Diyabet Günü', 'message': '14 Kasım Dünya Diyabet Günü!'},
        {'date': DateTime(now.year, 11, 18), 'title': 'Avrupa Antibiyotik Farkındalık Günü', 'message': '18 Kasım Avrupa Antibiyotik Farkındalık Günü!'},
        {'date': DateTime(now.year, 12, 1), 'title': 'Dünya AIDS Günü', 'message': '1 Aralık Dünya AIDS Günü!'},
        {'date': DateTime(now.year, 12, 3), 'title': 'Dünya Engelliler Günü', 'message': '3 Aralık Dünya Engelliler Günü!'},
      ];

      // Her özel gün için bildirim planla
    for (var day in specialDays) {
        // Eğer tarih geçmişse, gelecek yıl için planla
        DateTime scheduledDate = day['date'] as DateTime;
        if (scheduledDate.isBefore(now)) {
          scheduledDate = DateTime(now.year + 1, scheduledDate.month, scheduledDate.day);
        }

        // Bildirimi saat 9:00'da göster
        final notificationDate = tz.TZDateTime(
          tz.local,
          scheduledDate.year,
          scheduledDate.month,
          scheduledDate.day,
          9, // saat
          0, // dakika
        );

        // Önce mevcut bildirimi iptal et
        await flutterLocalNotificationsPlugin.cancel(_notificationId);

        await flutterLocalNotificationsPlugin.zonedSchedule(
          _notificationId++,
          day['title'] as String,
          day['message'] as String,
          notificationDate,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'special_days_channel',
              'Özel Günler',
              channelDescription: 'Özel günler için bildirimler',
              importance: Importance.max,
              priority: Priority.high,
              enableVibration: true,
              playSound: true,
              category: AndroidNotificationCategory.alarm,
              fullScreenIntent: true,
              visibility: NotificationVisibility.public,
            ),
          ),
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: null,
        );
        
        developer.log('${day['title']} bildirimi planlandı: $notificationDate');
      }

      // Süreli özel günler için bildirimler
      final specialPeriods = [
        {
          'startMonth': 1,
          'startDay': 1,
          'endMonth': 1,
          'endDay': 31,
          'title': 'Rahim Ağzı (Serviks) Kanseri Farkındalık Ayı',
          'message': '1-31 Ocak boyunca Serviks Kanseri Farkındalığı!'
        },
        {
          'startMonth': 3,
          'startDay': 1,
          'endMonth': 3,
          'endDay': 7,
          'title': 'Yeşilay Haftası',
          'message': '1-7 Mart Yeşilay Haftası!'
        },
        // Diğer süreli özel günler buraya eklenebilir
      ];

      // Her süreli özel gün için bildirim planla
      for (var period in specialPeriods) {
        final startDate = DateTime(now.year, period['startMonth'] as int, period['startDay'] as int);
        final endDate = DateTime(now.year, period['endMonth'] as int, period['endDay'] as int);

        // Eğer süre geçmişse, gelecek yıl için planla
        if (endDate.isBefore(now)) {
          final nextYearStart = DateTime(now.year + 1, period['startMonth'] as int, period['startDay'] as int);
          final nextYearEnd = DateTime(now.year + 1, period['endMonth'] as int, period['endDay'] as int);

          // Başlangıç ve bitiş bildirimlerini planla
          await _schedulePeriodNotification(
            nextYearStart,
            period['title'] as String,
            '${period['title']} başladı!',
          );

          await _schedulePeriodNotification(
            nextYearEnd,
            period['title'] as String,
            '${period['title']} sona eriyor!',
          );
        } else if (startDate.isAfter(now)) {
          // Bu yıl için planla
          await _schedulePeriodNotification(
            startDate,
            period['title'] as String,
            '${period['title']} başladı!',
          );

          await _schedulePeriodNotification(
            endDate,
            period['title'] as String,
            '${period['title']} sona eriyor!',
          );
        }
      }

      developer.log('Tüm özel gün bildirimleri planlandı');
    } catch (e) {
      developer.log('Özel gün bildirimleri planlanırken hata: $e');
    }
  }

  // Background'da çalışan versiyon - UI'yi bloklamaz
  void scheduleAllSpecialDaysInBackground() {
    // Background thread'de çalıştır
    Future.microtask(() async {
      try {
        developer.log('Özel gün bildirimleri background\'da planlanmaya başladı');
        
        // Bildirimleri batch halinde planla (UI'yi bloklamaz)
        await _scheduleSpecialDaysInBatches();
        
        developer.log('Tüm özel gün bildirimleri background\'da planlandı');
      } catch (e) {
        developer.log('Background bildirim planlama hatası: $e');
      }
    });
  }

  // Bildirimleri küçük gruplar halinde planlar (UI blokajını önler)
  Future<void> _scheduleSpecialDaysInBatches() async {
    final now = tz.TZDateTime.now(tz.local);
    
    // Özel günleri batch'lere böl (her batch'te 5 bildirim)
    const batchSize = 5;
    final specialDays = _getSpecialDaysList(now.year);
    
    for (int i = 0; i < specialDays.length; i += batchSize) {
      final batch = specialDays.skip(i).take(batchSize);
      
      // Her batch'i planla
      await _scheduleBatch(batch.toList(), now);
      
      // UI thread'e nefes verme süresi (1ms)
      await Future.delayed(const Duration(milliseconds: 1));
    }
    
    // Süreli özel günleri de planla
    await _scheduleSpecialPeriods(now);
  }

  // Batch bildirimlerini planlar
  Future<void> _scheduleBatch(List<Map<String, dynamic>> batch, tz.TZDateTime now) async {
    final futures = <Future>[];
    
    for (var day in batch) {
      futures.add(_scheduleSpecialDayAsync(day, now));
    }
    
    // Paralel olarak planla
    await Future.wait(futures);
  }

  // Tek bir özel günü asenkron olarak planlar
  Future<void> _scheduleSpecialDayAsync(Map<String, dynamic> day, tz.TZDateTime now) async {
    try {
      DateTime scheduledDate = day['date'] as DateTime;
      if (scheduledDate.isBefore(now)) {
        scheduledDate = DateTime(now.year + 1, scheduledDate.month, scheduledDate.day);
      }

      final notificationDate = tz.TZDateTime(
        tz.local,
        scheduledDate.year,
        scheduledDate.month,
        scheduledDate.day,
        9, 0,
      );

      await flutterLocalNotificationsPlugin.zonedSchedule(
        _notificationId++,
        day['title'] as String,
        day['message'] as String,
        notificationDate,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'special_days_channel',
            'Özel Günler',
            channelDescription: 'Özel günler için bildirimler',
            importance: Importance.high,
            priority: Priority.high,
            enableVibration: true,
            playSound: true,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
      
      developer.log('${day['title']} bildirimi planlandı: $notificationDate');
    } catch (e) {
      developer.log('${day['title']} bildirimi planlanırken hata: $e');
    }
  }

  // Özel günler listesini döndürür
  List<Map<String, dynamic>> _getSpecialDaysList(int year) {
    return [
      {'date': DateTime(year, 2, 4), 'title': 'Dünya Kanser Günü', 'message': '4 Şubat Dünya Kanser Günü!'},
      {'date': DateTime(year, 2, 9), 'title': 'Sigarayı Bırakma Günü', 'message': '9 Şubat Sigarayı Bırakma Günü!'},
      {'date': DateTime(year, 3, 3), 'title': 'Dünya Kulak ve İşitme Günü', 'message': '3 Mart Dünya Kulak ve İşitme Günü!'},
      {'date': DateTime(year, 3, 4), 'title': 'Dünya Obezite Günü', 'message': '4 Mart Dünya Obezite Günü!'},
      {'date': DateTime(year, 3, 24), 'title': 'Dünya Tüberküloz Günü', 'message': '24 Mart Dünya Tüberküloz Günü!'},
      {'date': DateTime(year, 4, 2), 'title': 'Dünya Otizm Farkındalık Günü', 'message': '2 Nisan Dünya Otizm Farkındalık Günü!'},
      {'date': DateTime(year, 4, 15), 'title': 'Büyümenin İzlenmesi Günü', 'message': '15 Nisan Büyümenin İzlenmesi Günü!'},
      {'date': DateTime(year, 4, 17), 'title': 'Dünya Hemofili Günü', 'message': '17 Nisan Dünya Hemofili Günü!'},
      {'date': DateTime(year, 5, 8), 'title': 'Dünya Talasemi Günü', 'message': '8 Mayıs Dünya Talasemi Günü!'},
      {'date': DateTime(year, 5, 10), 'title': 'Dünya Sağlık İçin Hareket Et Günü', 'message': '10 Mayıs Dünya Sağlık İçin Hareket Et Günü!'},
      {'date': DateTime(year, 5, 17), 'title': 'Dünya Hipertansiyon Günü', 'message': '17 Mayıs Dünya Hipertansiyon Günü!'},
      {'date': DateTime(year, 5, 31), 'title': 'Dünya Tütünsüz Günü', 'message': '31 Mayıs Dünya Tütünsüz Günü!'},
      {'date': DateTime(year, 6, 1), 'title': 'Ulusal Fenilketonüri Günü', 'message': '1 Haziran Ulusal Fenilketonüri Günü!'},
      {'date': DateTime(year, 6, 26), 'title': 'Dünya Uyuşturucu Kullanımı ve Kaçakçılığı ile Mücadele Günü', 'message': '26 Haziran Dünya Uyuşturucu Kullanımı ve Kaçakçılığı ile Mücadele Günü!'},
      {'date': DateTime(year, 7, 28), 'title': 'Dünya Hepatit Günü', 'message': '28 Temmuz Dünya Hepatit Günü!'},
      {'date': DateTime(year, 9, 10), 'title': 'Dünya İntiharı Önleme Günü', 'message': '10 Eylül Dünya İntiharı Önleme Günü!'},
      {'date': DateTime(year, 9, 26), 'title': 'Dünya Doğum Kontrol Günü', 'message': '26 Eylül Dünya Doğum Kontrol Günü!'},
      {'date': DateTime(year, 9, 27), 'title': 'Dünya Okul Süt Günü', 'message': '27 Eylül Dünya Okul Süt Günü!'},
      {'date': DateTime(year, 9, 28), 'title': 'Dünya Kuduz Günü', 'message': '28 Eylül Dünya Kuduz Günü!'},
      {'date': DateTime(year, 9, 29), 'title': 'Dünya Kalp Günü', 'message': '29 Eylül Dünya Kalp Günü!'},
      {'date': DateTime(year, 10, 1), 'title': 'Dünya Yaşlılar Günü', 'message': '1 Ekim Dünya Yaşlılar Günü!'},
      {'date': DateTime(year, 10, 3), 'title': 'Dünya Yürüyüş Günü', 'message': '3 Ekim Dünya Yürüyüş Günü!'},
      {'date': DateTime(year, 10, 10), 'title': 'Dünya Ruh Sağlığı Günü', 'message': '10 Ekim Dünya Ruh Sağlığı Günü!'},
      {'date': DateTime(year, 10, 13), 'title': 'Uluslararası Afet Risklerinin Azaltılması Günü', 'message': '13 Ekim Uluslararası Afet Risklerinin Azaltılması Günü!'},
      {'date': DateTime(year, 10, 15), 'title': 'Dünya El Yıkama Günü', 'message': '15 Ekim Dünya El Yıkama Günü!'},
      {'date': DateTime(year, 11, 14), 'title': 'Dünya Diyabet Günü', 'message': '14 Kasım Dünya Diyabet Günü!'},
      {'date': DateTime(year, 11, 18), 'title': 'Avrupa Antibiyotik Farkındalık Günü', 'message': '18 Kasım Avrupa Antibiyotik Farkındalık Günü!'},
      {'date': DateTime(year, 12, 1), 'title': 'Dünya AIDS Günü', 'message': '1 Aralık Dünya AIDS Günü!'},
      {'date': DateTime(year, 12, 3), 'title': 'Dünya Engelliler Günü', 'message': '3 Aralık Dünya Engelliler Günü!'},
    ];
  }

  // Süreli özel günleri planlar
  Future<void> _scheduleSpecialPeriods(tz.TZDateTime now) async {
    final specialPeriods = [
      {
        'startMonth': 1, 'startDay': 1, 'endMonth': 1, 'endDay': 31,
        'title': 'Rahim Ağzı (Serviks) Kanseri Farkındalık Ayı',
        'message': '1-31 Ocak boyunca Serviks Kanseri Farkındalığı!'
      },
      {
        'startMonth': 3, 'startDay': 1, 'endMonth': 3, 'endDay': 7,
        'title': 'Yeşilay Haftası',
        'message': '1-7 Mart Yeşilay Haftası!'
      },
    ];

    for (var period in specialPeriods) {
      final startDate = DateTime(now.year, period['startMonth'] as int, period['startDay'] as int);
      final endDate = DateTime(now.year, period['endMonth'] as int, period['endDay'] as int);

      if (endDate.isBefore(now)) {
        final nextYearStart = DateTime(now.year + 1, period['startMonth'] as int, period['startDay'] as int);
        final nextYearEnd = DateTime(now.year + 1, period['endMonth'] as int, period['endDay'] as int);

        await _schedulePeriodNotification(nextYearStart, period['title'] as String, '${period['title']} başladı!');
        await _schedulePeriodNotification(nextYearEnd, period['title'] as String, '${period['title']} sona eriyor!');
      } else if (startDate.isAfter(now)) {
        await _schedulePeriodNotification(startDate, period['title'] as String, '${period['title']} başladı!');
        await _schedulePeriodNotification(endDate, period['title'] as String, '${period['title']} sona eriyor!');
      }
    }
  }

  Future<void> _schedulePeriodNotification(DateTime date, String title, String message) async {
    final notificationDate = tz.TZDateTime(
      tz.local,
      date.year,
      date.month,
      date.day,
      9, // saat
      0, // dakika
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      _notificationId++,
      title,
      message,
      notificationDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'special_days_channel',
          'Özel Günler',
          channelDescription: 'Özel günler için bildirimler',
          importance: Importance.max,
          priority: Priority.high,
          enableVibration: true,
          playSound: true,
          category: AndroidNotificationCategory.alarm,
          fullScreenIntent: true,
          visibility: NotificationVisibility.public,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: null,
    );
    
    developer.log('$title bildirimi planlandı: $notificationDate');
  }

  Future<void> scheduleUserHealthScreenings({
    required DateTime birthDate,
    required bool isPregnant,
    required bool hasChronicDisease,
  }) async {
    try {
      final now = tz.TZDateTime.now(tz.local);
      final age = now.year - birthDate.year;
      developer.log('Kullanıcı sağlık taramaları planlanıyor. Yaş: $age');

      // 5 yıllık taramalar
      await scheduleFiveYearScreenings(age);

      // Yıllık taramalar
      await scheduleYearlyScreenings(age);

      // Yaşa bağlı özel taramalar
      if (age >= 40) {
        await scheduleFortyPlusScreenings(age);
      }

      if (age >= 50) {
        await scheduleFiftyPlusScreenings(age);
      }

      // Kronik hastalık durumuna göre taramalar
      if (hasChronicDisease) {
        await scheduleMonthlyChronicDiseaseScreenings();
      }

      // Hamilelik durumuna göre taramalar
      if (isPregnant) {
        await scheduleMonthlyPregnancyScreenings();
      }

      developer.log('Kullanıcı sağlık taramaları planlandı');
    } catch (e) {
      developer.log('Kullanıcı sağlık taramaları planlanırken hata: $e');
    }
  }

  Future<void> scheduleFiveYearScreenings(int age) async {
    final now = tz.TZDateTime.now(tz.local);
    
    // 5 yıllık taramalar
    final List<Map<String, dynamic>> fiveYearScreenings = [
      {
        'title': 'Serum Lipid Profili',
        'message': '5 yıllık serum lipid profili taramanızı yaptırmayı unutmayın.',
        'startAge': 20,
      },
      {
        'title': 'Tam Kan Sayımı',
        'message': '5 yıllık tam kan sayımı taramanızı yaptırmayı unutmayın.',
        'startAge': 20,
      },
      {
        'title': 'Böbrek Fonksiyon Testleri',
        'message': '5 yıllık böbrek fonksiyon testlerinizi yaptırmayı unutmayın.',
        'startAge': 30,
      },
    ];

    for (var screening in fiveYearScreenings) {
      final int startAge = screening['startAge'] as int;
      if (age >= startAge) {
        // Son 5 yılın başlangıcını hesapla
        final lastScreeningYear = (age ~/ 5) * 5;
        final nextScreeningYear = lastScreeningYear + 5;
        
        // Bir sonraki tarama tarihini hesapla
        final nextScreeningDate = tz.TZDateTime(
          tz.local,
          now.year + (nextScreeningYear - age),
          now.month,
          now.day,
          9,
          0,
        );

        await flutterLocalNotificationsPlugin.zonedSchedule(
          _notificationId++,
          screening['title'] as String,
          screening['message'] as String,
          nextScreeningDate,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'five_year_screening_channel',
              '5 Yıllık Taramalar',
              channelDescription: '5 yılda bir yapılması gereken taramalar',
              importance: Importance.high,
              priority: Priority.high,
            ),
          ),
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: null,
        );
        
        developer.log('${screening['title']} bildirimi planlandı: $nextScreeningDate');
      }
    }
  }

  Future<void> scheduleYearlyScreenings(int age) async {
    final now = tz.TZDateTime.now(tz.local);
    
    // Yıllık taramalar
    final List<Map<String, dynamic>> yearlyScreenings = [
      {
        'title': 'Genel Sağlık Kontrolü',
        'message': 'Yıllık genel sağlık kontrolünüzü yaptırmayı unutmayın.',
        'startAge': 0,
      },
      {
        'title': 'Göz Muayenesi',
        'message': 'Yıllık göz muayenenizi yaptırmayı unutmayın.',
        'startAge': 0,
      },
      {
        'title': 'Diş Muayenesi',
        'message': 'Yıllık diş muayenenizi yaptırmayı unutmayın.',
        'startAge': 0,
      },
    ];

    for (var screening in yearlyScreenings) {
      final int startAge = screening['startAge'] as int;
      if (age >= startAge) {
        final nextScreeningDate = tz.TZDateTime(
          tz.local,
          now.year + 1,
          now.month,
          now.day,
          9,
          0,
        );

        await flutterLocalNotificationsPlugin.zonedSchedule(
          _notificationId++,
          screening['title'] as String,
          screening['message'] as String,
          nextScreeningDate,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'yearly_screening_channel',
              'Yıllık Taramalar',
              channelDescription: 'Yılda bir yapılması gereken taramalar',
              importance: Importance.high,
              priority: Priority.high,
            ),
          ),
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: null,
        );
        
        developer.log('${screening['title']} bildirimi planlandı: $nextScreeningDate');
      }
    }
  }

  Future<void> scheduleFortyPlusScreenings(int age) async {
    final now = tz.TZDateTime.now(tz.local);
    
    // 40 yaş ve üzeri taramalar
    final List<Map<String, dynamic>> fortyPlusScreenings = [
      {
        'title': 'Mamografi',
        'message': 'Yıllık mamografi taramanızı yaptırmayı unutmayın.',
        'frequency': 'yearly',
      },
      {
        'title': 'Prostat Spesifik Antijen (PSA)',
        'message': 'Yıllık PSA testinizi yaptırmayı unutmayın.',
        'frequency': 'yearly',
      },
    ];

    for (var screening in fortyPlusScreenings) {
      final nextScreeningDate = tz.TZDateTime(
        tz.local,
        now.year + 1,
        now.month,
        now.day,
        9,
        0,
      );

      await flutterLocalNotificationsPlugin.zonedSchedule(
        _notificationId++,
        screening['title'] as String,
        screening['message'] as String,
        nextScreeningDate,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'forty_plus_screening_channel',
            '40+ Taramalar',
            channelDescription: '40 yaş ve üzeri için özel taramalar',
            importance: Importance.high,
            priority: Priority.high,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: null,
      );
      
      developer.log('${screening['title']} bildirimi planlandı: $nextScreeningDate');
    }
  }

  Future<void> scheduleFiftyPlusScreenings(int age) async {
    final now = tz.TZDateTime.now(tz.local);
    
    // 50 yaş ve üzeri taramalar
    final List<Map<String, dynamic>> fiftyPlusScreenings = [
      {
        'title': 'Kolonoskopi',
        'message': 'Kolonoskopi taramanızı yaptırmayı unutmayın.',
        'frequency': '5_years',
      },
      {
        'title': 'Kemik Yoğunluğu Ölçümü',
        'message': 'Kemik yoğunluğu ölçümünüzü yaptırmayı unutmayın.',
        'frequency': '2_years',
      },
    ];

    for (var screening in fiftyPlusScreenings) {
      final String frequency = screening['frequency'] as String;
      int yearsToAdd = 1;
      
      if (frequency == '5_years') {
        yearsToAdd = 5;
      } else if (frequency == '2_years') {
        yearsToAdd = 2;
      }

      final nextScreeningDate = tz.TZDateTime(
        tz.local,
        now.year + yearsToAdd,
        now.month,
        now.day,
        9,
        0,
      );

      await flutterLocalNotificationsPlugin.zonedSchedule(
        _notificationId++,
        screening['title'] as String,
        screening['message'] as String,
        nextScreeningDate,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'fifty_plus_screening_channel',
            '50+ Taramalar',
            channelDescription: '50 yaş ve üzeri için özel taramalar',
            importance: Importance.high,
            priority: Priority.high,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: null,
      );
      
      developer.log('${screening['title']} bildirimi planlandı: $nextScreeningDate');
    }
  }

  Future<void> scheduleChronicDiseaseScreenings(int age) async {
    final now = tz.TZDateTime.now(tz.local);
    
    // Diyabet için aylık kontroller
    await flutterLocalNotificationsPlugin.zonedSchedule(
      _notificationId++,
      'Diyabet Kontrolü',
      'Aylık diyabet kontrolünüzü yaptırmayı unutmayın.',
      tz.TZDateTime(
        tz.local,
        now.year,
        now.month,
        now.day,
        9,
        0,
      ).add(const Duration(days: 1)),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'chronic_disease_channel',
          'Kronik Hastalık Taramaları',
          channelDescription: 'Kronik hastalıklar için periyodik taramalar',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: null,
    );

    // Hipertansiyon için aylık kontroller
    await flutterLocalNotificationsPlugin.zonedSchedule(
      _notificationId++,
      'Tansiyon Kontrolü',
      'Aylık tansiyon kontrolünüzü yaptırmayı unutmayın.',
      tz.TZDateTime(
        tz.local,
        now.year,
        now.month,
        now.day,
        9,
        0,
      ).add(const Duration(days: 1)),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'chronic_disease_channel',
          'Kronik Hastalık Taramaları',
          channelDescription: 'Kronik hastalıklar için periyodik taramalar',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: null,
    );
  }

  Future<void> schedulePregnancyScreenings() async {
    final now = tz.TZDateTime.now(tz.local);
    
    // Hamilelik takibi için aylık kontroller
    await flutterLocalNotificationsPlugin.zonedSchedule(
      _notificationId++,
      'Hamilelik Kontrolü',
      'Aylık hamilelik kontrolünüzü yaptırmayı unutmayın.',
      tz.TZDateTime(
        tz.local,
        now.year,
        now.month,
        now.day,
        9,
        0,
      ).add(const Duration(days: 1)),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'pregnancy_channel',
          'Hamilelik Takibi',
          channelDescription: 'Hamilelik sürecindeki kontroller',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: null,
    );
  }

  Future<void> scheduleBabyScreenings(DateTime birthDate) async {
    try {
      final now = tz.TZDateTime.now(tz.local);
      final babyAge = now.difference(birthDate).inDays ~/ 30; // Bebeğin yaşı (ay)
      developer.log('Bebek sağlık taramaları planlanıyor. Bebek yaşı: $babyAge ay');

      // İlk 2 yıl için aylık kontroller
      if (babyAge < 24) {
        await scheduleBabyMonthlyScreeningNotification(
          title: 'Bebek Sağlık Kontrolü',
          message: 'Bebeğinizin aylık sağlık kontrolünü yaptırmayı unutmayın.',
          scheduledDate: tz.TZDateTime(
            tz.local,
            now.year,
            now.month,
            now.day,
            9,
            0,
          ).add(const Duration(days: 1)),
          month: babyAge + 1,
        );
      }

      // Aşı takibi için bildirimler
      final List<Map<String, dynamic>> vaccinationSchedule = [
        {'month': 2, 'title': 'BCG Aşısı', 'message': 'BCG aşısı zamanı geldi!'},
        {'month': 4, 'title': 'Karma Aşı', 'message': 'Karma aşı zamanı geldi!'},
        {'month': 6, 'title': 'Hepatit B Aşısı', 'message': 'Hepatit B aşısı zamanı geldi!'},
        {'month': 12, 'title': 'Kızamık Aşısı', 'message': 'Kızamık aşısı zamanı geldi!'},
        {'month': 18, 'title': 'Suçiçeği Aşısı', 'message': 'Suçiçeği aşısı zamanı geldi!'},
      ];

      for (var vaccine in vaccinationSchedule) {
        final int vaccineMonth = vaccine['month'] as int;
        if (babyAge < vaccineMonth) {
          final vaccinationDate = birthDate.add(Duration(days: vaccineMonth * 30));
          await flutterLocalNotificationsPlugin.zonedSchedule(
            _notificationId++,
            vaccine['title'] as String,
            vaccine['message'] as String,
            tz.TZDateTime(
              tz.local,
              vaccinationDate.year,
              vaccinationDate.month,
              vaccinationDate.day,
              9,
              0,
            ),
            const NotificationDetails(
              android: AndroidNotificationDetails(
                'baby_screening_channel',
                'Bebek Taramaları',
                channelDescription: 'Bebekler için sağlık taramaları',
                importance: Importance.high,
                priority: Priority.high,
              ),
            ),
            androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
            uiLocalNotificationDateInterpretation:
                UILocalNotificationDateInterpretation.absoluteTime,
            matchDateTimeComponents: null,
          );
        }
      }

      developer.log('Bebek sağlık taramaları planlandı');
    } catch (e) {
      developer.log('Bebek sağlık taramaları planlanırken hata: $e');
    }
  }

  // Aylık tekrarlanan bildirimler için yardımcı metod
  Future<void> scheduleMonthlyNotification({
    required String title,
    required String message,
    required String channelId,
    required String channelName,
    required String channelDescription,
  }) async {
    final now = tz.TZDateTime.now(tz.local);
    final nextMonth = now.month == 12 ? 1 : now.month + 1;
    final nextYear = now.month == 12 ? now.year + 1 : now.year;

    await flutterLocalNotificationsPlugin.zonedSchedule(
      _notificationId++,
      title,
      message,
      tz.TZDateTime(
        tz.local,
        nextYear,
        nextMonth,
        now.day,
        9,
        0,
      ),
      NotificationDetails(
        android: AndroidNotificationDetails(
          channelId,
          channelName,
          channelDescription: channelDescription,
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: null,
    );
  }

  // Kronik hastalık taramalarını aylık olarak planla
  Future<void> scheduleMonthlyChronicDiseaseScreenings() async {
    await scheduleMonthlyNotification(
      title: 'Diyabet Kontrolü',
      message: 'Aylık diyabet kontrolünüzü yaptırmayı unutmayın.',
      channelId: 'chronic_disease_channel',
      channelName: 'Kronik Hastalık Taramaları',
      channelDescription: 'Kronik hastalıklar için periyodik taramalar',
    );

    await scheduleMonthlyNotification(
      title: 'Tansiyon Kontrolü',
      message: 'Aylık tansiyon kontrolünüzü yaptırmayı unutmayın.',
      channelId: 'chronic_disease_channel',
      channelName: 'Kronik Hastalık Taramaları',
      channelDescription: 'Kronik hastalıklar için periyodik taramalar',
    );
  }

  // Hamilelik kontrollerini aylık olarak planla
  Future<void> scheduleMonthlyPregnancyScreenings() async {
    await scheduleMonthlyNotification(
      title: 'Hamilelik Kontrolü',
      message: 'Aylık hamilelik kontrolünüzü yaptırmayı unutmayın.',
      channelId: 'pregnancy_channel',
      channelName: 'Hamilelik Takibi',
      channelDescription: 'Hamilelik sürecindeki kontroller',
    );
  }

} 