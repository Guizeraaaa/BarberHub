import 'package:barberhub/shared/app_colors.dart';
import 'package:barberhub/shared/app_text_style.dart';
import 'package:barberhub/shared/models/Appointment.dart';
import 'package:barberhub/shared/utils.dart';
import 'package:flutter/material.dart';

enum CardType { scheduled, finishied }

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({super.key, required this.appointment});

  final Appointment appointment;
  CardType get type {
    if (appointment.status == AppointmentStatus.agendado) {
      return CardType.scheduled;
    }

    return CardType.finishied;
  }

  BoxDecoration _getCardStyle() {
    switch (type) {
      case CardType.scheduled:
        return BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              spreadRadius: 4,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        );
      case CardType.finishied:
        return BoxDecoration(
          color: AppColors.greyLight,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              spreadRadius: 4,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: 100,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: _getCardStyle(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  spacing: 10,
                  children: [
                    Text(
                      Utils.dateFormat(appointment.dateTime),
                      style: type == CardType.scheduled
                          ? AppTextStyle.tittle
                          : AppTextStyle.tittle.copyWith(color: AppColors.grey),
                    ),
                    Text(
                      Utils.hourFormat(appointment.dateTime),
                      style: AppTextStyle.subTittle.copyWith(
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                    color: type == CardType.scheduled
                        ? AppColors.orangeLigth.withValues(alpha: 0.5)
                        : AppColors.grey.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    Utils.formatAppointmentStatus(appointment.status),
                    style: AppTextStyle.body.copyWith(
                      color: type == CardType.scheduled
                          ? AppColors.orangeDark
                          : AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: appointment.service.name,
                            style: type == CardType.scheduled
                                ? AppTextStyle.subTittle
                                : AppTextStyle.subTittle.copyWith(
                                    color: AppColors.grey,
                                  ),
                          ),
                          TextSpan(
                            text: ' • ',
                            style: type == CardType.scheduled
                                ? AppTextStyle.subTittle
                                : AppTextStyle.subTittle.copyWith(
                                    color: AppColors.grey,
                                  ),
                          ),
                          TextSpan(
                            text: Utils.durationFormat(
                              appointment.service.durationMinutes,
                            ),
                            style: type == CardType.scheduled
                                ? AppTextStyle.subTittle
                                : AppTextStyle.subTittle.copyWith(
                                    color: AppColors.grey,
                                  ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      appointment.barber.name,
                      style: AppTextStyle.subTittle.copyWith(
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                ),
                type == CardType.scheduled
                    ? IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.edit_outlined,
                          color: AppColors.orangeLigth,
                        ),
                      )
                    : SizedBox.shrink(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
