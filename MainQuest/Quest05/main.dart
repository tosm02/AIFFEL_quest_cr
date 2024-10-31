// main.dart
import 'package:flutter/material.dart';
import 'gallery_page.dart';

void main() {
  runApp(const MyApp()); // 앱 실행 진입점
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => GalleryPage(),
      },
    );
  }
}
