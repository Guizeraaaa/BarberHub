import 'package:barberhub/features/home/pages/home_page.dart';
import 'package:barberhub/shared/mocks/mock_json.dart';
import 'package:flutter/material.dart';

enum UserType { client, barber }

class LoginController extends ChangeNotifier {
  final int _passwordMinimumLength = 6;
  final RegExp _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> key = GlobalKey<FormState>();

  bool get isPasswordValid =>
      passwordController.text.length >= _passwordMinimumLength;

  bool get isEmailValid => _emailRegex.hasMatch(emailController.text);

  UserType? login() {
    for (final client in mockClients) {
      if (client.email == emailController.text &&
          client.password == passwordController.text) {
        return UserType.client;
      }
    }
    for (final barber in mockBarbers) {
      if (barber.email == emailController.text &&
          barber.password == passwordController.text) {
        return UserType.barber;
      }
    }
    return null;
  }

  void loginButtonPressed(BuildContext context) {
    if (key.currentState!.validate()) {
      final userType = login();
      if (userType == UserType.client) {
        Navigator.pushNamed(context, HomePage.route);
        print('vai pra home page');
      } else if (userType == UserType.barber) {
        // Navigator.pushNamed(context, '/dashboard');
        print('vai pra dashboard page');
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('E-mail ou senha incorretos')));
      }
    }
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
