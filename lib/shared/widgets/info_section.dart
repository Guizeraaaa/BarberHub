import 'package:barberhub/shared/app_colors.dart';
import 'package:barberhub/shared/app_text_style.dart';
import 'package:flutter/material.dart';

class InfoSection extends StatelessWidget {
  const InfoSection({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        spacing: 4,
        children: [
          Text(
            label.toUpperCase(),
            style: AppTextStyle.tittle.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: AppColors.orangeDark,
            ),
          ),
          Text(value, style: AppTextStyle.body.copyWith(fontSize: 16)),
        ],
      ),
    );
  }
}
