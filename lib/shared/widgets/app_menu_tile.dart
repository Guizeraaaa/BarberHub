import 'package:barberhub/shared/app_colors.dart';
import 'package:barberhub/shared/app_text_style.dart';
import 'package:flutter/material.dart';

class MenuTile extends StatelessWidget {
  const MenuTile({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.black,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          width: 150,
          height: 130,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 14,
            children: [
              Icon(icon, size: 52, color: AppColors.orangeLigth),
              Text(
                label.toUpperCase(),
                style: AppTextStyle.subTittle.copyWith(color: AppColors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
