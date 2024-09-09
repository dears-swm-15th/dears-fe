import 'package:dears/utils/icons.dart';
import 'package:dears/utils/theme.dart';
import 'package:flutter/material.dart';

class RoleSelectionButton extends StatelessWidget {
  final String colorTitle;
  final String normalTitle;
  final String subtitle;
  final VoidCallback onPressed;

  const RoleSelectionButton({
    required this.colorTitle,
    required this.normalTitle,
    required this.subtitle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: colorTitle,
                            style: titleLarge.copyWith(color: blue500),
                          ),
                          TextSpan(
                            text: normalTitle,
                            style: titleLarge,
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      DearsIcons.caret_right,
                      color: gray600,
                      size: 20,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  subtitle,
                  style: bodyMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
