import 'package:flutter/material.dart';
import 'left_sidebar_layout.dart';
import 'bottom_section.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LeftSidebarLayout(
      activePage: PageType.calendar,
      child: Column(
        children: [
          _buildTopBar(),
          Expanded(child: _buildCalendarView()),
          const CollapsibleBottomSection(),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      height: 50,
      color: Colors.grey[300],
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: const Text(
        '2025 / 03',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCalendarView() {
    return Center(
      child: Text(
        '달력 내용 표시 (예: Table 또는 달력 라이브러리 활용)',
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
