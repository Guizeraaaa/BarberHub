import 'package:barberhub/shared/app_colors.dart';
import 'package:barberhub/shared/app_text_style.dart';
import 'package:barberhub/shared/widgets/avatar_card.dart';
import 'package:flutter/material.dart';

class DetailHero extends StatelessWidget {
  const DetailHero({
    super.key,
    required this.title,
    this.subtitle,
    this.initial,
    this.imageUrl,
    this.uppercase = false,
  });

  final String title;
  final String? subtitle;
  final String? initial;
  final String? imageUrl;
  final bool uppercase;

  @override
  Widget build(BuildContext context) {
    final hasSubtitle = subtitle != null && subtitle!.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
      child: Column(
        spacing: 12,
        children: [
          AppAvatar(size: 170, initial: initial, imageUrl: imageUrl),
          const SizedBox(height: 4),
          Text(
            uppercase ? title.toUpperCase() : title,
            textAlign: TextAlign.center,
            style: AppTextStyle.tittle.copyWith(
              fontSize: 32,
              fontWeight: FontWeight.w500,
              color: AppColors.orangeDark,
            ),
          ),
          if (hasSubtitle)
            Text(
              subtitle!,
              textAlign: TextAlign.center,
              style: AppTextStyle.body.copyWith(fontSize: 16),
            ),
        ],
      ),
    );
  }
}
