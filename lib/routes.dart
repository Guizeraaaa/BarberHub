import 'package:barberhub/features/login/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:barberhub/features/scheduling/pages/scheduling_page.dart';

class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {
    LoginPage.route: (context) => LoginPage(),
    SchedulingPage.route: (context) => const SchedulingPage(),
  };
}
