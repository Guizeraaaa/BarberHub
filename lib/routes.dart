import 'package:barberhub/features/barber_list/pages/barber_detail_page.dart';
import 'package:barberhub/features/barber_list/pages/barber_list_page.dart';
import 'package:barberhub/features/login/pages/login_page.dart';
import 'package:barberhub/features/appointment/pages/appointment_page.dart';
import 'package:barberhub/features/service_list/pages/service_detail_page.dart';
import 'package:barberhub/features/service_list/pages/service_list_page.dart';
import 'package:barberhub/shared/models/barber.dart';
import 'package:barberhub/shared/models/service.dart';
import 'package:flutter/material.dart';
import 'package:barberhub/features/scheduling/pages/scheduling_page.dart';

class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {
    LoginPage.route: (context) => LoginPage(),
    SchedulingPage.route: (context) => const SchedulingPage(),
    AppointmentPage.route: (context) => AppointmentPage(),
    ServiceListPage.route: (context) => ServiceListPage(),
    ServiceDetailPage.route: (context) {
      final service = ModalRoute.of(context)!.settings.arguments as Service;
      return ServiceDetailPage(service: service);
    },
    BarberListPage.route: (context) => BarberListPage(),
    BarberDetailPage.route: (context) {
      final barber = ModalRoute.of(context)!.settings.arguments as Barber;
      return BarberDetailPage(barber: barber);
    },
  };
}
