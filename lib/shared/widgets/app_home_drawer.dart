import 'package:barberhub/features/appointment/pages/appointment_page.dart';
import 'package:barberhub/features/barber_dashboard/pages/barber_dashboard_page.dart';
import 'package:barberhub/features/login/controllers/login_controller.dart';
import 'package:barberhub/features/login/pages/login_page.dart';
import 'package:barberhub/features/scheduling/pages/scheduling_page.dart';
import 'package:barberhub/features/service_list/pages/service_list_page.dart';
import 'package:barberhub/features/theme/theme_controller.dart';
import 'package:barberhub/shared/app_colors.dart';
import 'package:barberhub/shared/app_text_style.dart';
import 'package:barberhub/shared/widgets/app_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppHomeDrawer extends StatelessWidget {
  const AppHomeDrawer({
    super.key,
    required this.themeController,
    required this.isBarber,
  });

  final ThemeController themeController;
  final bool isBarber;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  DrawerHeader(
                    child: Text(
                      'BARBERHUB',
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
                    leading: Icon(
                      isBarber ? Icons.bar_chart : Icons.calendar_month,
                    ),
                    title: Text(isBarber ? 'Painel' : 'Agendar'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(
                        context,
                        isBarber
                            ? BarberDashboardPage.route
                            : SchedulingPage.route,
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.event_note),
                    title: Text(isBarber ? 'Atendimentos' : 'Compromissos'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, AppointmentPage.route);
                    },
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
                    title: Text('Profissionais'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, ServiceListPage.route);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.question_mark),
                    title: Text('Quem somos?'),
                    onTap: () {},
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AppConfirmationDialog(
                      title: 'Sair da Conta?',
                      content:
                          'Você deseja sair da sua conta e voltar a página de login? Essa ação não pode ser desfeita.',
                      icon: Icon(
                        Icons.logout,
                        size: 100,
                        color: AppColors.orangeLigth,
                      ),
                      labelCancel: 'Cancelar',
                      labelConfirm: 'Sair',
                    ),
                  );
                  if (confirm == true) {
                    if (!context.mounted) return;

                    context.read<LoginController>().logout();

                    if (!context.mounted) return;

                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      LoginPage.route,
                      (route) => false,
                    );
                  }
                },
                child: Text('Sair', style: TextStyle(color: AppColors.red)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
