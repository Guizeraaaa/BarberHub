import 'package:barberhub/shared/mocks/mock.dart';
import 'package:barberhub/shared/models/barber.dart';
import 'package:barberhub/shared/models/service.dart';
import 'package:flutter/material.dart';

class BarberListController extends ChangeNotifier {
  List<Barber> barbersList = [];
  List<Service> serviceList = [];

  void getBarbers() {
    barbersList = mockBarbers;
    notifyListeners();
  }

  void getServicesFromBarber(Barber barber) {
    serviceList = barber.offeredService;
    notifyListeners();
  }
}
