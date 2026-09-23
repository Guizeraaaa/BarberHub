import 'package:barberhub/shared/mocks/mock_json.dart';
// import 'package:barberhub/shared/models/User.dart';
// import 'package:barberhub/shared/models/client.dart';
import 'package:flutter/material.dart';

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
    final email = emailController.text;
    final password = passwordController.text;

    final client = mockClients.firstWhere(
      (user) => user.email == email && user.password == password,
    );
    if (mockClients.isNotEmpty) {
      return UserType.client;
    }

    final barber = mockBarbers.firstWhere(
      (user) => user.email == email && user.password == password,
    );
    if (mockBarbers.isNotEmpty) {
      return UserType.barber;
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

enum UserType { client, barber }
