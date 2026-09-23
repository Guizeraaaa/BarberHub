import 'package:barberhub/features/appointment/controllers/appointment_controller.dart';
import 'package:barberhub/features/appointment/widgets/appointment_card.dart';
import 'package:barberhub/shared/app_colors.dart';
import 'package:barberhub/shared/app_text_style.dart';
import 'package:barberhub/shared/models/Appointment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppointmentPage extends StatelessWidget {
  const AppointmentPage({super.key});

  static String route = '/appointment';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'COMPROMISSOS',
          style: AppTextStyle.tittle.copyWith(color: AppColors.white),
        ),
        centerTitle: true,
        backgroundColor: AppColors.black,
      ),
      body: Consumer<AppointmentController>(
        builder: (context, appointmentController, child) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  AppointmentCard(
                    appointment: appointmentController.appointmentList[1],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
