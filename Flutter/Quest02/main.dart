import 'package:flutter/material.dart';

// Flutter 앱의 진입점. runApp 함수로 MyApp 위젯 실행
void main() {
  runApp(const MyApp());
}

// MyApp 클래스. StatelessWidget을 상속받아 앱의 기본 구조 정의
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp으로 앱의 루트 위젯 구성
    return const MaterialApp(
      home: HomePage(), // 앱의 첫 화면으로 HomePage 지정
    );
  }
}

// HomePage 클래스. 앱의 주요 화면 정의
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold로 기본 화면 레이아웃 구성
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, // AppBar 배경색 파란색으로 설정
        leading: const Icon(Icons.menu), // AppBar 좌측 상단에 메뉴 아이콘 추가
        title: const Text('플러터 앱 만들기'), // AppBar 중앙에 텍스트 추가
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center, // 위젯들을 세로로 중앙 정렬
        children: [
          // ElevatedButton으로 버튼 구성
          Center(
            child: ElevatedButton(
              onPressed: () {
                // 버튼 클릭 시 콘솔에 메시지 출력
                debugPrint('버튼이 눌렸습니다');
              },
              child: const Text('Text'), // 버튼에 표시될 텍스트
            ),
          ),
          const SizedBox(height: 50), // 버튼과 컨테이너 사이의 여백 설정

          // Stack 위젯으로 중첩된 정사각형 컨테이너 배치
          Center(
            child: Stack(
              alignment: Alignment.center, // 중첩된 컨테이너 중앙 정렬
              children: [
                // for 루프를 사용해 5개의 컨테이너 생성
                for (int i = 5; i > 0; i--)
                  Container(
                    width: i * 60.0, // 컨테이너 가로 길이 설정
                    height: i * 60.0, // 컨테이너 세로 길이 설정
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1 * i), // 색상 및 투명도 설정
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


//회고: 제시된 예시와 다르게 컨테이너를 중앙에 배치시키고 커져나가도록 했다. 앞으로 더 다양한 앱을 구현해보고 싶다.