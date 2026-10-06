import 'package:barberhub/features/login/controllers/login_controller.dart';
import 'package:barberhub/features/service_list/controllers/service_list_controller.dart';
import 'package:barberhub/shared/app_colors.dart';
import 'package:barberhub/shared/app_text_field.dart';
import 'package:barberhub/shared/app_text_style.dart';
import 'package:barberhub/shared/utils.dart';
import 'package:barberhub/shared/widgets/app_elevated_button.dart';
import 'package:barberhub/shared/widgets/app_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServiceFormPage extends StatefulWidget {
  const ServiceFormPage({super.key});

  static String route = '/service-form-page';

  @override
  State<ServiceFormPage> createState() => _ServiceFormPageState();
}

class _ServiceFormPageState extends State<ServiceFormPage> {
  @override
  void initState() {
    super.initState();
    context.read<ServiceListController>().startNewService(
      context.read<LoginController>().currentBarber,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(
        title: 'Novo serviço',
        leading: HeaderLeading.back,
        showBell: false,
      ),
      body: Consumer<ServiceListController>(
        builder: (context, serviceListController, child) {
          return Form(
            key: serviceListController.formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _label('NOME'),
                AppTextField(
                  controller: serviceListController.nameController,
                  labelText: 'Ex: Corte degradê',
                  textColor: AppColors.black,
                  validator: serviceListController.validateName,
                ),
                const SizedBox(height: 20),
                _label('VALOR (R\$)'),
                AppTextField(
                  controller: serviceListController.priceController,
                  labelText: 'Ex: 45,00',
                  textColor: AppColors.black,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  validator: serviceListController.validatePrice,
                ),
                const SizedBox(height: 20),
                _label('DURAÇÃO'),
                DropdownButtonFormField<int>(
                  initialValue: serviceListController.selectedDuration,
                  hint: Text(
                    'Escolha a duração',
                    style: TextStyle(color: AppColors.grey),
                  ),
                  dropdownColor: AppColors.white,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: AppColors.orangeDark),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: AppColors.orangeDark),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: AppColors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: AppColors.red),
                    ),
                  ),
                  items: serviceListController.durationOptions.map((minutes) {
                    return DropdownMenuItem(
                      value: minutes,
                      child: Text(
                        Utils.durationFormat(minutes),
                        style: TextStyle(color: AppColors.black),
                      ),
                    );
                  }).toList(),
                  onChanged: serviceListController.selectDuration,
                  validator: serviceListController.validateDuration,
                ),
                const SizedBox(height: 20),
                _label('QUEM FAZ ESSE SERVIÇO'),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: serviceListController.barbersList.map((barber) {
                    return FilterChip(
                      label: Text(
                        barber.name,
                        style: TextStyle(color: AppColors.black),
                      ),
                      backgroundColor: AppColors.white,
                      selected: serviceListController.selectedBarbers.contains(
                        barber,
                      ),
                      selectedColor: AppColors.orangeLigth.withValues(
                        alpha: 0.4,
                      ),
                      checkmarkColor: AppColors.orangeDark,
                      onSelected: (selected) {
                        serviceListController.toggleBarber(barber);
                      },
                    );
                  }).toList(),
                ),
                if (serviceListController.showBarberError)
                  Padding(
                    padding: const EdgeInsets.only(top: 6, left: 12),
                    child: Text(
                      'Escolha pelo menos um barbeiro',
                      style: AppTextStyle.body.copyWith(color: AppColors.red),
                    ),
                  ),
                const SizedBox(height: 32),
                AppElevatedButton(
                  textButton: 'Salvar serviço',
                  type: ButtonType.filled,
                  onPressed: () {
                    final saved = serviceListController.saveService();
                    if (saved) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Serviço adicionado!')),
                      );
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, left: 4),
      child: Text(
        text,
        style: AppTextStyle.subTittle.copyWith(color: AppColors.grey),
      ),
    );
  }
}
