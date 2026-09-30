import 'package:barberhub/features/login/controllers/login_controller.dart';
import 'package:barberhub/features/appointment/controllers/appointment_controller.dart';
import 'package:barberhub/features/scheduling/controllers/scheduling_controller.dart';
import 'package:barberhub/features/scheduling/pages/scheduling_page.dart';
import 'package:barberhub/shared/controllers/appointment_list_controller.dart';
import 'package:barberhub/routes.dart';
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
            return AppointmentController();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return AppointmentListController();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return SchedulingController(
              context.read<AppointmentListController>(),
            );
          },
        ),
      ],
      builder: (context, child) {
        return MaterialApp(
          routes: AppRoutes.routes,
          initialRoute: SchedulingPage.route,
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
