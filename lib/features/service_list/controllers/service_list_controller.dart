import 'package:barberhub/shared/mocks/mock.dart';
import 'package:barberhub/shared/models/barber.dart';
import 'package:barberhub/shared/models/service.dart';
import 'package:flutter/material.dart';

class ServiceListController extends ChangeNotifier {
  final List<Service> servicesList = List.of(mockServices);

  final List<Barber> barbersList = mockBarbers;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  final List<int> durationOptions = [15, 30, 45, 60, 90, 120];
  int? selectedDuration;

  List<Barber> selectedBarbers = [];
  bool showBarberError = false;

  void startNewService(Barber? loggedBarber) {
    nameController.clear();
    priceController.clear();
    selectedDuration = null;
    selectedBarbers = loggedBarber == null ? [] : [loggedBarber];
    showBarberError = false;
  }

  void selectDuration(int? minutes) {
    selectedDuration = minutes;
  }

  void toggleBarber(Barber barber) {
    if (selectedBarbers.contains(barber)) {
      selectedBarbers.remove(barber);
    } else {
      selectedBarbers.add(barber);
    }
    showBarberError = false;
    notifyListeners();
  }

  double? parsePrice(String text) {
    return double.tryParse(text.trim().replaceAll(',', '.'));
  }

  String? validateName(String? value) {
    final name = (value ?? '').trim();
    if (name.isEmpty) {
      return 'Informe o nome do serviço';
    }
    final alreadyExists = servicesList.any(
      (service) => service.name.toLowerCase() == name.toLowerCase(),
    );
    if (alreadyExists) {
      return 'Já existe um serviço com esse nome';
    }
    return null;
  }

  String? validatePrice(String? value) {
    final price = parsePrice(value ?? '');
    if (price == null || price <= 0) {
      return 'Informe um valor válido. Ex: 45,00';
    }
    return null;
  }

  String? validateDuration(int? value) {
    if (value == null) {
      return 'Escolha a duração';
    }
    return null;
  }

  bool saveService() {
    final isFormValid = formKey.currentState!.validate();

    showBarberError = selectedBarbers.isEmpty;
    notifyListeners();

    if (!isFormValid || showBarberError) {
      return false;
    }

    final service = Service(
      id: 's${DateTime.now().millisecondsSinceEpoch}',
      name: nameController.text.trim(),
      price: parsePrice(priceController.text)!,
      durationMinutes: selectedDuration!,
    );

    servicesList.add(service);

    for (final barber in selectedBarbers) {
      barber.offeredService.add(service);
    }

    notifyListeners();
    return true;
  }
}
