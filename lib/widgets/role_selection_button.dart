import 'package:dears/models/member_role.dart';
import 'package:dears/utils/icons.dart';
import 'package:dears/utils/theme.dart';
import 'package:dears/widgets/role_selection_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RoleSelectionButton extends ConsumerWidget {
  final MemberRole role;
  final String subtitle;

  const RoleSelectionButton({
    required this.role,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => showRoleSelectionDialog(context, ref, role: role),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 2),
              blurRadius: 4,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: role.label,
                        style: titleLarge.copyWith(color: blue500),
                      ),
                      const TextSpan(text: "로 시작하기", style: titleLarge),
                    ],
                  ),
                ),
                const Icon(
                  DearsIcons.caret_right,
                  size: 20,
                  color: gray600,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(subtitle, style: bodyMedium),
          ],
        ),
      ),
    );
  }
}
