import 'package:barberhub/features/scheduling/controllers/scheduling_controller.dart';
import 'package:barberhub/shared/app_colors.dart';
import 'package:barberhub/shared/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppDateRangerPicker extends StatefulWidget {
  const AppDateRangerPicker({
    super.key,
    required this.selectedDateRangeOf,
    required this.onChanged,
  });

  final DateTimeRange<DateTime>? Function() selectedDateRangeOf;
  final ValueChanged<DateTimeRange<DateTime>> onChanged;

  @override
  State<AppDateRangerPicker> createState() => _AppDateRangerPickerState();
}

class _AppDateRangerPickerState extends State<AppDateRangerPicker> {
  final _startController = TextEditingController();
  final _endController = TextEditingController();
  String? _rangeError;

  @override
  void initState() {
    super.initState();
    final range = widget.selectedDateRangeOf();
    if (range != null) {
      _startController.text = _formatDate(range.start);
      _endController.text = _formatDate(range.end);
    }
  }

  @override
  void dispose() {
    _startController.dispose();
    _endController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  DateTime? _parseDate(String value) {
    if (!RegExp(r'^\d{2}/\d{2}/\d{4}$').hasMatch(value)) return null;

    final parts = value.split('/').map(int.parse).toList();
    final date = DateTime(parts[2], parts[1], parts[0]);
    return date.year == parts[2] &&
            date.month == parts[1] &&
            date.day == parts[0]
        ? date
        : null;
  }

  void _updateRange() {
    final start = _parseDate(_startController.text);
    final end = _parseDate(_endController.text);

    if (start == null || end == null) {
      setState(() => _rangeError = null);
      return;
    }

    if (end.isBefore(start)) {
      setState(
        () => _rangeError = 'A data final deve ser posterior à inicial.',
      );
      return;
    }

    setState(() => _rangeError = null);
    widget.onChanged(DateTimeRange(start: start, end: end));
  }

  InputDecoration _decoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: AppTextStyle.label.copyWith(color: AppColors.black),
      floatingLabelStyle: AppTextStyle.label.copyWith(color: AppColors.black),
      hintText: 'dd/MM/aaaa',
      errorText: _rangeError,
      errorMaxLines: 2,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.greyLight),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.black, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TextFormField(
            cursorColor: AppColors.grey,
            controller: _startController,
            keyboardType: TextInputType.datetime,
            inputFormatters: const [_DateInputFormatter()],
            decoration: _decoration('Data inicial'),
            style: AppTextStyle.subTittle,
            onChanged: (_) => _updateRange(),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: TextFormField(
            cursorColor: AppColors.grey,
            controller: _endController,
            keyboardType: TextInputType.datetime,
            inputFormatters: const [_DateInputFormatter()],
            decoration: _decoration('Data final'),
            style: AppTextStyle.subTittle,
            onChanged: (_) => _updateRange(),
          ),
        ),
      ],
    );
  }
}

class _DateInputFormatter extends TextInputFormatter {
  const _DateInputFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final rawDigits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final length = rawDigits.length > 8 ? 8 : rawDigits.length;
    final digits = rawDigits.substring(0, length);
    final buffer = StringBuffer();

    for (var index = 0; index < digits.length; index++) {
      if (index == 2 || index == 4) buffer.write('/');
      buffer.write(digits[index]);
    }

    final text = buffer.toString();
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
