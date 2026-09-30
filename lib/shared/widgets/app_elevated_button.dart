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
    this.backgroundColor,
    this.foregroundColor,
    this.textButtonColor,
    this.borderColor,
  });

  final String textButton;
  final Color? textButtonColor;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? borderColor;

  final Color? backgroundColor;
  final Color? foregroundColor;

  final ButtonType type;

  ButtonStyle _getButtonStyle() {
    switch (type) {
      case ButtonType.filled:
        return ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(40),
          foregroundColor: foregroundColor,
          backgroundColor: backgroundColor,
          textStyle: AppTextStyle.subTittle,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        );

      case ButtonType.outlined:
        return ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(40),
          foregroundColor: foregroundColor,
          backgroundColor: backgroundColor,
          textStyle: AppTextStyle.subTittle,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: BorderSide(color: borderColor ?? Colors.black, width: 2),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: _getButtonStyle(),
      child: isLoading
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: foregroundColor,
                strokeWidth: 3,
              ),
            )
          : Text(textButton, style: TextStyle(color: textButtonColor)),
    );
  }
}
