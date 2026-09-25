import 'package:barberhub/shared/app_colors.dart';
import 'package:barberhub/shared/app_text_style.dart';
import 'package:flutter/material.dart';

class AppAvatar extends StatelessWidget {
  const AppAvatar({super.key, this.size = 52, this.initial, this.imageUrl});

  final double size;
  final String? initial;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final hasImage = imageUrl != null && imageUrl!.isNotEmpty;

    return CircleAvatar(
      radius: size / 2,
      backgroundColor: hasImage
          ? AppColors.black
          : AppColors.grey.withValues(alpha: 0.3),
      backgroundImage: hasImage ? NetworkImage(imageUrl!) : null,
      child: hasImage
          ? null
          : Text(
              initial ?? '',
              style: AppTextStyle.body.copyWith(
                fontSize: size * 0.42,
                color: AppColors.black.withValues(alpha: 0.7),
              ),
            ),
    );
  }
}
