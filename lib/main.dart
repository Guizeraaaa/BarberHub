import 'package:barberhub/features/login/controllers/login_controller.dart';
import 'package:barberhub/features/appointment/controllers/appointment_controller.dart';
import 'package:barberhub/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:barberhub/features/login/pages/login_page.dart';
import 'package:barberhub/features/scheduling/controllers/scheduling_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
            return SchedulingController();
          },
        ),
      ],
      builder: (context, child) {
        return MaterialApp(
          routes: AppRoutes.routes,
          initialRoute: LoginPage.route,
        );
      },
    );
  }
}
