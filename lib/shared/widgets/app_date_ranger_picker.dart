import 'package:barberhub/shared/app_colors.dart';
import 'package:barberhub/shared/app_text_style.dart';
import 'package:flutter/material.dart';

class AppDateRangerPicker extends StatelessWidget {
  const AppDateRangerPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      onTap: () {
        showDateRangePicker(
          initialEntryMode: DatePickerEntryMode.inputOnly,
          initialDateRange: DateTimeRange(
            start: DateTime(2026),
            end: DateTime(2027),
          ),
          context: context,
          firstDate: DateTime(2020),
          lastDate: DateTime(2050),
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData(
                colorScheme: ColorScheme.light(
                  primary: AppColors
                      .black, // Cor do rótulo focado, borda focada e botões
                  onSurface: AppColors
                      .black, // Cor do texto digitado dentro da caixa // Cor do rótulo desfocado ("Start Date")
                  surface: AppColors.white, // Fundo do diálogo
                ),
                datePickerTheme: DatePickerThemeData(
                  backgroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  headerHelpStyle: AppTextStyle.subTittle,
                  headerHeadlineStyle: AppTextStyle.tittle,
                ),
                textTheme: TextTheme(
                  bodyLarge: AppTextStyle.label, //
                ),
                inputDecorationTheme: InputDecorationTheme(
                  labelStyle: AppTextStyle.subTittle,
                  floatingLabelStyle: AppTextStyle.body,
                  hintStyle: AppTextStyle.body,
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.black, width: 1.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                textSelectionTheme: TextSelectionThemeData(
                  cursorColor: AppColors.grey,
                  selectionHandleColor: AppColors.grey,
                ),
              ),
              child: child!,
            );
          },
        );
      },
    );
  }
}
