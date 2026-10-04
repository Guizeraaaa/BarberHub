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
      context.read<AppointmentController>().loadAppointments();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppointmentController>(
      builder: (context, appointmentController, child) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.black,
            centerTitle: true,
            title: Text(
              appointmentController.isBarber
                  ? 'MEUS ATENDIMENTOS'
                  : 'COMPROMISSOS',
              style: AppTextStyle.tittle.copyWith(color: AppColors.white),
            ),
            actions: [
              IconButton(
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
              ),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    if (appointmentController.appointmentList.isEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Text(
                          'Nenhum compromisso encontrado.\nUse o filtro para ver outros períodos.',
                          textAlign: TextAlign.center,
                          style: AppTextStyle.subTittle.copyWith(
                            color: AppColors.grey,
                          ),
                        ),
                      ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: appointmentController.appointmentList.length,
                      itemBuilder: (context, index) {
                        Appointment appointment =
                            appointmentController.appointmentList[index];
                        return AppointmentCard(
                          appointment: appointment,
                          showClientName: appointmentController.isBarber,
                          cancelAppointment:
                              appointmentController.canCancel(appointment)
                              ? () => appointmentController.cancelAppointment(
                                  appointment,
                                )
                              : null,
                          completeAppointment:
                              appointmentController.canComplete(appointment)
                              ? () => appointmentController
                                    .completeAppointment(appointment)
                              : null,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
