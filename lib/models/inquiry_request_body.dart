import 'package:freezed_annotation/freezed_annotation.dart';

part 'inquiry_request_body.freezed.dart';
part 'inquiry_request_body.g.dart';

@freezed
class InquiryRequestBody with _$InquiryRequestBody {
  const factory InquiryRequestBody({
    required String title,
    required String content,
  }) = _InquiryRequestBody;

  factory InquiryRequestBody.fromJson(Map<String, dynamic> json) =>
      _$InquiryRequestBodyFromJson(json);
}
