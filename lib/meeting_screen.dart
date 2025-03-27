import 'package:flutter/material.dart';
import 'left_sidebar_layout.dart';
import 'bottom_section.dart';

class MeetingScreen extends StatelessWidget {
  const MeetingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LeftSidebarLayout(
      activePage: PageType.home,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 상단 헤더 영역
          Container(
            height: 50,
            color: Colors.grey[300],
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              '메인 화면',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          // 메인 콘텐츠 영역
          Expanded(
            child: Center(
              child: Text(
                '여기에 메인 페이지 내용을 표시합니다.',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
          // 하단 액션 영역 (CollapsibleBottomSection)
          const CollapsibleBottomSection(),
        ],
      ),
    );
  }
}
