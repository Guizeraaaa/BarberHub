import 'package:barberhub/features/login/controllers/login_controller.dart';
import 'package:barberhub/shared/app_colors.dart';
import 'package:barberhub/shared/app_text_style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static String route = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login', style: AppTextStyle.tittle),
        backgroundColor: AppColors.black,
      ),
      body: Consumer<LoginController>(
        builder: (context, loginController, child) {
          return Form(
            key: loginController.key,
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: loginController.emailController,

                      decoration: InputDecoration(
                        labelText: 'email@dominio.com',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: loginController.passwordController,
                      obscureText: true,

                      decoration: InputDecoration(
                        labelText: '****************',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onPressed: () {
                        // vai pra home page
                      },
                      child: Text('Login'),
                    ),
                  ),
                  Spacer(flex: 2),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Termos de Serviço ',
                          style: TextStyle(color: Colors.black),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print('cliquei');
                            },
                        ),
                        TextSpan(
                          text: ' e ',
                          style: TextStyle(color: Colors.black),
                        ),

                        TextSpan(
                          text: ' Politicas de Privacidade',
                          style: TextStyle(color: Colors.black),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print('cliquei');
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
