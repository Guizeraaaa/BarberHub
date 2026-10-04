import 'package:barberhub/shared/app_colors.dart';
import 'package:barberhub/shared/app_text_style.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StatusPieChart extends StatelessWidget {
  const StatusPieChart({
    super.key,
    required this.scheduled,
    required this.completed,
    required this.canceled,
  });

  final int scheduled;
  final int completed;
  final int canceled;

  @override
  Widget build(BuildContext context) {
    final total = scheduled + completed + canceled;

    if (total == 0) {
      return Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          'Ainda não há atendimentos.',
          textAlign: TextAlign.center,
          style: AppTextStyle.subTittle.copyWith(color: AppColors.grey),
        ),
      );
    }

    return Column(
      children: [
        SizedBox(
          height: 180,
          child: PieChart(
            PieChartData(
              centerSpaceRadius: 40,
              sectionsSpace: 2,
              sections: [
                if (scheduled > 0) _section(scheduled, AppColors.orangeLigth),
                if (completed > 0) _section(completed, AppColors.black),
                if (canceled > 0) _section(canceled, AppColors.grey),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 16,
          runSpacing: 6,
          alignment: WrapAlignment.center,
          children: [
            _legend('Agendados', scheduled, AppColors.orangeLigth),
            _legend('Concluídos', completed, AppColors.black),
            _legend('Cancelados', canceled, AppColors.grey),
          ],
        ),
      ],
    );
  }

  PieChartSectionData _section(int value, Color color) {
    return PieChartSectionData(
      value: value.toDouble(),
      color: color,
      radius: 50,
      title: '$value',
      titleStyle: AppTextStyle.subTittle.copyWith(color: AppColors.white),
    );
  }

  Widget _legend(String label, int value, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          '$label ($value)',
          style: AppTextStyle.label.copyWith(color: AppColors.black),
        ),
      ],
    );
  }
}
