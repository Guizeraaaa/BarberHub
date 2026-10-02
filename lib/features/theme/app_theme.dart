import 'package:barberhub/shared/app_colors.dart';
import 'package:barberhub/shared/app_text_style.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    listTileTheme: ListTileThemeData(
      iconColor: AppColors.orangeDark,
      textColor: AppColors.black,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStatePropertyAll(AppColors.orangeDark),
      trackColor: WidgetStatePropertyAll(AppColors.orangeLigth),
    ),
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(primary: AppColors.orangeDark),
    scaffoldBackgroundColor: AppColors.offWhite,
    iconTheme: IconThemeData(color: AppColors.orangeLigth),

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.black,
      titleTextStyle: AppTextStyle.bodyHome.copyWith(color: AppColors.offWhite),
      iconTheme: IconThemeData(color: AppColors.orangeDark),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    listTileTheme: ListTileThemeData(
      iconColor: AppColors.orangeDark,
      textColor: AppColors.white,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStatePropertyAll(AppColors.orangeDark),
      trackColor: WidgetStatePropertyAll(AppColors.orangeDark),
    ),
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(primary: AppColors.orangeDark),
    scaffoldBackgroundColor: AppColors.black,
    iconTheme: IconThemeData(color: AppColors.orangeDark),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.black,
      titleTextStyle: AppTextStyle.bodyHome,
      iconTheme: IconThemeData(color: AppColors.orangeDark),
    ),
  );
}
