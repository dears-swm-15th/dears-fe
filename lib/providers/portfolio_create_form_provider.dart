import 'dart:typed_data';

import 'package:dears/clients/file_client.dart';
import 'package:dears/models/accompany_type.dart';
import 'package:dears/models/image_data.dart';
import 'package:dears/models/portfolio_create_body.dart';
import 'package:dears/models/portfolio_create_form_data.dart';
import 'package:dears/models/region.dart';
import 'package:dears/providers/portfolio_client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'portfolio_create_form_provider.g.dart';

@riverpod
class PortfolioCreateForm extends _$PortfolioCreateForm {
  @override
  PortfolioCreateFormData build() {
    return PortfolioCreateFormData(
      plannerName: "",
      companyName: "",
      introduce: "",
      region: null,
      type: AccompanyType.defaultValue,
      services: const [],
      cost: "",
      content: "",
      profileImage: ImageData("", Uint8List(0)),
      portfolioImages: const [],
    );
  }

  void addService(String service) {
    state = state.copyWith(services: [...state.services, service]);
  }

  void setProfileImages(ImageData image) {
    state = state.copyWith(profileImage: image);
  }

  void setPlannerName(String plannerName) {
    state = state.copyWith(plannerName: plannerName);
  }

  void setCompanyName(String companyName) {
    state = state.copyWith(companyName: companyName);
  }

  void setRegion(Region region) {
    state = state.copyWith(region: region);
  }

  void setCost(String cost) {
    state = state.copyWith(cost: cost);
  }

  void setAccompanyType(AccompanyType type) {
    state = state.copyWith(type: type);
  }

  void setContent(String content) {
    state = state.copyWith(content: content);
  }

  void setIntroduce(String introduce) {
    state = state.copyWith(introduce: introduce);
  }

  void addPortfolioImages(Iterable<ImageData> images) {
    state =
        state.copyWith(portfolioImages: [...state.portfolioImages, ...images]);
  }

  void removePortfolioImageAt(int index) {
    state = state.copyWith(
      portfolioImages: [...state.portfolioImages]..removeAt(index),
    );
  }

  Future<void> submit() async {
    final portfolioClient = await ref.read(portfolioClientProvider.future);

    final response = await portfolioClient.create(
      body: PortfolioCreateBody(
        organization: state.companyName,
        plannerName: state.plannerName,
        region: state.region!,
        introduction: state.content,
        consultingFee: int.parse(state.cost.replaceAll(RegExp('[^0-9]'), "")),
        description: state.content,
        services: state.services,
        accompanyType: state.type,
        profileImageUrl: state.profileImage.name,
        weddingPhotoUrls: [
          for (final image in state.portfolioImages) image.name,
        ],
      ),
      //TODO: upload to fileClient
    );
    // 프로필 이미지 업로드
    await Future.wait([
      fileClient.upload(
        presignedUrl: response.presignedProfileImageUrl,
        file: state.profileImage.data,
      ),
    ]);
    // 대표 이미지 업로드
    await Future.wait([
      for (final (i, url) in response.presignedWeddingPhotoUrls.indexed)
        fileClient.upload(
          presignedUrl: url,
          file: state.portfolioImages[i].data,
        ),
    ]);

    ref.invalidateSelf();
  }
}
