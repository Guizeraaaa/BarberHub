import 'package:barberhub/shared/app_colors.dart';
import 'package:barberhub/shared/app_text_style.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ServiceBarChart extends StatelessWidget {
  const ServiceBarChart({super.key, required this.countByService});

  final Map<String, int> countByService;

  @override
  Widget build(BuildContext context) {
    if (countByService.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          'Ainda não há atendimentos.',
          textAlign: TextAlign.center,
          style: AppTextStyle.subTittle.copyWith(color: AppColors.grey),
        ),
      );
    }

    final names = countByService.keys.toList();
    final values = countByService.values.toList();

    int biggest = 0;
    for (final value in values) {
      if (value > biggest) {
        biggest = value;
      }
    }

    return SizedBox(
      height: 220,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: biggest + 1,
          borderData: FlBorderData(show: false),
          gridData: FlGridData(drawVerticalLine: false, horizontalInterval: 1),
          barGroups: List.generate(names.length, (index) {
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: values[index].toDouble(),
                  color: AppColors.orangeLigth,
                  width: 18,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            );
          }),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(sideTitles: SideTitles()),
            rightTitles: const AxisTitles(sideTitles: SideTitles()),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                reservedSize: 28,
                getTitlesWidget: (value, meta) {
                  return SideTitleWidget(
                    meta: meta,
                    child: Text(
                      '${value.toInt()}',
                      style: AppTextStyle.body.copyWith(color: AppColors.black),
                    ),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index < 0 || index >= names.length) {
                    return const SizedBox.shrink();
                  }
                  return SideTitleWidget(
                    meta: meta,
                    child: SizedBox(
                      width: 60,
                      child: Text(
                        names[index],
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.body.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
