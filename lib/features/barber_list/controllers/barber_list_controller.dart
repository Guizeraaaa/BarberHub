import 'package:barberhub/shared/mocks/mock_json.dart';
import 'package:barberhub/shared/models/barber.dart';
import 'package:flutter/material.dart';

class BarberListController extends ChangeNotifier {
  List<Barber> barbersList = [];

  void getBarbers() {
    barbersList = mockBarbers;
    notifyListeners();
  }
}
