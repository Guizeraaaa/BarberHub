import 'package:barberhub/features/service_list/controllers/service_list_controller.dart';
import 'package:barberhub/shared/app_colors.dart';
import 'package:barberhub/shared/app_text_style.dart';
import 'package:barberhub/shared/models/service.dart';
import 'package:barberhub/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServiceDetailPage extends StatelessWidget {
  const ServiceDetailPage({super.key, required this.service});

  static String route = '/service-detail-page';
  final Service service;

  @override
  Widget build(BuildContext context) {
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
          body: Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: double.infinity),
              Container(
                width: 250,
                height: 250,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.greyLight,
                  borderRadius: BorderRadius.circular(150),
                ),
                child: Text(
                  service.name[0],
                  style: AppTextStyle.tittle.copyWith(fontSize: 80),
                ),
              ),
              Column(
                children: [
                  Text(
                    service.name.toUpperCase(),
                    style: AppTextStyle.tittle.copyWith(
                      color: AppColors.orangeDark,
                      fontSize: 50,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'DURAÇÃO',
                    style: AppTextStyle.tittle.copyWith(
                      color: AppColors.orangeLigth,
                    ),
                  ),
                  Text(
                    Utils.durationFormat(service.durationMinutes),
                    style: AppTextStyle.subTittle.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'VALOR',
                    style: AppTextStyle.tittle.copyWith(
                      color: AppColors.orangeLigth,
                    ),
                  ),
                  Text(
                    Utils.formatCurrency(service.price),
                    style: AppTextStyle.subTittle.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
