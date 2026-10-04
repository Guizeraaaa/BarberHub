import 'package:barberhub/features/login/controllers/login_controller.dart';
import 'package:barberhub/features/service_list/controllers/service_list_controller.dart';
import 'package:barberhub/features/service_list/pages/service_detail_page.dart';
import 'package:barberhub/features/service_list/pages/service_form_page.dart';
import 'package:barberhub/shared/app_colors.dart';
import 'package:barberhub/shared/app_text_style.dart';
import 'package:barberhub/shared/models/service.dart';
import 'package:barberhub/shared/utils.dart';
import 'package:barberhub/shared/widgets/app_list_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServiceListPage extends StatelessWidget {
  const ServiceListPage({super.key});

  static String route = '/service-list-page';

  @override
  Widget build(BuildContext context) {
    final isBarber = context.watch<LoginController>().isBarber;

    return Consumer<ServiceListController>(
      builder: (context, serviceListController, child) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            iconTheme: IconThemeData(color: AppColors.white),
            title: Text(
              'SERVIÇOS',
              style: AppTextStyle.tittle.copyWith(color: AppColors.white),
            ),
            centerTitle: true,
            backgroundColor: AppColors.black,
          ),
          floatingActionButton: isBarber
              ? FloatingActionButton(
                  backgroundColor: AppColors.orangeLigth,
                  foregroundColor: AppColors.white,
                  tooltip: 'Adicionar serviço',
                  onPressed: () {
                    Navigator.pushNamed(context, ServiceFormPage.route);
                  },
                  child: const Icon(Icons.add),
                )
              : null,
          body: ListView.builder(
            padding: const EdgeInsets.only(top: 10, bottom: 90),
            itemCount: serviceListController.servicesList.length,
            itemBuilder: (context, index) {
              Service service = serviceListController.servicesList[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                child: AppListCard(
                  title: service.name,
                  subtitle:
                      '${Utils.formatCurrency(service.price)} - '
                      '${Utils.durationFormat(service.durationMinutes)}',
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      ServiceDetailPage.route,
                      arguments: service,
                    );
                  },
                  isList: true,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
