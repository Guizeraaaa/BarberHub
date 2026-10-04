import 'package:barberhub/features/home/pages/home_page.dart';
import 'package:barberhub/shared/mocks/mock_json.dart';
import 'package:barberhub/shared/models/barber.dart';
import 'package:barberhub/shared/models/client.dart';
import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {
  final int _passwordMinimumLength = 6;
  final RegExp _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> key = GlobalKey<FormState>();

  Client? currentClient;
  Barber? currentBarber;

  bool get isBarber => currentBarber != null;

  bool get isPasswordValid =>
      passwordController.text.length >= _passwordMinimumLength;

  bool get isEmailValid => _emailRegex.hasMatch(emailController.text);

  bool login() {
    currentClient = null;
    currentBarber = null;

    for (final client in mockClients) {
      if (client.email == emailController.text &&
          client.password == passwordController.text) {
        currentClient = client;
        return true;
      }
    }
    for (final barber in mockBarbers) {
      if (barber.email == emailController.text &&
          barber.password == passwordController.text) {
        currentBarber = barber;
        return true;
      }
    }
    return false;
  }

  void loginButtonPressed(BuildContext context) {
    if (key.currentState!.validate()) {
      if (login()) {
        Navigator.pushReplacementNamed(context, HomePage.route);
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('E-mail ou senha incorretos')));
      }
    }
  }

  void logout() {
    currentClient = null;
    currentBarber = null;
    emailController.clear();
    passwordController.clear();
  }

  String? validateEmail(String? value) {
    if (isEmailValid) {
      return null;
    }
    return 'Email inválido';
  }

  String? validateSenha(String? value) {
    if (isPasswordValid) {
      return null;
    }
    return 'Senha invalida';
  }
}
