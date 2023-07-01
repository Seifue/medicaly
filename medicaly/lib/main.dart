import 'package:flutter/material.dart';
import 'package:medicaly/onboard.dart';
import 'package:medicaly/slpash.dart';
import 'package:medicaly/sql.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'addMedicinPage.dart';
import 'export.dart';
import 'homePage.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'slpash.dart';
import 'textRecognitionPage.dart';

main() async {
  AwesomeNotifications().initialize('resource://drawable/pill', [
    NotificationChannel(
        channelKey: 'basic key',
        channelName: 'basic channel',
        channelDescription: 'notification for test',
        playSound: true,
        enableVibration: true,
        importance: NotificationImportance.High),
    NotificationChannel(
        channelKey: 'schedual_key',
        channelName: 'schedual notification',
        channelDescription: 'schedual',
        playSound: true,
        enableVibration: true,
        importance: NotificationImportance.High,
        locked: true,
        soundSource: 'resource://raw/sound',
        criticalAlerts: true),
  ]);

  SqlDb sql = SqlDb();
  //actionEvent(sql);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  onboard = await prefs.getBool('onboard');
  await prefs.setBool('onboard', true);
  runApp(MyApp());
}

bool? onboard;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: HomePage(),
      initialRoute: onboard == null || onboard == false ? '/onboard' : '/',
      routes: {
        '/onboard': (context) => onboardPage(),
        '/': (context) => Splash(),
        '/addMedicin': (context) => addMedicinePage(),
        '/home': (context) => HomePage(),
        '/TextRecognation': (context) => textR_Page(),
        '/export': (context) => Export()
      },
    );
  }
}
