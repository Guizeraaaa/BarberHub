import 'package:barberhub/shared/app_colors.dart';
import 'package:barberhub/shared/app_text_style.dart';
import 'package:barberhub/shared/models/Appointment.dart';
import 'package:flutter/material.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({super.key, required this.appointment});

  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.3),
            spreadRadius: 4,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
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
                  Text('09/09', style: AppTextStyle.tittle),
                  Text(
                    '14:00',
                    style: AppTextStyle.subTittle.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.orangeLigth.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'AGENDADO',
                  style: AppTextStyle.body.copyWith(
                    color: AppColors.orangeDark,
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
                          text: 'Serviço + Serviço',
                          style: AppTextStyle.subTittle,
                        ),
                        TextSpan(text: '•', style: AppTextStyle.body),
                        TextSpan(
                          text: 'Duração',
                          style: AppTextStyle.subTittle,
                        ),
                      ],
                    ),
                  ),
                  Text('[Lucas Ramos]'),
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.edit, color: AppColors.orangeLigth),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
