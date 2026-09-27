import 'package:barberhub/shared/app_colors.dart';
import 'package:barberhub/shared/mocks/mock_json.dart';
import 'package:barberhub/shared/utils.dart';
import 'package:barberhub/shared/widgets/app_header.dart';
import 'package:barberhub/shared/widgets/app_price_summary.dart';
import 'package:barberhub/shared/widgets/avatar_card.dart';
import 'package:barberhub/shared/widgets/date_slot_picker.dart';
import 'package:barberhub/shared/widgets/list_card.dart';
import 'package:flutter/material.dart';

class SchedulingPage extends StatelessWidget {
  const SchedulingPage({super.key});

  static const String route = '/scheduling';

  @override
  Widget build(BuildContext context) {
    final service = mockServices[0];
    final barber = mockBarbers[0];
    final date = DateTime.now();
    final slots = ['09:00', '09:30', '10:00', '10:30', '11:00', '14:00'];

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
                  title: service.name,
                  subtitle:
                      '${Utils.formatCurrency(service.price)} - '
                      '${Utils.durationFormat(service.durationMinutes)}',
                  avatar: AppAvatar(initial: service.name[0]),
                  tone: CardTone.name,
                  trailing: CardTrailing.action,
                  onTap: () {
                  },
                ),
                const SizedBox(height: 10),
                ListCard(
                  title: barber.name,
                  subtitle: 'Barbeiro',
                  avatar: AppAvatar(initial: barber.name[0]),
                  tone: CardTone.name,
                  trailing: CardTrailing.action,
                  onTap: () {
                  },
                ),
                const SizedBox(height: 16),
                DateSlotPicker(
                  date: date,
                  slots: slots,
                  onDateTap: () {
                  },
                  onSlotSelected: (slot) {
                  },
                ),
              ],
            ),
          ),
          PriceSummary(
            priceText: Utils.formatCurrency(service.price),
            durationMinutes: service.durationMinutes,
            onConfirm: null,
          ),
        ],
      ),
    );
  }
}