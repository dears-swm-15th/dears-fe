import 'package:dears/providers/profile_provider.dart';
import 'package:dears/providers/user_info_provider.dart';
import 'package:dears/utils/icons.dart';
import 'package:dears/utils/theme.dart';
import 'package:dears/widgets/cdn_image.dart';
import 'package:dears/widgets/personal_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const Widget _profileImageFallback = Icon(DearsIcons.person, size: 36);

class PersonalProfileListTile extends ConsumerWidget {
  const PersonalProfileListTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);

    final image = profile.maybeWhen(
      data: (data) {
        return CdnImage(
          data.profileImageUrl,
          fit: BoxFit.contain,
          fallback: _profileImageFallback,
        );
      },
      orElse: () => _profileImageFallback,
    );

    final name = profile.maybeWhen(
      data: (data) => data.name,
      orElse: () => "",
    );

    return PersonalListTile(
      onTap: () => ref.read(userInfoProvider.notifier).signUp(),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 36,
        child: image,
      ),
      titleSpacing: 8,
      title: Text(name, style: titleMedium),
      subtitle: const Text("example@gmail.com"),
      trailing: const Padding(
        padding: EdgeInsets.all(10),
        child: Icon(DearsIcons.caret_right, size: 24),
      ),
    );
  }
}
