import 'package:barberhub/features/appointment/controllers/appointment_controller.dart';
import 'package:barberhub/features/barber_list/controllers/barber_list_controller.dart';
import 'package:barberhub/features/login/controllers/login_controller.dart';
import 'package:barberhub/features/login/pages/login_page.dart';
import 'package:barberhub/features/scheduling/controllers/scheduling_controller.dart';
import 'package:barberhub/features/service_list/controllers/service_list_controller.dart';
import 'package:barberhub/features/theme/app_theme.dart';
import 'package:barberhub/features/theme/theme_controller.dart';
import 'package:barberhub/routes.dart';
import 'package:barberhub/shared/controllers/appointment_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR');
  Intl.defaultLocale = 'pt_BR';
  await WakelockPlus.enable();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return LoginController();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return AppointmentListController();
          },
        ),
        // Precisa vir depois do AppointmentListController para conseguir lê-lo.
        ChangeNotifierProvider(
          create: (context) {
            return AppointmentController(
              context.read<AppointmentListController>(),
            );
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return SchedulingController(
              context.read<AppointmentListController>(),
            );
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return ServiceListController();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return BarberListController();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return ThemeController();
          },
        ),
      ],
      builder: (context, child) {
        final themeController = context.watch<ThemeController>();

        return MaterialApp(
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeController.darkMode
              ? ThemeMode.dark
              : ThemeMode.light,
          routes: AppRoutes.routes,
          initialRoute: LoginPage.route,
          locale: const Locale('pt', 'BR'),
          supportedLocales: const [Locale('pt', 'BR')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        );
      },
    );
  }
}