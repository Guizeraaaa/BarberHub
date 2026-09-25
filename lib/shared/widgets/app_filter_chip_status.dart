import 'package:barberhub/shared/app_colors.dart';
import 'package:barberhub/shared/app_text_style.dart';
import 'package:flutter/material.dart';

class AppFilterChipStatus extends StatelessWidget {
  const AppFilterChipStatus({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.label,
  });

  final bool isSelected;
  final VoidCallback onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: 100,
        height: 30,
        decoration: BoxDecoration(
          color: isSelected == true ? AppColors.black : AppColors.white,
          borderRadius: BorderRadius.circular(100),
          border: !isSelected
              ? Border.all(color: AppColors.grey, width: 1.5)
              : null,
        ),
        child: Text(
          label,
          style: AppTextStyle.label.copyWith(
            color: isSelected == true ? AppColors.white : AppColors.black,
          ),
        ),
      ),
    );
  }
}
