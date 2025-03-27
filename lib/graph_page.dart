import 'package:flutter/material.dart';
import 'left_sidebar_layout.dart';
import 'bottom_section.dart';

class GraphPage extends StatelessWidget {
  const GraphPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LeftSidebarLayout(
      activePage: PageType.graph,
      child: Column(
        children: [
          _buildTopBar(),
          Expanded(child: _buildGraphArea()),
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

  Widget _buildGraphArea() {
    return Center(
      child: Text(
        '그래프 내용 표시 (예: CustomPainter 또는 라이브러리 활용)',
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
