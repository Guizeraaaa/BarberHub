import 'package:barberhub/features/barber_list/controllers/barber_list_controller.dart';
import 'package:barberhub/features/barber_list/pages/barber_detail_page.dart';
import 'package:barberhub/shared/app_colors.dart';
import 'package:barberhub/shared/app_text_style.dart';
import 'package:barberhub/shared/models/barber.dart';
import 'package:barberhub/shared/widgets/app_list_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BarberListPage extends StatefulWidget {
  const BarberListPage({super.key});

  static String route = '/barber-list-page';

  @override
  State<BarberListPage> createState() => _BarberListPageState();
}

class _BarberListPageState extends State<BarberListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<BarberListController>().getBarbers();
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
          body: Column(
            children: [
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: barberListController.barbersList.length,
                  itemBuilder: (context, index) {
                    Barber barber = barberListController.barbersList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: AppListCard(
                        title: barber.name,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            BarberDetailPage.route,
                            arguments: barber,
                          );
                        },
                        professional: true,
                        isList: true,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
