import 'package:barberhub/features/appointment/pages/appointment_page.dart';
import 'package:barberhub/features/login/controllers/login_controller.dart';
import 'package:barberhub/features/scheduling/controllers/scheduling_controller.dart';
import 'package:barberhub/shared/app_colors.dart';
import 'package:barberhub/shared/app_text_style.dart';
import 'package:barberhub/shared/widgets/app_header.dart';
import 'package:barberhub/shared/widgets/app_price_summary.dart';
import 'package:barberhub/shared/widgets/avatar_card.dart';
import 'package:barberhub/shared/widgets/date_slot_picker.dart';
import 'package:barberhub/shared/widgets/list_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SchedulingPage extends StatelessWidget {
  const SchedulingPage({super.key});

  static const String route = '/scheduling';

  @override
  Widget build(BuildContext context) {
    return Consumer<SchedulingController>(
      builder: (context, schedulingController, child) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: const AppHeader(title: 'Agendar'),
          body: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    ListCard(
                      title: schedulingController.serviceTitle,
                      subtitle: schedulingController.serviceSubtitle,
                      avatar: AppAvatar(
                        initial: schedulingController.serviceInitial,
                      ),
                      tone: CardTone.name,
                      trailing: CardTrailing.action,
                      actionLabel: schedulingController.serviceActionLabel,
                      onTap: () => _showServices(context, schedulingController),
                    ),
                    const SizedBox(height: 10),
                    ListCard(
                      title: schedulingController.barberTitle,
                      subtitle: schedulingController.barberSubtitle,
                      avatar: AppAvatar(
                        initial: schedulingController.barberInitial,
                      ),
                      tone: CardTone.name,
                      trailing: CardTrailing.action,
                      actionLabel: schedulingController.barberActionLabel,
                      onTap: () => _showBarbers(context, schedulingController),
                    ),
                    const SizedBox(height: 16),
                    schedulingController.canShowSlots
                        ? DateSlotPicker(
                            date: schedulingController.selectedDate,
                            slots: schedulingController.getAvailableSlots(),
                            selectedSlot: schedulingController.selectedSlot,
                            onDateTap: () =>
                                _pickDate(context, schedulingController),
                            onSlotSelected: schedulingController.selectSlot,
                          )
                        : Text(
                            'Escolha o serviço e o barbeiro para ver os horários.',
                            textAlign: TextAlign.center,
                            style: AppTextStyle.body.copyWith(
                              fontSize: 14,
                              color: AppColors.grey,
                            ),
                          ),
                  ],
                ),
              ),
              PriceSummary(
                priceText: schedulingController.priceText,
                durationMinutes: schedulingController.durationMinutes,
                // null deixa o botão desabilitado
                onConfirm: schedulingController.canConfirm
                    ? () => _confirm(context, schedulingController)
                    : null,
              ),
            ],
          ),
        );
      },
    );
  }

  void _showServices(BuildContext context, SchedulingController controller) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.background,
      builder: (context) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            for (final service in controller.serviceList)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ListCard(
                  title: service.name,
                  subtitle: controller.serviceDescription(service),
                  avatar: AppAvatar(initial: service.name[0]),
                  tone: CardTone.name,
                  onTap: () {
                    controller.selectService(service);
                    Navigator.pop(context);
                  },
                ),
              ),
          ],
        );
      },
    );
  }

  void _showBarbers(BuildContext context, SchedulingController controller) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.background,
      builder: (context) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            for (final barber in controller.barberList)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ListCard(
                  title: barber.name,
                  subtitle: 'Barbeiro',
                  avatar: AppAvatar(initial: barber.name[0]),
                  tone: CardTone.name,
                  onTap: () {
                    controller.selectBarber(barber);
                    Navigator.pop(context);
                  },
                ),
              ),
          ],
        );
      },
    );
  }

  Future<void> _pickDate(
    BuildContext context,
    SchedulingController controller,
  ) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: controller.selectedDate,
      firstDate: controller.firstDate,
      lastDate: controller.lastDate,
    );

    if (date != null) {
      controller.selectDate(date);
    }
  }

  void _confirm(BuildContext context, SchedulingController controller) {
    final clientId = context.read<LoginController>().loggedClient?.id;
    final String? error = controller.confirmAppointment(clientId);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(error ?? 'Agendamento confirmado!')),
    );

    if (error == null) {
      Navigator.pushNamed(context, AppointmentPage.route);
    }
  }
}
