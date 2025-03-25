import 'package:flutter/material.dart';

class MeetingScreen extends StatelessWidget {
  const MeetingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          _buildSideBar(), // 좌측 사이드바
          _buildMenuArea(), // 중간 메뉴 영역
          _buildMainContent(), // 메인 콘텐츠 영역
        ],
      ),
    );
  }

  // 좌측 사이드바 위젯
  Widget _buildSideBar() {
    return Container(
      width: 200,
      color: Colors.grey[200],
      child: Column(
        children: [
          const SizedBox(height: 40),
          _sideBarIcon(Icons.home),
          _sideBarIcon(Icons.search),
          _sideBarIcon(Icons.bar_chart),
          _sideBarIcon(Icons.history),
        ],
      ),
    );
  }

  // 사이드바의 아이콘 버튼 위젯
  Widget _sideBarIcon(IconData icon) {
    return IconButton(icon: Icon(icon), onPressed: () {});
  }

  // 중간 메뉴 영역 위젯
  Widget _buildMenuArea() {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(right: BorderSide(color: Colors.black12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _menuButton('폴더 작성'),
          _menuButton('인공지능 조사'),
          _menuButton('엑셀파일 조사'),
          _menuButton('폴더내 조사'),
          const Divider(),
          const Text(
            '회의록',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          _menuListItem('1주'),
          _menuListItem('2주'),
          _menuListItem('3주'),
        ],
      ),
    );
  }

  // 메뉴 버튼 위젯
  Widget _menuButton(String title) {
    return ElevatedButton(onPressed: () {}, child: Text(title));
  }

  // 메뉴 목록 아이템 위젯
  Widget _menuListItem(String title) {
    return ListTile(title: Text(title));
  }

  // 메인 콘텐츠 위젯
  Widget _buildMainContent() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopTabBar(), // 상단 탭바
          _buildMeetingInfo(), // 회의록 정보 (1주, 날짜, 설명)
          const Spacer(),
          _buildBottomArea(), // 하단 버튼 및 AI 요약 영역
        ],
      ),
    );
  }

  // 상단 탭바 위젯
  Widget _buildTopTabBar() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12)),
      ),
      child: DefaultTabController(
        length: 6,
        child: const TabBar(
          isScrollable: true,
          tabs: [
            Tab(text: '제목'),
            Tab(text: '머리말'),
            Tab(text: '부머리말'),
            Tab(text: '본문'),
            Tab(text: '+구분점'),
            Tab(text: '1.번호목록'),
          ],
        ),
      ),
    );
  }

  // 회의 정보 표시 위젯
  Widget _buildMeetingInfo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '1주',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('2025/02/25', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 20),
          const Text('매주 목요일 줌으로 수업', style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }

  // 하단 버튼 및 AI 요약 영역 위젯
  Widget _buildBottomArea() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade400)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _bottomActionButtons(),
          const SizedBox(height: 20),
          const Text(
            'AI 요약 내용....',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: const Size(120, 40)),
              onPressed: () {},
              child: const Text('적용'),
            ),
          ),
        ],
      ),
    );
  }

  // 하단 액션 버튼 그룹 위젯
  Widget _bottomActionButtons() {
    return Row(
      children: [
        _bottomButton('내용 요약'),
        const SizedBox(width: 10),
        _bottomButton('태그 추출'),
        const SizedBox(width: 10),
        _bottomButton('검색'),
      ],
    );
  }

  // 개별 하단 액션 버튼 위젯
  Widget _bottomButton(String title) {
    return ElevatedButton(onPressed: () {}, child: Text(title));
  }
}
