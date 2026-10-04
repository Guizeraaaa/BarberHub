import 'package:barberhub/shared/app_colors.dart';
import 'package:barberhub/shared/app_text_style.dart';
import 'package:barberhub/shared/widgets/app_elevated_button.dart';
import 'package:flutter/material.dart';

class AppConfirmationDialog extends StatelessWidget {
  const AppConfirmationDialog({
    super.key,
    required this.title,
    required this.content,
    required this.icon,
    required this.labelCancel,
    required this.labelConfirm,
  });

  final String title;
  final String content;
  final Icon icon;
  final String labelCancel;
  final String labelConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.white,
      icon: icon,
      title: Text(
        title,
        style: AppTextStyle.tittle.copyWith(color: AppColors.orangeLigth),
      ),
      content: Text(
        content,
        style: AppTextStyle.label.copyWith(color: AppColors.grey),
        textAlign: TextAlign.center,
      ),
      actions: [
        Row(
          spacing: 10,
          children: [
            Expanded(
              child: AppElevatedButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                textButton: labelCancel,
                type: ButtonType.outlined,
              ),
            ),
            Expanded(
              child: AppElevatedButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                textButton: labelConfirm,
                type: ButtonType.filled,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
