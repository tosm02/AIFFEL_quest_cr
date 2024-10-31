// ai_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class AIService {
  final String apiUrl =
      "https://gemini.googleapis.com/v1/images:analyze"; // Gemini API URL
  final String apiKey =
      "AIzaSyBVr2dpJr0i5SVpackvbBul1h4OHg7iWok"; // Gemini API 키

  Future<String> getCaptionFromAI(String imageUrl) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        "Authorization": "Bearer $apiKey",
        "Content-Type": "application/json", // 헤더에 Content-Type 추가
      },
      body: jsonEncode({
        "image": {
          "source": {
            "imageUri": imageUrl, // 이미지 URL 포함
          },
        },
        "features": [
          {"type": "LABEL_DETECTION", "maxResults": 1} // 원하는 분석 기능 설정
        ],
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // 응답에서 캡션을 추출하는 방법은 API의 응답 형식에 따라 다름
      return data["labelAnnotations"][0]["description"] ??
          "No caption available"; // 적절한 데이터 추출
    } else {
      throw Exception("Failed to generate caption: ${response.body}");
    }
  }
}
