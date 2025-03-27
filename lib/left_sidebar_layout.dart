import 'package:flutter/material.dart';
import 'meeting_screen.dart';
import 'calendar_page.dart';
import 'graph_page.dart';

/// 좌측 사이드바만 공통으로 두고, 나머지는 각 페이지(child)가 담당하는 레이아웃
class LeftSidebarLayout extends StatelessWidget {
  final Widget child; // 각 페이지에서 전달받을 메인 콘텐츠

  const LeftSidebarLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          _buildSideBar(context), // 좌측 사이드바
          Expanded(child: child), // 우측(메인 콘텐츠) -> 각 페이지마다 다름
        ],
      ),
    );
  }

  // 좌측 사이드바
  Widget _buildSideBar(BuildContext context) {
    return Container(
      width: 60,
      color: Colors.grey[200],
      child: Column(
        children: [
          const SizedBox(height: 40),
          // 홈(메인 화면) 이동
          _sideBarIcon(
            Icons.home,
            () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const MeetingScreen()),
            ),
          ),
          // 달력 페이지 이동
          _sideBarIcon(
            Icons.calendar_today,
            () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const CalendarPage()),
            ),
          ),
          // 그래프 페이지 이동
          _sideBarIcon(
            Icons.show_chart,
            () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const GraphPage()),
            ),
          ),
          // 예시로 추가 아이콘들
          _sideBarIcon(Icons.search_rounded, () => print('검색')),
          _sideBarIcon(Icons.history, () => print('히스토리')),
        ],
      ),
    );
  }

  // 사이드바 아이콘 버튼
  Widget _sideBarIcon(IconData icon, VoidCallback onPressed) {
    return IconButton(icon: Icon(icon), onPressed: onPressed);
  }
}
