import 'package:dears/providers/profile_provider.dart';
import 'package:dears/providers/role_provider.dart';
import 'package:dears/utils/icons.dart';
import 'package:dears/utils/theme.dart';
import 'package:dears/widgets/cdn_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PersonalProfileListTile extends ConsumerWidget {
  const PersonalProfileListTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(roleProvider).value;

    final profile = ref.watch(profileProvider);

    final url = profile.whenOrNull(
      data: (data) => data.profileImageUrl,
    );

    final nickname = profile.maybeWhen(
      data: (data) => data.nickname,
      orElse: () => "",
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Row(
        children: [
          CdnImage.circle(
            url,
            dimension: 72,
            fallback: const Icon(DearsIcons.person, size: 36),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: const ShapeDecoration(
                  color: blue50,
                  shape: StadiumBorder(),
                ),
                child: Text(
                  "$role",
                  style: const TextStyle(
                    color: blue500,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    height: 16 / 12,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(nickname, style: titleMedium),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
