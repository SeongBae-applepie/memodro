import 'package:flutter/material.dart';
import 'meeting_screen.dart';
import 'left_sidebar_layout.dart';
import 'login_page.dart';
import 'signup_page.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        // '/home': (context) => LeftSidebarLayout(), // 기존 앱 메인
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MeetingScreen(), // 앱 시작 시 홈 화면
      debugShowCheckedModeBanner: false,
    );
  }
}
