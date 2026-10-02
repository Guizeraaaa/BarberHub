import 'package:barberhub/features/service_list/controllers/service_list_controller.dart';
import 'package:barberhub/features/service_list/pages/service_detail_page.dart';
import 'package:barberhub/shared/app_colors.dart';
import 'package:barberhub/shared/app_text_style.dart';
import 'package:barberhub/shared/models/service.dart';
import 'package:barberhub/shared/widgets/app_list_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServiceListPage extends StatefulWidget {
  const ServiceListPage({super.key});

  static String route = '/service-list-page';

  @override
  State<ServiceListPage> createState() => _ServiceListPageState();
}

class _ServiceListPageState extends State<ServiceListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ServiceListController>().getServices();
    });
  }

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
            children: [
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
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
              ),
            ],
          ),
        );
      },
    );
  }
}
