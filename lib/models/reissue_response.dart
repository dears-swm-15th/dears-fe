import 'package:freezed_annotation/freezed_annotation.dart';

part 'reissue_response.freezed.dart';
part 'reissue_response.g.dart';

@Freezed(toJson: false)
class ReissueResponse with _$ReissueResponse {
  const factory ReissueResponse({
    required String accessToken,
    required String refreshToken,
  }) = _RefreshResponse;

  factory ReissueResponse.fromJson(Map<String, dynamic> json) =>
      _$ReissueResponseFromJson(json);
}
