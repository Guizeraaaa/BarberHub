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
    this.backgroundColor,
    this.foregroundColor,
    this.textButtonColor,
    this.borderColor,
  });

  final String textButton;
  final VoidCallback? onPressed;
  final bool isLoading;
  final ButtonType type;

  // Cores opcionais: quem não passar nada fica com o padrão laranja/branco.
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? textButtonColor;
  final Color? borderColor;

  Color get _backgroundColor {
    if (backgroundColor != null) {
      return backgroundColor!;
    }
    return type == ButtonType.filled ? AppColors.orangeLigth : AppColors.white;
  }

  Color get _textColor {
    if (textButtonColor != null) {
      return textButtonColor!;
    }
    return type == ButtonType.filled ? AppColors.white : AppColors.orangeLigth;
  }

  ButtonStyle _getButtonStyle() {
    switch (type) {
      case ButtonType.filled:
        return ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(40),
          foregroundColor: foregroundColor ?? AppColors.white,
          backgroundColor: _backgroundColor,
          textStyle: AppTextStyle.subTittle,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        );

      case ButtonType.outlined:
        return ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(40),
          foregroundColor: foregroundColor ?? AppColors.white,
          backgroundColor: _backgroundColor,
          textStyle: AppTextStyle.subTittle,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: BorderSide(
              color: borderColor ?? AppColors.orangeLigth,
              width: 2,
            ),
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
                color: _textColor,
                strokeWidth: 3,
              ),
            )
          : Text(
              textButton,
              style: AppTextStyle.subTittle.copyWith(color: _textColor),
            ),
    );
  }
}
