import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'left_sidebar_layout.dart';
import 'bottom_section.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  // 오늘 날짜로 이동하는 함수
  void _goToToday() {
    setState(() {
      _focusedDay = DateTime.now();
      _selectedDay = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    return LeftSidebarLayout(
      activePage: PageType.calendar,
      child: Column(
        children: [
          _buildTopBar(),
          Expanded(child: _buildCalendarView()),
          // 하단에 Collapse 가능한 액션 영역 (bottom_section.dart)
          const CollapsibleBottomSection(),
        ],
      ),
    );
  }

  // 상단 바: 제목, "2 Weeks" 버튼과 "Today" 버튼 포함
  Widget _buildTopBar() {
    return Container(
      height: 50,
      color: Colors.grey[300],
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Calendar',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _calendarFormat = CalendarFormat.twoWeeks;
                  });
                },
                child: const Text('2 Weeks'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(onPressed: _goToToday, child: const Text('Today')),
            ],
          ),
        ],
      ),
    );
  }

  // TableCalendar 위젯을 이용한 달력 뷰
  Widget _buildCalendarView() {
    return TableCalendar(
      firstDay: DateTime.utc(2010, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      onFormatChanged: (format) {
        setState(() {
          _calendarFormat = format;
        });
      },
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
      },
      calendarStyle: const CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: Colors.orange,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
