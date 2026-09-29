import 'package:barberhub/features/appointment/pages/appointment_page.dart';
import 'package:barberhub/features/scheduling/controllers/scheduling_controller.dart';
import 'package:barberhub/shared/app_colors.dart';
import 'package:barberhub/shared/app_text_style.dart';
import 'package:barberhub/shared/models/Appointment.dart';
import 'package:barberhub/shared/models/barber.dart';
import 'package:barberhub/shared/models/service.dart';
import 'package:barberhub/shared/utils.dart';
import 'package:barberhub/shared/widgets/app_header.dart';
import 'package:barberhub/shared/widgets/app_price_summary.dart';
import 'package:barberhub/shared/widgets/app_select_dialog.dart';
import 'package:barberhub/shared/widgets/avatar_card.dart';
import 'package:barberhub/shared/widgets/date_slot_picker.dart';
import 'package:barberhub/shared/widgets/list_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SchedulingPage extends StatefulWidget {
  const SchedulingPage({super.key});

  static String route = '/scheduling';

  @override
  State<SchedulingPage> createState() => _SchedulingPageState();
}

class _SchedulingPageState extends State<SchedulingPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<SchedulingController>().initScheduling();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(title: 'Agendar'),
      body: Consumer<SchedulingController>(
        builder: (context, schedulingController, child) {
          final Service? service = schedulingController.selectedService;
          final Barber? professional =
              schedulingController.selectedProfessional;

          if (service == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    ListCard(
                      title: service.name,
                      subtitle:
                          '${Utils.formatCurrency(service.price)} - '
                          '${Utils.durationFormat(service.durationMinutes)}',
                      avatar: AppAvatar(initial: service.name[0]),
                      tone: CardTone.name,
                      trailing: CardTrailing.action,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AppSelectDialog<Service>(
                            title: 'Serviços',
                            items: schedulingController.servicesList,
                            selectedItem: service,
                            nameOf: (item) => item.name,
                            subtitleOf: (item) =>
                                '${Utils.formatCurrency(item.price)} - '
                                '${Utils.durationFormat(item.durationMinutes)}',
                            onSelected: (value) {
                              schedulingController.changeSelectedService(value);
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    ListCard(
                      title: professional?.name ?? 'Nenhum profissional',
                      subtitle: 'Barbeiro',
                      avatar: AppAvatar(initial: professional?.name[0] ?? '?'),
                      tone: CardTone.name,
                      trailing: CardTrailing.action,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AppSelectDialog<Barber>(
                            title: 'Profissionais',
                            items: schedulingController.professionalsList,
                            selectedItem: professional,
                            nameOf: (item) => item.name,
                            subtitleOf: (item) => 'Barbeiro',
                            onSelected: (value) {
                              schedulingController.changeSelectedProfessional(
                                value,
                              );
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    DateSlotPicker(
                      date: schedulingController.selectedDate,
                      slots: schedulingController.slotsList,
                      selectedSlot: schedulingController.selectedSlot,
                      onDateTap: () {
                        selectDate(context, schedulingController);
                      },
                      onSlotSelected: (slot) {
                        schedulingController.changeSelectedSlot(slot);
                      },
                    ),
                  ],
                ),
              ),
              AppPriceSummary(
                price: service.price,
                durationMinutes: service.durationMinutes,
                onConfirm: schedulingController.canConfirm
                    ? () {
                        final appointment = schedulingController
                            .confirmAppointment();
                        if (appointment != null) {
                          goToAppointments(context, appointment);
                        }
                      }
                    : null,
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> selectDate(
    BuildContext context,
    SchedulingController schedulingController,
  ) async {
    final today = DateTime.now();

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: schedulingController.selectedDate,
      firstDate: DateTime(today.year, today.month, today.day),
      lastDate: today.add(const Duration(days: 60)),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(
              primary: AppColors.black,
              onSurface: AppColors.black,
              surface: AppColors.white,
            ),
            datePickerTheme: DatePickerThemeData(
              backgroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              headerHelpStyle: AppTextStyle.subTittle,
              headerHeadlineStyle: AppTextStyle.tittle,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      schedulingController.changeSelectedDate(pickedDate);
    }
  }

  // Depois de confirmar, mostra um aviso e leva direto para Meus Compromissos.
  void goToAppointments(BuildContext context, Appointment appointment) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.black,
        content: Text(
          'Agendamento confirmado: ${appointment.service.name} com '
          '${appointment.barber.name} em '
          '${Utils.dateFormat(appointment.dateTime)} às '
          '${Utils.hourFormat(appointment.dateTime)}.',
          style: AppTextStyle.body.copyWith(
            fontSize: 14,
            color: AppColors.white,
          ),
        ),
      ),
    );

    Navigator.pushReplacementNamed(context, AppointmentPage.route);
  }
}
