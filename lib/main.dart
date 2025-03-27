import 'package:flutter/material.dart';
import 'meeting_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MeetingScreen(), // 앱 실행 시 가장 먼저 표시할 화면
      debugShowCheckedModeBanner: false,
    );
  }
}
