import 'package:barberhub/shared/app_colors.dart';
import 'package:barberhub/shared/app_text_style.dart';
import 'package:flutter/material.dart';

enum CardTone { accent, name, plain }

enum CardTrailing { chevron, action }

class ListCard extends StatelessWidget {
  const ListCard({
    super.key,
    required this.title,
    required this.avatar,
    this.subtitle,
    this.tone = CardTone.accent,
    this.trailing = CardTrailing.chevron,
    this.actionLabel = 'Alterar',
    this.onTap,
  });

  final String title;
  final String? subtitle;
  final Widget avatar;
  final CardTone tone;
  final CardTrailing trailing;
  final String actionLabel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.3),
            spreadRadius: 4,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(6),
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 12),
            child: Row(
              children: [
                avatar,
                const SizedBox(width: 16),
                Expanded(child: _buildTexts()),
                _buildTrailing(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTexts() {
    final hasSubtitle = subtitle != null && subtitle!.isNotEmpty;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tone == CardTone.accent ? title.toUpperCase() : title,
          style: _titleStyle(),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        if (hasSubtitle) ...[
          const SizedBox(height: 2),
          Text(
            subtitle!,
            style: AppTextStyle.body.copyWith(
              fontSize: 14,
              color: AppColors.grey,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }

  TextStyle _titleStyle() {
    if (tone == CardTone.plain) {
      return AppTextStyle.subTittle.copyWith(
        color: AppColors.black,
        fontWeight: FontWeight.w500,
      );
    }
    return AppTextStyle.subTittle.copyWith(color: AppColors.orangeDark);
  }

  Widget _buildTrailing() {
    if (trailing == CardTrailing.chevron) {
      return Icon(Icons.chevron_right, color: AppColors.orangeDark);
    }
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(foregroundColor: AppColors.orangeDark),
      child: Text(actionLabel, style: AppTextStyle.subTittle),
    );
  }
}
