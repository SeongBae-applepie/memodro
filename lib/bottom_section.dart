import 'package:flutter/material.dart';

class CollapsibleBottomSection extends StatefulWidget {
  const CollapsibleBottomSection({super.key});

  @override
  State<CollapsibleBottomSection> createState() =>
      _CollapsibleBottomSectionState();
}

class _CollapsibleBottomSectionState extends State<CollapsibleBottomSection> {
  bool _isExpanded = true;

  void _toggleSection() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade400)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 헤더: 제목과 토글 아이콘
          GestureDetector(
            onTap: _toggleSection,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '하단 액션 영역',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Icon(
                  _isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                ),
              ],
            ),
          ),
          // 내용 영역: AnimatedCrossFade로 부드럽게 숨김/보임 전환
          AnimatedCrossFade(
            firstChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('내용 요약'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('태그 추출'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(onPressed: () {}, child: const Text('검색')),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'AI 요약 내용...',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(120, 40),
                    ),
                    onPressed: () {},
                    child: const Text('적용'),
                  ),
                ),
              ],
            ),
            secondChild: Container(),
            crossFadeState:
                _isExpanded
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }
}
