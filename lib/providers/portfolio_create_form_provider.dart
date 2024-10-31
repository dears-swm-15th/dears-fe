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
    return const PortfolioCreateFormData(
      plannerName: "",
      companyName: "",
      introduce: "",
      region: Region.defaultValue,
      type: AccompanyType.defaultValue,
      services: [""],
      cost: null,
      content: "",
      profileImage: null,
      portfolioImages: [],
    );
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
    state = state.copyWith(
      portfolioImages: [...state.portfolioImages, ...images],
    );
  }

  void removePortfolioImageAt(int index) {
    state = state.copyWith(
      portfolioImages: [...state.portfolioImages]..removeAt(index),
    );
  }

  void setServiceAt(int index, String value) {
    state = state.copyWith(services: [...state.services]..[index] = value);
  }

  void addService() {
    state = state.copyWith(services: [...state.services, ""]);
  }

  void removeServiceAt(int index) {
    state = state.copyWith(services: [...state.services]..removeAt(index));
  }

  void setCost(int? value) {
    state = state.copyWith(cost: value);
  }

  Future<void> submit() async {
    final cost = state.cost;
    final profileImage = state.profileImage;
    if (cost == null || profileImage == null) {
      throw AssertionError();
    }

    final portfolioClient = await ref.read(portfolioClientProvider.future);

    final response = await portfolioClient.create(
      data: PortfolioCreateBody(
        organization: state.companyName,
        plannerName: state.plannerName,
        region: state.region,
        introduction: state.content,
        consultingFee: cost,
        description: state.content,
        services: state.services,
        accompanyType: state.type,
        profileImageUrl: profileImage.name,
        weddingPhotoUrls: [
          for (final image in state.portfolioImages) image.name,
        ],
      ),
    );

    await Future.wait([
      fileClient.upload(
        presignedUrl: response.presignedProfileImageUrl,
        file: profileImage.data,
      ),
      for (final (i, url) in response.presignedWeddingPhotoUrls.indexed)
        fileClient.upload(
          presignedUrl: url,
          file: state.portfolioImages[i].data,
        ),
    ]);
  }
}
