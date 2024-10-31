//photo.dart
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';

class Photo {
  final int id;
  final String title;
  final String url;
  bool isLiked; // 좋아요 상태를 추가

  Photo(
      {required this.id,
      required this.title,
      required this.url,
      this.isLiked = false});
}

// 랜덤 숫자 생성기
final Random random = Random();

// 16개의 사진을 추가하고 URL의 마지막 번호를 랜덤하게 설정
final List<Photo> dummyPhotos = List.generate(15, (index) {
  int randomNumber = random.nextInt(300); // 0 ~ 300 사이의 랜덤 번호 생성
  return Photo(
    id: index + 1,
    url: 'https://picsum.photos/200?random=$randomNumber', // 고정 크기와 랜덤 번호 사용
    title: 'Photo ${index + 1}',
  );
});

Widget loadImage(Photo photo) {
  return photo.url.startsWith('http')
      ? Image.network(photo.url)
      : Image.file(File(photo.url));
}
