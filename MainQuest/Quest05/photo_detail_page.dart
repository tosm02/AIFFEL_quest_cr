// photo_detail_page.dart
import 'package:flutter/material.dart';
import 'photo.dart';
import 'image_analyzer.dart'; // 이미지 분석 모듈 가져오기
import 'dart:typed_data';
import 'package:http/http.dart' as http; // HTTP 패키지 임포트
import 'package:flutter_dotenv/flutter_dotenv.dart'; // API 키를 위한 dotenv 가져오기

class PhotoDetailPage extends StatefulWidget {
  final Photo photo;
  const PhotoDetailPage({super.key, required this.photo});

  @override
  _PhotoDetailPageState createState() => _PhotoDetailPageState();
}

class _PhotoDetailPageState extends State<PhotoDetailPage> {
  String _analyzedText = "";
  bool _isAnalyzing = false;

  @override
  void initState() {
    super.initState();
    _initializeAPIKey(); // 상태 초기화 시 API 키 초기화
  }

  Future<void> _initializeAPIKey() async {
    await dotenv.load(fileName: ".env");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.photo.title),
        backgroundColor: const Color.fromARGB(255, 254, 255, 198),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 10, // 사진 크기
              child: loadImage(widget.photo),
            ),
            const SizedBox(height: 20),
            Text(
              widget.photo.title,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.analytics,
                  color: Colors.white, size: 28), // 아이콘 크기 조정
              label: const Text('이미지 분석',
                  style:
                      TextStyle(color: Colors.white, fontSize: 18)), // 폰트 크기 조정
              onPressed: _isAnalyzing ? null : _analyzeImage, // 분석 중이면 버튼 비활성화
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 28, 44, 101),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 12, horizontal: 20), // 버튼 패딩 조정
              ),
            ),
            const SizedBox(height: 10), // 간격 조정
            if (_isAnalyzing) // 로딩 중일 때 로딩 인디케이터 표시
              const CircularProgressIndicator(),
            const SizedBox(height: 10),
            if (_analyzedText.isNotEmpty)
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 28, 44, 101),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints:
                          const BoxConstraints(minWidth: double.infinity),
                      child: SelectableText(
                        _analyzedText,
                        style: TextStyle(
                          fontSize: 13.0,
                          color: const Color.fromARGB(255, 254, 254, 254),
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _analyzeImage() async {
    setState(() {
      _isAnalyzing = true;
      _analyzedText = "";
    });

    try {
      String apiKey = dotenv.env['API_KEY'] ?? '';

      if (apiKey.isEmpty) {
        debugPrint('API 키가 없습니다. .env 파일을 확인하세요.');
        return;
      }

      debugPrint('이미지 URL: ${widget.photo.url}'); // URL 출력

      // 이미지 URL에서 Uint8List로 변환
      final response = await http.get(Uri.parse(widget.photo.url));

      if (response.statusCode == 200) {
        Uint8List imageBytes = response.bodyBytes; // 이미지 바이트 가져오기
        final String result = await analyzeImage(context, imageBytes, apiKey);

        setState(() {
          _analyzedText = result;
        });
      } else {
        debugPrint('이미지 로드 실패: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('이미지를 가져오는 중 오류 발생: $e. 이미지 URL이 올바르고 접근 가능한지 확인하세요.');
    } finally {
      setState(() {
        _isAnalyzing = false;
      });
    }
  }
}
