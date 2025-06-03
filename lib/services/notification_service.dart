import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
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

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    tz.initializeTimeZones();
  }

  Future<void> scheduleSpecialDayNotification({
    required String title,
    required String message,
    required DateTime scheduledDate,
  }) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      title,
      message,
      tz.TZDateTime.from(scheduledDate, tz.local),
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
    );
  }

  Future<void> scheduleYearlyScreeningNotification({
    required String title,
    required String message,
    required DateTime scheduledDate,
  }) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      1, // Benzersiz ID
      title,
      message,
      tz.TZDateTime.from(scheduledDate, tz.local),
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
    );
  }

  Future<void> scheduleAgeBasedScreeningNotification({
    required String title,
    required String message,
    required DateTime scheduledDate,
    required int age,
  }) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      2, // Benzersiz ID
      title,
      message,
      tz.TZDateTime.from(scheduledDate, tz.local),
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
    );
  }

  Future<void> scheduleBabyMonthlyScreeningNotification({
    required String title,
    required String message,
    required DateTime scheduledDate,
    required int month,
  }) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      3, // Benzersiz ID
      title,
      message,
      tz.TZDateTime.from(scheduledDate, tz.local),
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
    );
  }

  Future<void> scheduleAllSpecialDays() async {
    // Sabit tarihli özel günler
    final specialDays = [
      {'title': 'Dünya Kanser Günü', 'message': '4 Şubat Dünya Kanser Günü!', 'month': 2, 'day': 4},
      {'title': 'Sigarayı Bırakma Günü', 'message': '9 Şubat Sigarayı Bırakma Günü!', 'month': 2, 'day': 9},
      {'title': 'Dünya Kulak ve İşitme Günü', 'message': '3 Mart Dünya Kulak ve İşitme Günü!', 'month': 3, 'day': 3},
      {'title': 'Dünya Obezite Günü', 'message': '4 Mart Dünya Obezite Günü!', 'month': 3, 'day': 4},
      {'title': 'Dünya Tüberküloz Günü', 'message': '24 Mart Dünya Tüberküloz Günü!', 'month': 3, 'day': 24},
      {'title': 'Dünya Otizm Farkındalık Günü', 'message': '2 Nisan Dünya Otizm Farkındalık Günü!', 'month': 4, 'day': 2},
      {'title': 'Büyümenin İzlenmesi Günü', 'message': '15 Nisan Büyümenin İzlenmesi Günü!', 'month': 4, 'day': 15},
      {'title': 'Dünya Hemofili Günü', 'message': '17 Nisan Dünya Hemofili Günü!', 'month': 4, 'day': 17},
      {'title': 'Dünya Talasemi Günü', 'message': '8 Mayıs Dünya Talasemi Günü!', 'month': 5, 'day': 8},
      {'title': 'Dünya Sağlık İçin Hareket Et Günü', 'message': '10 Mayıs Dünya Sağlık İçin Hareket Et Günü!', 'month': 5, 'day': 10},
      {'title': 'Dünya İnme Önleme Günü', 'message': '10 Mayıs Dünya İnme Önleme Günü!', 'month': 5, 'day': 10},
      {'title': 'Dünya Hipertansiyon Günü', 'message': '17 Mayıs Dünya Hipertansiyon Günü!', 'month': 5, 'day': 17},
      {'title': 'Dünya Tütünsüz Günü', 'message': '31 Mayıs Dünya Tütünsüz Günü!', 'month': 5, 'day': 31},
      {'title': 'Ulusal Fenilketonüri Günü', 'message': '1 Haziran Ulusal Fenilketonüri Günü!', 'month': 6, 'day': 1},
      {'title': 'Dünya Uyuşturucu Kullanımı ve Kaçakçılığı ile Mücadele Günü', 'message': '26 Haziran Dünya Uyuşturucu Kullanımı ve Kaçakçılığı ile Mücadele Günü!', 'month': 6, 'day': 26},
      {'title': 'Dünya Hepatit Günü', 'message': '28 Temmuz Dünya Hepatit Günü!', 'month': 7, 'day': 28},
      {'title': 'Dünya İntiharı Önleme Günü', 'message': '10 Eylül Dünya İntiharı Önleme Günü!', 'month': 9, 'day': 10},
      {'title': 'Dünya Doğum Kontrol Günü', 'message': '26 Eylül Dünya Doğum Kontrol Günü!', 'month': 9, 'day': 26},
      {'title': 'Dünya Okul Süt Günü', 'message': '27 Eylül Dünya Okul Süt Günü!', 'month': 9, 'day': 27},
      {'title': 'Dünya Kuduz Günü', 'message': '28 Eylül Dünya Kuduz Günü!', 'month': 9, 'day': 28},
      {'title': 'Dünya Kalp Günü', 'message': '29 Eylül Dünya Kalp Günü!', 'month': 9, 'day': 29},
      {'title': 'Dünya Yaşlılar Günü', 'message': '1 Ekim Dünya Yaşlılar Günü!', 'month': 10, 'day': 1},
      {'title': 'Dünya Yürüyüş Günü', 'message': '3 Ekim Dünya Yürüyüş Günü!', 'month': 10, 'day': 3},
      {'title': 'Dünya Ruh Sağlığı Günü', 'message': '10 Ekim Dünya Ruh Sağlığı Günü!', 'month': 10, 'day': 10},
      {'title': 'Uluslararası Afet Risklerinin Azaltılması Günü', 'message': '13 Ekim Uluslararası Afet Risklerinin Azaltılması Günü!', 'month': 10, 'day': 13},
      {'title': 'Dünya El Yıkama Günü', 'message': '15 Ekim Dünya El Yıkama Günü!', 'month': 10, 'day': 15},
      {'title': 'Dünya Meme Sağlığı Günü', 'message': '15 Ekim Dünya Meme Sağlığı Günü!', 'month': 10, 'day': 15},
      {'title': 'Avrupa Antibiyotik Farkındalık Günü', 'message': '18 Kasım Avrupa Antibiyotik Farkındalık Günü!', 'month': 11, 'day': 18},
      {'title': 'Ağız Diş Sağlığı Haftası', 'message': '22 Kasım Ağız Diş Sağlığı Haftası!', 'month': 11, 'day': 22},
      {'title': 'Dünya Diyabet Günü', 'message': '14 Kasım Dünya Diyabet Günü!', 'month': 11, 'day': 14},
      {'title': 'Dünya AIDS Günü', 'message': '1 Aralık Dünya AIDS Günü!', 'month': 12, 'day': 1},
      {'title': 'Dünya Engelliler Günü', 'message': '3 Aralık Dünya Engelliler Günü!', 'month': 12, 'day': 3},
    ];

    for (var day in specialDays) {
      final now = DateTime.now();
      final scheduledDate = DateTime(now.year, day['month'] as int, day['day'] as int);
      
      // Eğer tarih geçmişse, gelecek yıl için planla
      if (scheduledDate.isBefore(now)) {
        final nextYearDate = DateTime(now.year + 1, day['month'] as int, day['day'] as int);
        await scheduleSpecialDayNotification(
          title: day['title'] as String,
          message: day['message'] as String,
          scheduledDate: nextYearDate,
        );
      } else {
        await scheduleSpecialDayNotification(
          title: day['title'] as String,
          message: day['message'] as String,
          scheduledDate: scheduledDate,
        );
      }
    }

    // Yıllık tarama bildirimleri
    final yearlyScreenings = [
      {
        'title': 'Arteriyel Tansiyon Ölçümü Hatırlatması',
        'message': 'Yıllık tansiyon ölçümünüzü yaptırmayı unutmayın!',
        'month': DateTime.now().month,
        'day': DateTime.now().day,
      },
      {
        'title': 'Obezite Taraması Hatırlatması',
        'message': 'Yıllık BKİ ve kilo/boy ölçümünüzü yaptırmayı unutmayın!',
        'month': DateTime.now().month,
        'day': DateTime.now().day,
      },
    ];

    for (var screening in yearlyScreenings) {
      final now = DateTime.now();
      final scheduledDate = DateTime(now.year, screening['month'] as int, screening['day'] as int);
      
      // Gelecek 5 yıl için bildirimleri planla
      for (int i = 0; i < 5; i++) {
        final nextYearDate = DateTime(scheduledDate.year + i, scheduledDate.month, scheduledDate.day);
        if (nextYearDate.isAfter(now)) {
          await scheduleYearlyScreeningNotification(
            title: screening['title'] as String,
            message: screening['message'] as String,
            scheduledDate: nextYearDate,
          );
        }
      }
    }

    // Yaşa bağlı tarama bildirimleri
    final ageBasedScreenings = [
      {
        'title': 'Çocuk İzlem Hatırlatması',
        'message': 'Çocuk izlem taramanızı yaptırmayı unutmayın!',
        'ages': [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18],
      },
      {
        'title': 'Hb/Htc Ölçümü Hatırlatması',
        'message': 'Hemoglobin/Hematokrit ölçümünüzü yaptırmayı unutmayın!',
        'ages': [10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21],
      },
    ];

    for (var screening in ageBasedScreenings) {
      final now = DateTime.now();
      final scheduledDate = DateTime(now.year, now.month, now.day);
      
      for (var age in screening['ages'] as List<int>) {
        await scheduleAgeBasedScreeningNotification(
          title: screening['title'] as String,
          message: '${screening['message'] as String} (${age} yaş)',
          scheduledDate: scheduledDate,
          age: age,
        );
      }
    }

    // Bebek aylık tarama bildirimleri
    final babyMonthlyScreenings = [
      {
        'title': 'Bebek İzlem Hatırlatması',
        'message': 'Bebeğinizin aylık izlem taramasını yaptırmayı unutmayın!',
        'months': [1, 2, 3, 4, 5, 6, 9, 12, 15, 18, 24, 30, 36],
      },
      {
        'title': 'Aşı Hatırlatması',
        'message': 'Bebeğinizin aşı zamanı geldi!',
        'months': [2, 4, 6, 12, 18, 24],
      },
      {
        'title': 'Gelişim Taraması Hatırlatması',
        'message': 'Bebeğinizin gelişim taramasını yaptırmayı unutmayın!',
        'months': [3, 6, 9, 12, 15, 18, 24, 30, 36],
      },
    ];

    for (var screening in babyMonthlyScreenings) {
      final now = DateTime.now();
      final scheduledDate = DateTime(now.year, now.month, now.day);
      
      for (var month in screening['months'] as List<int>) {
        await scheduleBabyMonthlyScreeningNotification(
          title: screening['title'] as String,
          message: '${screening['message'] as String} (${month}. ay)',
          scheduledDate: scheduledDate,
          month: month,
        );
      }
    }
  }
} 