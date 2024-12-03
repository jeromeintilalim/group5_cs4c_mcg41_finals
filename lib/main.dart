import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/home.dart';
import 'screens/login.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserDataProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Team Allstar Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF141414),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xffeeeeee)),
          bodyMedium: TextStyle(color: Color(0xffeeeeee)),
          titleLarge: TextStyle(color: Color(0xffeeeeee)),
        ),
        primaryColor: const Color(0xffEA2843),
      ),
      home: LoginPage(title: 'Demo Login'),
    );
  }
}

