import 'package:barberhub/features/barber_list/controllers/barber_list_controller.dart';
import 'package:barberhub/shared/app_colors.dart';
import 'package:barberhub/shared/app_text_style.dart';
import 'package:barberhub/shared/models/barber.dart';
import 'package:barberhub/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BarberDetailPage extends StatelessWidget {
  const BarberDetailPage({super.key, required this.barber});

  static String route = '/barber-detail-page';
  final Barber barber;

  @override
  Widget build(BuildContext context) {
    return Consumer<BarberListController>(
      builder: (context, serviceListController, child) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            iconTheme: IconThemeData(color: AppColors.white),
            title: Text(
              'PROFISSIONAIS',
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
                  color: AppColors.grey,
                  borderRadius: BorderRadius.circular(150),
                ),
                child: Icon(
                  Icons.account_circle_outlined,
                  size: 200,
                  color: AppColors.greyLight,
                ),
              ),
              Column(
                children: [
                  Text(
                    barber.name.toUpperCase(),
                    style: AppTextStyle.tittle.copyWith(
                      fontSize: 40,
                      color: AppColors.orangeDark,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'ESPECIALIDADES',
                    style: AppTextStyle.tittle.copyWith(
                      fontWeight: FontWeight.normal,
                      color: AppColors.orangeLigth,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    width: 10,
                    height: 20,
                    decoration: BoxDecoration(color: AppColors.black),
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
