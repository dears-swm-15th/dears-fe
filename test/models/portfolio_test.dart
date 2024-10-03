import 'dart:convert';

import 'package:dears/models/portfolio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("json serialization test", () {
    const jsonString = """
{
  "id": 1,
  "organization": "에바웨딩스",
  "plannerName": "김지수",
  "region": "SEOUL",
  "introduction": "안녕하세요.",
  "contactInfo": "010-1234-5678",
  "profileImageUrl": "sdlkfjw3gee",
  "description": "웨딩 준비 도와드릴게요.",
  "consultingFee": 30000,
  "minEstimate": 20000,
  "services": [
    "퍼스널 컬러 체크",
    "웨딩드레스 시착 1회 무료"
  ],
  "weddingPhotoUrls": [
    "src/portfolio/img1.jpg",
    "src/portfolio/img2.jpg"
  ],
  "avgRadar": {
    "COMMUNICATION": 4.5,
    "BUDGET_COMPLIANCE": 3.8,
    "PERSONAL_CUSTOMIZATION": 4.7,
    "PRICE_RATIONALITY": 4,
    "SCHEDULE_COMPLIANCE": 4.6
  },
  "presignedProfileImageUrl": "https://s3.amazonaws.com/bucket/profileImageUrl",
  "presignedWeddingPhotoUrls": [
    "https://s3.amazonaws.com/bucket/weddingPhoto1.jpg",
    "https://s3.amazonaws.com/bucket/weddingPhoto2.jpg"
  ],
  "avgRating": 4.2,
  "avgEstimate": 300000,
  "createdAt": "2024-07-24T05:42:57.446Z",
  "updatedAt": "2024-07-24T05:42:57.446Z"
}
""";

    final json = jsonDecode(jsonString) as Map<String, dynamic>;

    expect(
      () => Portfolio.fromJson(json),
      isNot(
        anyOf(
          throwsArgumentError,
          throwsA(isA<TypeError>()),
        ),
      ),
    );
  });
}
