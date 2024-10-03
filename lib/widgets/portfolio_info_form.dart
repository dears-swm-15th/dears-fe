import 'package:dears/models/accompany_type.dart';
import 'package:dears/models/region.dart';
import 'package:dears/providers/register_portfolio_form_provider.dart';
import 'package:dears/utils/formats.dart';
import 'package:dears/utils/icons.dart';
import 'package:dears/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PortfolioInfoForm extends HookConsumerWidget {
  const PortfolioInfoForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 각 입력 필드에 대한 컨트롤러 추가
    final nameController = useTextEditingController(); // 이름 입력 필드 컨트롤러
    final companyController = useTextEditingController(); // 회사명 입력 필드 컨트롤러
    final serviceController = useTextEditingController(); // 서비스 입력 필드 컨트롤러
    final introduceController = useTextEditingController(); // 자기 소개 입력 필드 컨트롤러
    final costController = useTextEditingController(); // 상담 비용 입력 필드 컨트롤러
    // 등록된 서비스 리스트 상태
    final services = ref.watch(registerPortfolioFormProvider).services;

    // 이름 필드 리스너
    useEffect(
      () {
        void listener() {
          ref.read(registerPortfolioFormProvider.notifier).setPlannerName(
                nameController.text,
              );
        }

        nameController.addListener(listener);
        return () => nameController.removeListener(listener);
      },
      [],
    );

    // 회사명 필드 리스너
    useEffect(
      () {
        void listener() {
          ref.read(registerPortfolioFormProvider.notifier).setCompanyName(
                companyController.text,
              );
        }

        companyController.addListener(listener);
        return () => companyController.removeListener(listener);
      },
      [],
    );

    // useEffect로 비용 필드의 변경을 반영
    useEffect(
      () {
        void listener() {
          final formattedValue = cost.format(costController.value.text);
          costController.value = TextEditingValue(
            text: formattedValue,
            selection: TextSelection.collapsed(
              offset: formattedValue.length, // 커서를 끝으로 이동
            ),
          );
          ref.read(registerPortfolioFormProvider.notifier).setCost(
                costController.text,
              );
        }

        costController.addListener(listener);
        return () => costController.removeListener(listener);
      },
      [],
    );

    useEffect(
      () {
        void listener() {
          ref.read(registerPortfolioFormProvider.notifier).setIntroduce(
            introduceController.text,
              );
        }

        introduceController.addListener(listener);
        return () => introduceController.removeListener(listener);
      },
      [],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "웨딩플래너 기본정보 작성",
              style: titleLarge,
            ),
            const SizedBox(height: 20),

            // 이름 입력
            const Text("이름", style: bodyLarge),
            const SizedBox(height: 8),
            TextField(
              controller: nameController, // 이름 입력 필드에 컨트롤러 추가
              decoration: const InputDecoration(
                hintText: "이름을 입력해주세요",
              ),
            ),
            const SizedBox(height: 20),

            // 회사명 입력
            const Text("회사명", style: bodyLarge),
            const SizedBox(height: 8),
            TextField(
              controller: companyController, // 회사명 입력 필드에 컨트롤러 추가
              decoration: const InputDecoration(
                hintText: "회사명을 입력해주세요",
              ),
            ),

            const SizedBox(height: 20),

            const Text("자기소개", style: bodyLarge),
            const SizedBox(height: 8),
            TextField(
              controller: introduceController, // 자기 소개 입력 필드에 컨트롤러 추가
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: "소개하는 글을 입력해주세요",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            // 활동지역 선택
            const Text("활동지역", style: bodyLarge),
            const SizedBox(height: 8),
            DropdownButtonFormField<Region>(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              hint: const Text("활동지역을 선택해주세요"),
              onChanged: (value) {
                ref
                    .read(registerPortfolioFormProvider.notifier)
                    .setRegion(value!);
              },
              items: Region.values.map((region) {
                return DropdownMenuItem(
                  value: region,
                  child: Text(region.name),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            const Text("유형", style: bodyLarge),
            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: AccompanyType.values.map((type) {
                final selectedType =
                    ref.read(registerPortfolioFormProvider).type;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: OutlinedButton(
                      onPressed: () {
                        ref
                            .read(registerPortfolioFormProvider.notifier)
                            .setAccompanyType(type);
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(
                          color:
                              selectedType == type ? blue500: gray100,
                        ),
                        textStyle: bodyLarge,
                      ),
                      child: Text(
                        type.name,
                        style: TextStyle(
                          color:
                              selectedType == type ? blue500 : gray600,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // 제공 서비스 입력 필드
            const Text("제공 서비스", style: bodyLarge),
            const SizedBox(height: 8),

            // 동적으로 추가된 서비스 리스트
            for (final service in services)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: service, // 추가된 서비스 표시
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),

            // 새 서비스 입력 필드
            TextField(
              controller: serviceController, // 서비스 입력 필드에 컨트롤러 추가
              decoration: const InputDecoration(
                hintText: "서비스를 입력해주세요",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // 추가 버튼
            Center(
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: blue50,
                    ),
                    child: IconButton(
                      color: blue500,
                      splashColor: Colors.transparent,
                      onPressed: () {
                        if (serviceController.text.isNotEmpty) {
                          // 서비스 리스트에 새 항목 추가
                          ref
                              .read(registerPortfolioFormProvider.notifier)
                              .addService(serviceController.text);
                          serviceController.clear(); // 텍스트 필드 초기화
                        }
                      },
                      icon: const Icon(DearsIcons.add, color: Colors.blue),
                    ),
                  ),
                  const Text("추가", style: captionLarge),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // 상담 비용 입력 필드
            const Text("상담비용", style: bodyLarge),
            const SizedBox(height: 8),
            TextField(
              controller: costController, // 상담 비용 입력 필드에 컨트롤러 추가
              decoration: const InputDecoration(
                hintText: "상담 비용을 입력해주세요",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
