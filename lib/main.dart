import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import './firebase_config.dart';

import './screens/start_screen.dart';
import './screens/initialization.dart';
import './screens/login/homepage.dart';
import './screens/employees.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: options);
  runApp(MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Пиццерия',
      theme: ThemeData(primarySwatch: Colors.orange),
      initialRoute: '/',
      routes: {
        '/': (context) => Initialization(_initialization, '/start'),
        '/start': (context) => const StartScreen(),
        '/home': (context) => HomePage(),
        '/collections/employees': (context) => EmployeesCollection(),
      },
    );
  }
}
