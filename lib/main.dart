import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'notification_detail_screen.dart';
import 'home_page.dart';
import 'local_notifications.dart';


final navigatorKey = GlobalKey<NavigatorState>();
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotifications.init();
  var initialNotification = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  if (initialNotification?.didNotificationLaunchApp == true) {
     Future.delayed(Duration(seconds: 1), () {
       navigatorKey.currentState!.pushNamed('/notification_detail', arguments: initialNotification?.notificationResponse?.payload);
    });
  }

  runApp(  MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Local Notifications Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      routes: {
        '/': (context) => const Homepage(),
        '/notification_detail': (context) => const NotificationDetailScreen(),
      },
    );
  }
}


