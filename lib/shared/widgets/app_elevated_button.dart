import 'package:barberhub/shared/app_colors.dart';
import 'package:barberhub/shared/app_text_style.dart';
import 'package:flutter/material.dart';

enum ButtonType { filled, outlined }

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    super.key,
    required this.textButton,
    required this.type,
    required this.onPressed,
    this.isLoading = false,
  });

  final String textButton;
  final VoidCallback? onPressed;
  final bool isLoading;
  final ButtonType type;

  ButtonStyle _getButtonStyle() {
    switch (type) {
      case ButtonType.filled:
        return ElevatedButton.styleFrom(
          backgroundColor: AppColors.orangeLigth,
          minimumSize: Size.fromHeight(40),
          foregroundColor: AppColors.white,
          textStyle: AppTextStyle.subTittle,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        );

      case ButtonType.outlined:
        return ElevatedButton.styleFrom(
          backgroundColor: AppColors.white,
          minimumSize: Size.fromHeight(40),
          foregroundColor: AppColors.white,
          textStyle: AppTextStyle.subTittle.copyWith(color: AppColors.black),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: AppColors.orangeLigth, width: 2),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      // style: _getButtonStyle(),
      child: isLoading
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: type == ButtonType.filled
                    ? AppColors.white
                    : AppColors.orangeLigth,
                strokeWidth: 3,
              ),
            )
          : Text(
              textButton,
              style: type == ButtonType.filled
                  ? AppTextStyle.subTittle.copyWith(color: AppColors.white)
                  : AppTextStyle.subTittle.copyWith(
                      color: AppColors.orangeLigth,
                    ),
            ),
    );
  }
}
