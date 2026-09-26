import 'package:barberhub/shared/app_colors.dart';
import 'package:barberhub/shared/app_text_style.dart';
import 'package:barberhub/shared/models/Appointment.dart';
import 'package:barberhub/shared/models/barber.dart';
import 'package:barberhub/shared/models/service.dart';
import 'package:barberhub/shared/utils.dart';
import 'package:barberhub/shared/widgets/app_dropdown_button_form_field.dart';
import 'package:barberhub/shared/widgets/app_filter_chip_status.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_date_ranger_picker.dart';

class AppFilterDialog<T> extends StatelessWidget {
  const AppFilterDialog({
    super.key,
    required this.selectedStatusList,
    required this.onChipChanged,
    required this.updateFilters,
    required this.professionalsList,
    required this.selectedProfessional,
    required this.changeSelectedProfessional,
    required this.clearFilters,
    required this.servicesList,
    required this.selectedService,
    required this.changeSelectedService,
    required this.exitFilters,
  });

  final List<AppointmentStatus> selectedStatusList;
  final List<Barber> professionalsList;
  final List<Service> servicesList;

  final Function(AppointmentStatus value) onChipChanged;
  final Function(String?) changeSelectedProfessional;
  final Function(String?) changeSelectedService;
  final VoidCallback updateFilters;
  final VoidCallback exitFilters;
  final VoidCallback clearFilters;

  final String selectedProfessional;
  final String selectedService;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(20),
      child: Consumer<T>(
        builder: (context, controller, child) {
          return Container(
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
                      color: AppColors.black,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
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
                              exitFilters();
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
                            AppDateRangerPicker(),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(
                                  AppointmentStatus.values.length,
                                  (index) => AppFilterChipStatus(
                                    isSelected: selectedStatusList.any(
                                      (element) =>
                                          element.name ==
                                          AppointmentStatus.values[index].name,
                                    ),
                                    onTap: () {
                                      onChipChanged(
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
                              selectedItem: selectedProfessional,
                              items: professionalsList,
                              onChanged: (value) {
                                changeSelectedProfessional(value);
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
                              selectedItem: selectedService,
                              items: servicesList,
                              onChanged: (value) {
                                changeSelectedService(value);
                              },
                              nameOf: (service) => service.name,
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ButtonStyle(),
                                onPressed: () {
                                  clearFilters();
                                  Navigator.pop(context);
                                },
                                child: Text('Limpar'),
                              ),
                            ),
                            Expanded(
                              child: ElevatedButton(
                                style: ButtonStyle(),
                                onPressed: () {
                                  updateFilters();
                                  Navigator.pop(context);
                                },
                                child: Text('Aplicar'),
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
          );
        },
      ),
    );
  }
}
