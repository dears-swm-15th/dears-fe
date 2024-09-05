import 'package:dears/widgets/error_bottom_sheet.dart';
import 'package:flutter/material.dart';



class CustomBottomSheets {

  CustomBottomSheets._();

  static Future<void> showError({
    required BuildContext context,
    required String title,
    required String message,
    required String buttonText,
    required VoidCallback onButtonPressed,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return ErrorBottomSheet(
          title: title,
          message: message,
          buttonText: buttonText,
          onButtonPressed: onButtonPressed,
        );
      },
    );
  }

  static Future<void> showSuccess({
    required BuildContext context,
    required String title,
    required String message,
    required String buttonText,
    required VoidCallback onButtonPressed,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return ErrorBottomSheet(
          title: title,
          message: message,
          buttonText: buttonText,
          onButtonPressed: onButtonPressed,
        );
      },
    );
  }

  static Future<void> showInfo({
    required BuildContext context,
    required String title,
    required String message,
    required String buttonText,
    required VoidCallback onButtonPressed,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return ErrorBottomSheet(
          title: title,
          message: message,
          buttonText: buttonText,
          onButtonPressed: onButtonPressed,
        );
      },
    );
  }

}
