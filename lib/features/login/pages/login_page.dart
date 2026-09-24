import 'package:barberhub/features/login/controllers/login_controller.dart';
import 'package:barberhub/shared/app_colors.dart';
import 'package:barberhub/shared/app_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static String route = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            print('uWu');
            // pensar se vale a pena deixar um menu hamburguer na tela de login
          },
          icon: Icon(Icons.menu, color: AppColors.white),
        ),
        backgroundColor: AppColors.black,
        centerTitle: true,
        title: Text(
          'Login',
          style: TextStyle(color: AppColors.white, fontSize: 24),
        ),
      ),
      body: Consumer<LoginController>(
        builder: (context, loginController, child) {
          return Form(
            key: loginController.key,
            child: SafeArea(
              child: SizedBox(
                height:
                    MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Spacer(),
                      Image(
                        image: AssetImage('assets/images/barberhub.jpg'),
                        height: 300,
                      ),
                      SizedBox(height: 15),

                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: AppTextField(
                          controller: loginController.emailController,
                          labelText: 'email@dominio.com',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: AppTextField(
                          controller: loginController.passwordController,
                          labelText: '****************',
                          obscureText: true,
                        ),
                      ),
                      Align(
                        alignment: AlignmentGeometry.centerEnd,
                        child: TextButton(
                          onPressed: () {
                            print('abrir dialog de recover');
                          },
                          child: Text(
                            'Esqueceu a senha?',
                            style: TextStyle(color: AppColors.orangeDark),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.orangeLigth,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          onPressed: () {
                            // vai pra home page
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(color: AppColors.orangeDark),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.black,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: AppColors.orangeLigth),
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          onPressed: () {
                            // vai pra signUp page
                          },
                          child: Text(
                            'Cadastrar',
                            style: TextStyle(color: AppColors.orangeLigth),
                          ),
                        ),
                      ),

                      Spacer(flex: 2),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Termos de Serviço ',
                              style: TextStyle(color: AppColors.orangeDark),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  print('cliquei');
                                },
                            ),
                            TextSpan(
                              text: ' e ',
                              style: TextStyle(color: AppColors.orangeDark),
                            ),

                            TextSpan(
                              text: ' Politicas de Privacidade',
                              style: TextStyle(color: AppColors.orangeDark),
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
              ),
            ),
          );
        },
      ),
    );
  }
}
