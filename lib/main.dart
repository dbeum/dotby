import 'package:dotby1/authcheck.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:permission_handler/permission_handler.dart';
 
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Preserve splash screen
  FlutterNativeSplash.preserve(widgetsBinding: WidgetsBinding.instance);

  // Initialize notifications
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@drawable/ic_stat_dn');

  final DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // 🔐 Request permissions on Android 13+ and iOS
  await _requestNotificationPermissions();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Now remove splash screen
  FlutterNativeSplash.remove();

  runApp(const MyApp());
}


Future<void> _requestNotificationPermissions() async {
  // Android 13+ needs runtime permission for notifications
  if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }

  // iOS permissions
  final iosImplementation = flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();
  await iosImplementation?.requestPermissions(
    alert: true,
    badge: true,
    sound: true,
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DOTBY PRODUCTIONS',
     theme: ThemeData(
       useMaterial3: true,
         primarySwatch: Colors.red,
      scaffoldBackgroundColor: Colors.white,
      progressIndicatorTheme: ProgressIndicatorThemeData(
          color: Colors.red, 
          linearMinHeight: 4.0,  
          circularTrackColor:Color.fromARGB(255, 31, 33, 37), 
      
          
        ),
 ), 
      home:AuthCheck(),
      debugShowCheckedModeBanner: false,
    );
  }
}