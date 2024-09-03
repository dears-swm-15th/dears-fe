import 'package:freezed_annotation/freezed_annotation.dart';

part 'inquiry_form_data.freezed.dart';
part 'inquiry_form_data.g.dart';

@freezed
class InquiryFormData with _$InquiryFormData {
  const factory InquiryFormData({
    required bool enabled,
    required String title,
    required String content,
  }) = _InquiryFormData;

  factory InquiryFormData.fromJson(Map<String, dynamic> json) =>
      _$InquiryFormDataFromJson(json);
}
