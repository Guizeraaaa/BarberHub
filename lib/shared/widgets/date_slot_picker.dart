import 'package:barberhub/shared/app_colors.dart';
import 'package:barberhub/shared/app_text_style.dart';
import 'package:flutter/material.dart';

class DateSlotPicker extends StatelessWidget {
  const DateSlotPicker({
    super.key,
    required this.date,
    required this.slots,
    required this.onDateTap,
    required this.onSlotSelected,
    this.selectedSlot,
  });

  final DateTime date;
  final List<String> slots;
  final String? selectedSlot;
  final VoidCallback onDateTap;
  final ValueChanged<String> onSlotSelected;

  static const _weekdays = [
    'segunda',
    'terça',
    'quarta',
    'quinta',
    'sexta',
    'sábado',
    'domingo',
  ];
  static const _months = [
    'janeiro',
    'fevereiro',
    'março',
    'abril',
    'maio',
    'junho',
    'julho',
    'agosto',
    'setembro',
    'outubro',
    'novembro',
    'dezembro',
  ];

  String get _dateLabel =>
      '${_weekdays[date.weekday - 1]}, ${date.day} ${_months[date.month - 1]}';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.3),
            spreadRadius: 4,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildHeader(),
          _buildDateButton(),
          slots.isEmpty ? _buildEmpty() : _buildSlots(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 56,
      color: AppColors.black,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        spacing: 12,
        children: [
          Icon(Icons.calendar_month, color: AppColors.white),
          Text(
            'Selecione uma data e horário',
            style: AppTextStyle.body.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateButton() {
    return TextButton(
      onPressed: onDateTap,
      style: TextButton.styleFrom(
        foregroundColor: AppColors.black,
        minimumSize: const Size.fromHeight(56),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 6,
        children: [
          Text(_dateLabel, style: AppTextStyle.body.copyWith(fontSize: 18)),
          const Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }

  Widget _buildEmpty() {
    final style = AppTextStyle.body.copyWith(
      fontSize: 14,
      color: AppColors.orangeDark,
    );
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: Column(
        spacing: 4,
        children: [
          Text(
            'Nenhum horário disponível para esta data.',
            style: style,
            textAlign: TextAlign.center,
          ),
          Text(
            'Considere selecionar outra data para o agendamento.',
            style: style,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSlots() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          const gap = 8.0;
          final chipWidth = (constraints.maxWidth - gap * 3) / 4;

          return Wrap(
            spacing: gap,
            runSpacing: gap,
            children: [
              for (final slot in slots)
                SizedBox(
                  width: chipWidth,
                  height: 44,
                  child: _SlotChip(
                    label: slot,
                    selected: slot == selectedSlot,
                    onTap: () => onSlotSelected(slot),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _SlotChip extends StatelessWidget {
  const _SlotChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.zero,
        backgroundColor: selected ? AppColors.black : AppColors.white,
        foregroundColor: selected ? AppColors.white : AppColors.black,
        side: BorderSide(
          color: selected
              ? AppColors.black
              : AppColors.grey.withValues(alpha: 0.5),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      child: Text(label, style: AppTextStyle.subTittle.copyWith(fontSize: 15)),
    );
  }
}
