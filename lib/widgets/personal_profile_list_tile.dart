import 'package:dears/providers/profile_provider.dart';
import 'package:dears/providers/user_info_provider.dart';
import 'package:dears/utils/icons.dart';
import 'package:dears/utils/theme.dart';
import 'package:dears/widgets/personal_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PersonalProfileListTile extends ConsumerWidget {
  const PersonalProfileListTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);

    const imageFallback = Icon(DearsIcons.person, size: 36);

    final image = profile.whenOrNull(
      data: (data) {
        final url = data.profileImageUrl;
        if (url == null) {
          return null;
        }

        return Image.network(
          url,
          loadingBuilder: (context, child, loadingProgress) => imageFallback,
          errorBuilder: (context, error, stackTrace) => imageFallback,
          fit: BoxFit.contain,
        );
      },
    );

    final name = profile.maybeWhen(
      data: (data) => data.name,
      orElse: () => "",
    );

    return PersonalListTile(
      onTap: () => ref.read(userInfoProvider.notifier).signUp(),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      leading: CircleAvatar(
        radius: 36,
        child: image ?? imageFallback,
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
