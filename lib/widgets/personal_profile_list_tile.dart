import 'package:dears/providers/profile_provider.dart';
import 'package:dears/providers/user_info_provider.dart';
import 'package:dears/utils/icons.dart';
import 'package:dears/utils/theme.dart';
import 'package:dears/widgets/cdn_image.dart';
import 'package:dears/widgets/personal_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PersonalProfileListTile extends ConsumerWidget {
  const PersonalProfileListTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);

    final url = profile.whenOrNull(
      data: (data) => data.profileImageUrl,
    );

    final name = profile.maybeWhen(
      data: (data) => data.name,
      orElse: () => "",
    );

    final email = profile.maybeWhen(
      data: (data) => data.email,
      orElse: () => "",
    );

    return PersonalListTile(
      onTap: () => ref.read(userInfoProvider.notifier).logout(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      leading: CdnImage.circle(
        url,
        dimension: 72,
        fallback: const Icon(DearsIcons.person, size: 36),
      ),
      titleSpacing: 8,
      title: Text(name, style: titleMedium),
      subtitle: Text(email),
      trailing: const Icon(DearsIcons.caret_right, size: 24),
      //Icon(DearsIcons.pencil_simple, size: 24),
    );
  }
}
