import 'package:barberhub/features/appointment/pages/appointment_page.dart';
import 'package:barberhub/features/barber_list/pages/barber_list_page.dart';
import 'package:barberhub/features/login/pages/login_page.dart';
import 'package:barberhub/features/scheduling/pages/scheduling_page.dart';
import 'package:barberhub/features/service_list/pages/service_list_page.dart';
import 'package:barberhub/features/theme/theme_controller.dart';
import 'package:barberhub/shared/app_colors.dart';
import 'package:barberhub/shared/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Home')),
      drawer: Drawer(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  DrawerHeader(
                    child: Text(
                      'BarberHub',
                      style: AppTextStyle.bodyHome,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.dark_mode),
                    title: Text('Modo escuro'),
                    trailing: Switch(
                      value: themeController.darkMode,
                      onChanged: (value) {
                        themeController.toggleTheme();
                      },
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.cut),
                    title: Text('Serviços'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, ServiceListPage.route);
                    },
                  ),

                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Perfil'),
                    onTap: () {
                      // Navigator.pushNamed(context, '/perfil');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.calendar_month),
                    title: Text('Agendamentos'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, AppointmentPage.route);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.question_mark),
                    title: Text('Quem somos?'),
                    onTap: () {
                      // Navigator.pushNamed(context, '/sobre');
                    },
                  ),

                  ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text('Localização'),
                    onTap: () {
                      // Navigator.pushNamed(context, '/loc');
                    },
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    LoginPage.route,
                    (route) => false,
                  );
                },
                child: Text('Sair', style: TextStyle(color: AppColors.red)),
              ),
            ),
          ],
        ),
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
                                      SchedulingPage.route,
                                    );
                                  },
                                  child: Icon(Icons.calendar_month, size: 50),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  'Agendar',
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
                                  // Image.asset(
                                  //   'assets/images/localizacao.png',
                                  //   fit: BoxFit.contain,
                                  // ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  'Compromissos',
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
