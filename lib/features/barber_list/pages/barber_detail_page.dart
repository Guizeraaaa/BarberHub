import 'package:barberhub/features/barber_list/controllers/barber_list_controller.dart';
import 'package:barberhub/shared/app_colors.dart';
import 'package:barberhub/shared/app_text_style.dart';
import 'package:barberhub/shared/models/barber.dart';
import 'package:barberhub/shared/models/service.dart';
import 'package:barberhub/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/widgets/app_price_row.dart';

class BarberDetailPage extends StatefulWidget {
  const BarberDetailPage({super.key, required this.barber});

  static String route = '/barber-detail-page';
  final Barber barber;

  @override
  State<BarberDetailPage> createState() => _BarberDetailPageState();
}

class _BarberDetailPageState extends State<BarberDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<BarberListController>().getServicesFromBarber(widget.barber);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BarberListController>(
      builder: (context, barberListController, child) {
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
          body: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 24),
            child: Column(
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
                      widget.barber.name.toUpperCase(),
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
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: barberListController.serviceList.length,
                      itemBuilder: (context, index) {
                        Service offeredService =
                            barberListController.serviceList[index];
                        return AppPriceRow(
                          name: offeredService.name,
                          price: offeredService.price,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
