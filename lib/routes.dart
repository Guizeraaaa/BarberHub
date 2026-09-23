import 'package:barberhub/features/login/pages/login_page.dart';
import 'package:barberhub/features/appointment/pages/appointment_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {
    LoginPage.route: (context) => LoginPage(),
    AppointmentPage.route: (context) => AppointmentPage(),
  };
}
