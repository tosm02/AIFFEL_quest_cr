import 'package:flutter/material.dart'; // Flutter 기본 패키지

void main() {
  runApp(const MyApp()); // 앱 시작 지점
}

// 앱의 루트 위젯
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FirstPage(), // 시작 페이지를 FirstPage로 설정
    );
  }
}

// FirstPage는 상태를 가지는 StatefulWidget
class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  _FirstPageState createState() => _FirstPageState(); // 상태 관리 클래스 생성
}

// FirstPage의 상태를 관리하는 클래스
class _FirstPageState extends State<FirstPage> {
  bool is_cat = true; // 초기값을 true로 설정

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.pets), // 좌측 상단에 아이콘 추가
        title: const Text("First Page"), // 중앙에 텍스트 표시
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 세로 정렬 중앙
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  is_cat = false; // 버튼 클릭 시 false로 변경
                });

                // SecondPage로 이동하면서 is_cat 값 전달
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecondPage(isCat: is_cat),
                  ),
                );
              },
              child: const Text("Next"), // 버튼에 텍스트 표시
            ),
            const SizedBox(height: 30), // 여백 추가

            // 이미지 클릭 가능하도록 GestureDetector 사용
            GestureDetector(
              onTap: () {
                print("is_cat 상태: $is_cat"); // 클릭 시 상태 출력
              },
              child: Image.asset(
                'assets/image/cat.jpg', // 고양이 이미지 경로
                width: 500,
                height: 500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// SecondPage는 StatefulWidget으로 생성
class SecondPage extends StatefulWidget {
  final bool isCat; // 전달받은 값 저장

  SecondPage({required this.isCat}); // 생성자에서 값 받기

  @override
  _SecondPageState createState() => _SecondPageState(); // 상태 관리 클래스 생성
}

// SecondPage의 상태를 관리하는 클래스
class _SecondPageState extends State<SecondPage> {
  late bool is_cat; // 초기값 설정

  @override
  void initState() {
    super.initState();
    is_cat = widget.isCat; // 전달받은 값으로 초기화
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.pets), // 좌측 상단에 아이콘 추가
        title: const Text("Second Page"), // 중앙에 텍스트 표시
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 세로 정렬 중앙
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  is_cat = true; // 버튼 클릭 시 true로 변경
                });

                // 스택 초기화 후 FirstPage로 이동
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text("Back"), // 버튼에 텍스트 표시
            ),
            const SizedBox(height: 30), // 여백 추가

            // 이미지 클릭 가능하도록 GestureDetector 사용
            GestureDetector(
              onTap: () {
                print("is_cat 상태: $is_cat"); // 클릭 시 상태 출력
              },
              child: Image.asset(
                'assets/image/dog.jpg', // 강아지 이미지 경로
                width: 500,
                height: 500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
