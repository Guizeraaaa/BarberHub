import 'package:barberhub/shared/mocks/mock_json.dart';
import 'package:barberhub/shared/models/service.dart';
import 'package:flutter/material.dart';

class ServiceListController extends ChangeNotifier {
  List<Service> servicesList = [];

  void getServices() {
    servicesList = mockServices;
    notifyListeners();
  }
}
