import 'package:barberhub/shared/app_colors.dart';
import 'package:barberhub/shared/app_text_style.dart';
import 'package:barberhub/shared/models/Appointment.dart';
import 'package:barberhub/shared/utils.dart';
import 'package:barberhub/shared/widgets/app_filter_chip_status.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppFilterDialog<T> extends StatelessWidget {
  const AppFilterDialog({
    super.key,
    required this.selectedStatusList,
    required this.onChipChanged,
  });

  final List<AppointmentStatus> selectedStatusList;

  final Function(AppointmentStatus value) onChipChanged;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(20),
      child: Consumer<T>(
        builder: (context, controller, child) {
          return Container(
            width: double.infinity,
            height: 500,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'FILTRAR',
                          style: AppTextStyle.tittle.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.close,
                            color: AppColors.white,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  child: Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'STATUS',
                        style: AppTextStyle.subTittle.copyWith(
                          color: AppColors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: AppointmentStatus.values.length,
                          itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.only(
                              right:
                                  index == AppointmentStatus.values.length - 1
                                  ? 0
                                  : 10,
                            ),
                            child: AppFilterChipStatus(
                              isSelected: selectedStatusList.any(
                                (element) =>
                                    element.name ==
                                    AppointmentStatus.values[index].name,
                              ),
                              onTap: () {
                                onChipChanged(AppointmentStatus.values[index]);
                              },
                              label: Utils.formatAppointmentStatus(
                                AppointmentStatus.values[index],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
