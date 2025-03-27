import 'package:flutter/material.dart';
import 'left_sidebar_layout.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LeftSidebarLayout(
      child: Column(
        children: [
          _buildTopBar(),
          Expanded(child: _buildCalendarView()),
          _buildBottomArea(),
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
        '달력 내용 표시 (Table, 라이브러리 등 활용 가능)',
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildBottomArea() {
    return Container(
      height: 60,
      color: Colors.grey[200],
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: () {}, child: const Text('내용 요약')),
          const SizedBox(width: 10),
          ElevatedButton(onPressed: () {}, child: const Text('태그 추출')),
          const SizedBox(width: 10),
          ElevatedButton(onPressed: () {}, child: const Text('검색')),
        ],
      ),
    );
  }
}
