import 'package:barberhub/features/appointment/controllers/appointment_controller.dart';
import 'package:barberhub/features/appointment/widgets/appointment_card.dart';
import 'package:barberhub/shared/app_colors.dart';
import 'package:barberhub/shared/app_text_style.dart';
import 'package:barberhub/shared/models/Appointment.dart';
import 'package:barberhub/shared/widgets/app_filter_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  static String route = '/appointment';

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<AppointmentController>().getAppointment();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        centerTitle: true,
        title: Text(
          'COMPROMISSOS',
          style: AppTextStyle.tittle.copyWith(color: AppColors.white),
        ),
        actions: [
          Consumer<AppointmentController>(
            builder: (context, appointmentController, child) {
              return IconButton(
                onPressed: () async {
                  await showDialog<bool>(
                    context: context,
                    builder: (context) =>
                        AppFilterDialog<AppointmentController>(
                          selectedStatusList:
                              appointmentController.selectedStatusList,
                          professionalsList:
                              appointmentController.professionalsList,
                          selectedProfessional:
                              appointmentController.selectedProfessional,
                          servicesList: appointmentController.servicesList,
                          selectedService:
                              appointmentController.selectedService,
                          selectedDateRange:
                              appointmentController.selectedDateRange,
                          onApply:
                              ({
                                required statusList,
                                required professional,
                                required service,
                                required dateRange,
                              }) {
                                appointmentController.applyFilters(
                                  statusList: statusList,
                                  professional: professional,
                                  service: service,
                                  dateRange: dateRange,
                                );
                              },
                          onClear: () {
                            appointmentController.clearFilters();
                          },
                        ),
                  );
                },
                icon: Icon(Icons.filter_list, color: AppColors.white),
              );
            },
          ),
        ],
      ),
      body: Consumer<AppointmentController>(
        builder: (context, appointmentController, child) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: appointmentController.appointmentList.length,
                      itemBuilder: (context, index) {
                        Appointment appointment =
                            appointmentController.appointmentList[index];
                        return AppointmentCard(
                          appointment: appointment,
                          cancelAppointment: () {
                            appointmentController.cancelAppointment(
                              appointmentController.appointmentList[index],
                            );
                          },
                        );
                      },
                    ),
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
