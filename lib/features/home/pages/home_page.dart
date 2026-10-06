import 'package:barberhub/features/appointment/pages/appointment_page.dart';
import 'package:barberhub/features/barber_dashboard/pages/barber_dashboard_page.dart';
import 'package:barberhub/features/barber_list/pages/barber_list_page.dart';
import 'package:barberhub/features/login/controllers/login_controller.dart';
import 'package:barberhub/features/scheduling/pages/scheduling_page.dart';
import 'package:barberhub/features/service_list/pages/service_list_page.dart';
import 'package:barberhub/features/theme/theme_controller.dart';
import 'package:barberhub/shared/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/widgets/app_home_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static String route = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeController = context.watch<ThemeController>();
    final isBarber = context.watch<LoginController>().isBarber;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('BARBERHUB', style: AppTextStyle.tittle),
      ),
      drawer: AppHomeDrawer(
        themeController: themeController,
        isBarber: isBarber,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Image(
                image: AssetImage(
                  isDark
                      ? 'assets/images/barberhub_black.png'
                      : 'assets/images/barberhub_white.png',
                ),
                height: 300,
              ),
              SizedBox(height: 50),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 50,
                                height: 65,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      isBarber
                                          ? BarberDashboardPage.route
                                          : SchedulingPage.route,
                                    );
                                  },
                                  child: Icon(
                                    isBarber
                                        ? Icons.bar_chart
                                        : Icons.calendar_month,
                                    size: 50,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  isBarber ? 'Painel' : 'Agendar',
                                  style: AppTextStyle.bodyHome,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(width: 80),

                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 50,
                                height: 65,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      AppointmentPage.route,
                                    );
                                  },
                                  child: Icon(Icons.event_note, size: 50),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  isBarber ? 'Atendimentos' : 'Compromissos',
                                  style: AppTextStyle.bodyHome,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 80),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 50,
                                height: 65,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      ServiceListPage.route,
                                    );
                                  },
                                  child: Icon(Icons.cut, size: 50),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  'Serviços',
                                  style: AppTextStyle.bodyHome,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(width: 80),

                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 50,
                                height: 65,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      BarberListPage.route,
                                    );
                                  },
                                  child: Icon(Icons.person_sharp, size: 50),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  'Profissionais',
                                  style: AppTextStyle.bodyHome,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
