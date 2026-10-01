import 'package:barberhub/features/appointment/pages/appointment_page.dart';
import 'package:barberhub/features/scheduling/controllers/scheduling_controller.dart';
import 'package:barberhub/shared/app_colors.dart';
import 'package:barberhub/shared/models/service.dart';
import 'package:barberhub/shared/utils.dart';
import 'package:barberhub/shared/widgets/app_avatar_card.dart';
import 'package:barberhub/shared/widgets/app_date_slot_picker.dart';
import 'package:barberhub/shared/widgets/app_header.dart';
import 'package:barberhub/shared/widgets/app_list_card.dart';
import 'package:barberhub/shared/widgets/app_price_summary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SchedulingPage extends StatelessWidget {
  const SchedulingPage({super.key});

  static const String route = '/scheduling';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(title: 'Agendar'),
      body: Consumer<SchedulingController>(
        builder: (context, schedulingController, child) {
          final service = schedulingController.selectedService;
          final barber = schedulingController.selectedBarber;

          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    AppListCard(
                      title: service.name,
                      subtitle: serviceSubtitle(service),
                      avatar: AppAvatar(initial: service.name[0]),
                      tone: CardTone.name,
                      trailing: CardTrailing.action,
                      onTap: () {
                        showServices(context, schedulingController);
                      },
                    ),
                    const SizedBox(height: 10),
                    AppListCard(
                      title: barber.name,
                      subtitle: 'Barbeiro',
                      avatar: AppAvatar(initial: barber.name[0]),
                      tone: CardTone.name,
                      trailing: CardTrailing.action,
                      onTap: () {
                        showBarbers(context, schedulingController);
                      },
                    ),
                    const SizedBox(height: 16),
                    AppDateSlotPicker(
                      date: schedulingController.selectedDate,
                      slots: schedulingController.availableSlots(),
                      selectedSlot: schedulingController.selectedSlot,
                      onDateTap: () async {
                        final pickedDate = await showDatePicker(
                          context: context,
                          initialDate: schedulingController.selectedDate,
                          firstDate: schedulingController.firstDate,
                          lastDate: schedulingController.lastDate,
                        );
                        if (pickedDate != null) {
                          schedulingController.selectDate(pickedDate);
                        }
                      },
                      onSlotSelected: (slot) {
                        schedulingController.selectSlot(slot);
                      },
                    ),
                  ],
                ),
              ),
              AppPriceSummary(
                priceText: Utils.formatCurrency(service.price),
                durationMinutes: service.durationMinutes,
                onConfirm: schedulingController.canConfirm
                    ? () {
                        final appointment = schedulingController
                            .confirmAppointment();
                        if (appointment == null) {
                          return;
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: AppColors.black,
                            content: Text(
                              'Agendado: ${appointment.service.name} com '
                              '${appointment.barber.name} em '
                              '${Utils.dateFormat(appointment.dateTime)} às '
                              '${Utils.hourFormat(appointment.dateTime)}',
                            ),
                          ),
                        );

                        // pushNamed (e não pushReplacementNamed): assim o
                        // "voltar" de Compromissos traz de volta para Agendar.
                        Navigator.pushNamed(context, AppointmentPage.route);
                      }
                    : null,
              ),
            ],
          );
        },
      ),
    );
  }

  String serviceSubtitle(Service service) {
    return '${Utils.formatCurrency(service.price)} - '
        '${Utils.durationFormat(service.durationMinutes)}';
  }

  void showServices(
    BuildContext context,
    SchedulingController schedulingController,
  ) {
    final services = schedulingController.servicesList;

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.background,
      builder: (context) {
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: services.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final service = services[index];
            return AppListCard(
              title: service.name,
              subtitle: serviceSubtitle(service),
              avatar: AppAvatar(initial: service.name[0]),
              tone: CardTone.name,
              onTap: () {
                schedulingController.selectService(service);
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }

  void showBarbers(
    BuildContext context,
    SchedulingController schedulingController,
  ) {
    final barbers = schedulingController.barbersForSelectedService();

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.background,
      builder: (context) {
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: barbers.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final barber = barbers[index];
            return AppListCard(
              title: barber.name,
              subtitle: 'Barbeiro',
              avatar: AppAvatar(initial: barber.name[0]),
              tone: CardTone.name,
              onTap: () {
                schedulingController.selectBarber(barber);
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }
}