import 'package:barberhub/shared/app_colors.dart';
import 'package:barberhub/shared/app_text_style.dart';
import 'package:flutter/material.dart';

// Rodapé da tela Agendar: preço, duração e botão de confirmar.
class PriceSummary extends StatelessWidget {
  const PriceSummary({
    super.key,
    required this.priceText,
    required this.durationMinutes,
    required this.onConfirm,
  });

  final String priceText; // já formatado, ex: 'R\$ 45,00'
  final int? durationMinutes;
  final VoidCallback? onConfirm; // null = botão desabilitado

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(color: AppColors.grey.withValues(alpha: 0.3)),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          spacing: 16,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'A partir de',
                  style: AppTextStyle.body.copyWith(color: AppColors.grey),
                ),
                Text(
                  priceText,
                  style: AppTextStyle.tittle.copyWith(fontSize: 22),
                ),
                if (durationMinutes != null)
                  Text(
                    '$durationMinutes minutos',
                    style: AppTextStyle.body.copyWith(color: AppColors.grey),
                  ),
              ],
            ),
            Expanded(
              child: SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: onConfirm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.black,
                    foregroundColor: AppColors.white,
                    disabledBackgroundColor: AppColors.grey.withValues(
                      alpha: 0.4,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Text(
                    'CONFIRMAR',
                    style: AppTextStyle.subTittle.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
