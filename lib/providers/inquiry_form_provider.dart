import 'package:dears/models/inquiry_form_data.dart';
import 'package:dears/models/inquiry_request_body.dart';
import 'package:dears/providers/mypage_client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'inquiry_form_provider.g.dart';

@riverpod
class InquiryForm extends _$InquiryForm {
  @override
  InquiryFormData build() {
    return const InquiryFormData(
      title: "고객센터 문의합니다.",
      content: "",
    );
  }

  void setTitle(String title) {
    state = state.copyWith(title: title);
  }

  void setContent(String content) {
    state = state.copyWith(content: content);
  }

  Future<void> submit() async {
    final mypageClient = await ref.read(mypageClientProvider.future);
    return await mypageClient.submit(
      data: InquiryRequestBody(
        title: state.title,
        content: state.content,
      ),
    );
  }
}
