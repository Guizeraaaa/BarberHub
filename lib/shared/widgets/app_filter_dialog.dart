import 'package:barberhub/shared/app_colors.dart';
import 'package:barberhub/shared/app_text_style.dart';
import 'package:barberhub/shared/models/Appointment.dart';
import 'package:barberhub/shared/models/barber.dart';
import 'package:barberhub/shared/utils.dart';
import 'package:barberhub/shared/widgets/app_dropdown_button_form_field.dart';
import 'package:barberhub/shared/widgets/app_filter_chip_status.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  });

  final List<AppointmentStatus> selectedStatusList;
  final List<Barber> professionalsList;

  final Function(AppointmentStatus value) onChipChanged;
  final Function(String?) changeSelectedProfessional;
  final VoidCallback updateFilters;
  final VoidCallback clearFilters;

  final String selectedProfessional;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(20),
      child: Consumer<T>(
        builder: (context, controller, child) {
          return Container(
            width: double.infinity,
            height: 500,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'FILTRAR',
                          style: AppTextStyle.tittle.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            clearFilters();
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
                            'STATUS',
                            style: AppTextStyle.subTittle.copyWith(
                              color: AppColors.grey,
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: AppointmentStatus.values.length,
                              itemBuilder: (context, index) => Padding(
                                padding: EdgeInsets.only(
                                  right:
                                      index ==
                                          AppointmentStatus.values.length - 1
                                      ? 0
                                      : 10,
                                ),
                                child: AppFilterChipStatus(
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
                            selectedItem: selectedProfessional,
                            items: professionalsList,
                            onChanged: (value) {
                              changeSelectedProfessional(value);
                            },
                          ),
                        ],
                      ),

                      ElevatedButton(
                        style: ButtonStyle(),
                        onPressed: () {
                          updateFilters();
                          Navigator.pop(context);
                        },
                        child: Text('Aplicar Filtros'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
