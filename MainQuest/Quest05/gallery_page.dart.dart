// gallery_page.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'photo.dart';
import 'photo_detail_page.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  // 랜덤 숫자 생성기
  final Random random = Random();
  final Set<int> usedNumbers = <int>{}; // 사용된 번호를 저장할 세트
  final List<Photo> dummyPhotos = []; // 사진 목록

  void generateDummyPhotos() {
    usedNumbers.clear(); // 새로고침 시 사용된 번호 초기화
    dummyPhotos.clear(); // 새로고침 시 사진 목록 초기화

    while (dummyPhotos.length < 15) {
      int randomNumber = random.nextInt(300);
      if (!usedNumbers.contains(randomNumber)) {
        // 중복 확인
        usedNumbers.add(randomNumber);
        dummyPhotos.add(Photo(
          id: dummyPhotos.length + 1,
          url:
              'https://picsum.photos/200?random=$randomNumber', // 고정 크기와 랜덤 번호 사용
          title: 'Photo ${dummyPhotos.length + 1}',
        ));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    generateDummyPhotos(); // 초기 사진 목록 생성
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Gallery'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                generateDummyPhotos(); // 새로고침 버튼 클릭 시 새로운 사진 목록 생성
              });
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 그리드를 3칸씩 설정
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
          childAspectRatio: 1.0, // 그리드 항목의 높이를 조정
        ),
        itemCount: dummyPhotos.length,
        itemBuilder: (context, index) {
          final photo = dummyPhotos[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PhotoDetailPage(photo: photo),
                ),
              );
            },
            child: GridTile(
              footer: GridTileBar(
                backgroundColor: Colors.black54,
                title: Text(
                  photo.title,
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
              child: Hero(
                tag: 'photo_${photo.id}',
                child: loadImage(photo),
              ),
            ),
          );
        },
      ),
    );
  }
}
