import 'package:barberhub/shared/app_colors.dart';
import 'package:barberhub/shared/app_text_style.dart';
import 'package:barberhub/shared/models/Appointment.dart';
import 'package:barberhub/shared/models/barber.dart';
import 'package:barberhub/shared/models/service.dart';
import 'package:barberhub/shared/utils.dart';
import 'package:barberhub/shared/widgets/app_dropdown_button_form_field.dart';
import 'package:barberhub/shared/widgets/app_elevated_button.dart';
import 'package:barberhub/shared/widgets/app_filter_chip_status.dart';
import 'package:flutter/material.dart';

import 'app_date_ranger_picker.dart';

class AppFilterDialog<T> extends StatefulWidget {
  const AppFilterDialog({
    super.key,
    required this.selectedStatusList,
    required this.professionalsList,
    required this.selectedProfessional,
    required this.servicesList,
    required this.selectedService,
    required this.selectedDateRange,
    required this.onApply,
    required this.onClear,
  });

  final List<AppointmentStatus> selectedStatusList;
  final List<Barber> professionalsList;
  final List<Service> servicesList;

  final String selectedProfessional;
  final String selectedService;
  final DateTimeRange<DateTime>? selectedDateRange;
  final void Function({
    required List<AppointmentStatus> statusList,
    required String professional,
    required String service,
    required DateTimeRange<DateTime>? dateRange,
  })
  onApply;
  final VoidCallback onClear;

  @override
  State<AppFilterDialog<T>> createState() => _AppFilterDialogState<T>();
}

class _AppFilterDialogState<T> extends State<AppFilterDialog<T>> {
  late List<AppointmentStatus> _selectedStatusList;
  late String _selectedProfessional;
  late String _selectedService;
  late DateTimeRange<DateTime>? _selectedDateRange;

  @override
  void initState() {
    super.initState();
    _selectedStatusList = List.of(widget.selectedStatusList);
    _selectedProfessional = widget.selectedProfessional;
    _selectedService = widget.selectedService;
    _selectedDateRange = widget.selectedDateRange;
  }

  void _toggleStatus(AppointmentStatus status) {
    setState(() {
      if (_selectedStatusList.contains(status)) {
        _selectedStatusList.remove(status);
      } else {
        _selectedStatusList.add(status);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(20),
      child: Container(
        width: double.infinity,
        height: 600,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.orangeLigth,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'FILTRAR',
                          style: AppTextStyle.tittle.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close,
                          color: AppColors.white,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                child: Column(
                  spacing: 30,
                  children: [
                    Column(
                      spacing: 6,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PERIODO',
                          style: AppTextStyle.subTittle.copyWith(
                            color: AppColors.grey,
                          ),
                        ),
                        AppDateRangerPicker(
                          selectedDateRangeOf: () => _selectedDateRange,
                          onChanged: (value) {
                            setState(() => _selectedDateRange = value);
                          },
                        ),
                      ],
                    ),
                    Column(
                      spacing: 6,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'STATUS',
                          style: AppTextStyle.subTittle.copyWith(
                            color: AppColors.grey,
                          ),
                        ),
                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(
                              AppointmentStatus.values.length,
                              (index) => AppFilterChipStatus(
                                isSelected: _selectedStatusList.any(
                                  (element) =>
                                      element.name ==
                                      AppointmentStatus.values[index].name,
                                ),
                                onTap: () {
                                  _toggleStatus(
                                    AppointmentStatus.values[index],
                                  );
                                },
                                label: Utils.formatAppointmentStatus(
                                  AppointmentStatus.values[index],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Column(
                      spacing: 6,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PROFISSIONAIS',
                          style: AppTextStyle.subTittle.copyWith(
                            color: AppColors.grey,
                          ),
                        ),
                        AppDropdownButtonFormField(
                          selectedItem: _selectedProfessional,
                          items: widget.professionalsList,
                          onChanged: (value) {
                            setState(() => _selectedProfessional = value ?? '');
                          },
                          nameOf: (barber) => barber.name,
                        ),
                      ],
                    ),

                    Column(
                      spacing: 6,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SERVIÇOS',
                          style: AppTextStyle.subTittle.copyWith(
                            color: AppColors.grey,
                          ),
                        ),
                        AppDropdownButtonFormField(
                          selectedItem: _selectedService,
                          items: widget.servicesList,
                          onChanged: (value) {
                            setState(() => _selectedService = value ?? '');
                          },
                          nameOf: (service) => service.name,
                        ),
                      ],
                    ),

                    Row(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: AppElevatedButton(
                            onPressed: () {
                              widget.onClear();
                              Navigator.pop(context);
                            },
                            textButton: 'Limpar',
                            type: ButtonType.outlined,
                          ),
                        ),
                        Expanded(
                          child: AppElevatedButton(
                            onPressed: () {
                              widget.onApply(
                                statusList: List.of(_selectedStatusList),
                                professional: _selectedProfessional,
                                service: _selectedService,
                                dateRange: _selectedDateRange,
                              );
                              Navigator.pop(context, true);
                            },
                            textButton: 'Aplicar',
                            type: ButtonType.filled,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
