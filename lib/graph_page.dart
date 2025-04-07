import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_graph_view/flutter_graph_view.dart';
import 'left_sidebar_layout.dart';
import 'bottom_section.dart';

enum GraphAlgorithmType { random, fruchtermanReingold }

class GraphPage extends StatefulWidget {
  const GraphPage({super.key});

  @override
  State<GraphPage> createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  // 현재 선택된 레이아웃 알고리즘 타입
  GraphAlgorithmType _currentAlgorithmType = GraphAlgorithmType.random;
  // 그래프 스케일 (슬라이더로 조절)
  double _scale = 1.0;

  // TransformationController를 선언해 InteractiveViewer에 초기 변환 적용
  final TransformationController _controller = TransformationController();

  GraphAlgorithm _getSelectedAlgorithm() {
    switch (_currentAlgorithmType) {
      case GraphAlgorithmType.random:
        return RandomAlgorithm(
          decorators: [
            CoulombDecorator(),
            HookeDecorator(),
            CoulombCenterDecorator(),
            HookeCenterDecorator(),
            ForceDecorator(),
            ForceMotionDecorator(),
            TimeCounterDecorator(),
          ],
        );
      case GraphAlgorithmType.fruchtermanReingold:
        // flutter_graph_view 1.1.4에는 FruchtermanReingoldAlgorithm이 없으므로 대체합니다.
        return RandomAlgorithm(
          decorators: [
            CoulombDecorator(),
            HookeDecorator(),
            CoulombCenterDecorator(),
            HookeCenterDecorator(),
            ForceDecorator(),
            ForceMotionDecorator(),
            TimeCounterDecorator(),
          ],
        );
      default:
        return RandomAlgorithm(
          decorators: [
            CoulombDecorator(),
            HookeDecorator(),
            CoulombCenterDecorator(),
            HookeCenterDecorator(),
            ForceDecorator(),
            ForceMotionDecorator(),
            TimeCounterDecorator(),
          ],
        );
    }
  }

  @override
  void initState() {
    super.initState();
    // 초기 스케일 및 중앙 정렬을 위한 초기 변환 설정
    // (나중에 LayoutBuilder로 영역 크기에 따라 업데이트 가능)
    _controller.value =
        Matrix4.identity()
          ..translate(200, 200)
          ..scale(_scale);
  }

  @override
  Widget build(BuildContext context) {
    // 임의의 데이터 생성: List<Map>로 생성
    var vertexes = <Map>[];
    var r = Random();
    for (var i = 0; i < 20; i++) {
      vertexes.add({
        'id': 'node$i',
        'tag': 'tag${r.nextInt(9)}',
        'tags': [
          'tag${r.nextInt(9)}',
          if (r.nextBool()) 'tag${r.nextInt(4)}',
          if (r.nextBool()) 'tag${r.nextInt(8)}',
        ],
      });
    }
    var edges = <Map>[];
    for (var i = 0; i < 20; i++) {
      edges.add({
        'srcId': 'node${(i % 8) + 8}',
        'dstId': 'node$i',
        'edgeName': 'edge${r.nextInt(3)}',
        'ranking': DateTime.now().millisecond,
      });
    }
    var data = {'vertexes': vertexes, 'edges': edges};

    return LeftSidebarLayout(
      activePage: PageType.graph,
      child: Column(
        children: [
          _buildTopBar(),
          // 알고리즘 선택 및 스케일 조절 UI
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DropdownButton<GraphAlgorithmType>(
                  value: _currentAlgorithmType,
                  items: <DropdownMenuItem<GraphAlgorithmType>>[
                    DropdownMenuItem(
                      value: GraphAlgorithmType.random,
                      child: const Text('Random'),
                    ),
                    DropdownMenuItem(
                      value: GraphAlgorithmType.fruchtermanReingold,
                      child: const Text('Fruchterman-Reingold'),
                    ),
                  ],
                  onChanged: (GraphAlgorithmType? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _currentAlgorithmType = newValue;
                      });
                    }
                  },
                ),
                SizedBox(
                  width: 200,
                  child: Slider(
                    value: _scale,
                    min: 0.1,
                    max: 2.0,
                    divisions: 20,
                    label: _scale.toStringAsFixed(1),
                    onChanged: (double value) {
                      setState(() {
                        _scale = value;
                        // 슬라이더 값 변경 시 transformationController 업데이트
                        _controller.value =
                            Matrix4.identity()
                              ..translate(200, 200)
                              ..scale(_scale);
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: _buildGraphArea(data)),
          const CollapsibleBottomSection(),
        ],
      ),
    );
  }

  // 상단 바: 제목 표시
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

  // FlutterGraphWidget을 반환하는 함수
  Widget _buildGraphArea(Map data) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // 사용 가능한 영역의 중앙 좌표 계산 후 초기 변환
        Matrix4 initialTransform =
            Matrix4.identity()
              ..translate(constraints.maxWidth / 2, constraints.maxHeight / 2)
              ..scale(_scale);
        _controller.value = initialTransform;
        return InteractiveViewer(
          transformationController: _controller,
          boundaryMargin: const EdgeInsets.all(500),
          constrained: true, // true로 설정해 자식에 제약을 줌
          minScale: 0.1,
          maxScale: 5.0,
          child: SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: FlutterGraphWidget(
              data: data,
              algorithm: _getSelectedAlgorithm(),
              convertor: MapConvertor(),
              options:
                  Options()
                    ..enableHit = false
                    ..panelDelay = const Duration(milliseconds: 500)
                    ..graphStyle =
                        (GraphStyle()
                          ..tagColor = {'tag8': Colors.orangeAccent.shade200}
                          ..tagColorByIndex = [
                            Colors.red.shade200,
                            Colors.orange.shade200,
                            Colors.yellow.shade200,
                            Colors.green.shade200,
                            Colors.blue.shade200,
                            Colors.blueAccent.shade200,
                            Colors.purple.shade200,
                            Colors.pink.shade200,
                            Colors.blueGrey.shade200,
                            Colors.deepOrange.shade200,
                          ])
                    ..useLegend = true
                    ..vertexPanelBuilder = vertexPanelBuilder
                    ..edgeShape = EdgeLineShape()
                    ..vertexShape = VertexCircleShape(),
            ),
          ),
        );
      },
    );
  }

  // 에지 패널 빌더: 에지 정보를 표시하는 위젯 (options 참조 대신 고정 값 사용)
  Widget edgePanelBuilder(Edge edge, Viewfinder viewfinder) {
    var c = viewfinder.localToGlobal(edge.position);
    return Stack(
      children: [
        Positioned(
          left: c.x + 5,
          top: c.y,
          child: SizedBox(
            width: 200,
            child: ColoredBox(
              color: Colors.grey.shade900.withAlpha(200),
              child: ListTile(
                title: Text(
                  '${edge.edgeName} @${edge.ranking}\nDelay: 500ms',
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // 버텍스 패널 빌더: 노드 정보를 표시하는 위젯
  Widget vertexPanelBuilder(dynamic hoverVertex, Viewfinder viewfinder) {
    var c = viewfinder.localToGlobal(hoverVertex.cpn!.position);
    return Stack(
      children: [
        Positioned(
          left: c.x + hoverVertex.radius + 5,
          top: c.y - 20,
          child: SizedBox(
            width: 120,
            child: ColoredBox(
              color: Colors.grey.shade900.withAlpha(200),
              child: ListTile(
                title: Text(
                  'Id: ${hoverVertex.id}',
                  style: const TextStyle(fontSize: 12),
                ),
                subtitle: Text(
                  'Tag: ${hoverVertex.data['tag']}\nDegree: ${hoverVertex.degree} ${hoverVertex.prevVertex?.id ?? ""}',
                  style: const TextStyle(fontSize: 10),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
