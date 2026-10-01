import 'package:barberhub/shared/app_colors.dart';
import 'package:barberhub/shared/app_text_style.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static String route = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.white),
        backgroundColor: AppColors.black,
        centerTitle: true,
        title: Text(
          'Home',
          style: AppTextStyle.tittle.copyWith(color: AppColors.white),
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  DrawerHeader(
                    child: Text('BarberHub', style: AppTextStyle.tittle),
                  ),
                  ListTile(
                    leading: Icon(Icons.cut, color: AppColors.orangeDark),
                    title: Text(
                      'Serviços',
                      style: TextStyle(color: AppColors.black),
                    ),
                    onTap: () {
                      // Navigator.pushNamed(context, '/serviços');
                    },
                  ),

                  ListTile(
                    leading: Icon(Icons.person, color: AppColors.orangeDark),
                    title: Text(
                      'Perfil',
                      style: TextStyle(color: AppColors.black),
                    ),
                    onTap: () {
                      // Navigator.pushNamed(context, '/perfil');
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.calendar_month,
                      color: AppColors.orangeDark,
                    ),
                    title: Text(
                      'Agendamentos',
                      style: TextStyle(color: AppColors.black),
                    ),
                    onTap: () {
                      // Navigator.pushNamed(context, '/agendamentos');
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.question_mark,
                      color: AppColors.orangeDark,
                    ),
                    title: Text(
                      'Quem somos?',
                      style: TextStyle(color: AppColors.black),
                    ),
                    onTap: () {
                      // Navigator.pushNamed(context, '/sobre');
                    },
                  ),

                  ListTile(
                    leading: Icon(
                      Icons.location_on,
                      color: AppColors.orangeDark,
                    ),
                    title: Text(
                      'Localização',
                      style: TextStyle(color: AppColors.black),
                    ),
                    onTap: () {
                      // Navigator.pushNamed(context, '/loc');
                    },
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  print('log-out');
                },
                child: Text('Sair', style: TextStyle(color: AppColors.red)),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Image(
                image: AssetImage('assets/images/barberhub.jpg'),
                height: 300,
              ),
              SizedBox(height: 30),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 60,
                                height: 75,
                                child: GestureDetector(
                                  onTap: () {
                                    // Navigator.pushNamed(context, '/agendar');
                                    print('cliquei');
                                  },
                                  child: Image.asset(
                                    'assets/images/agendar.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  'Agendar',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle.bodyHome,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(width: 105),

                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 75,
                                height: 75,
                                child: GestureDetector(
                                  onTap: () {
                                    print('cliquei');
                                    // Navigator.pushNamed(context, '/localizacao');
                                  },
                                  child: Image.asset(
                                    'assets/images/localizacao.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  'Localização',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle.bodyHome,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 105),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 60,
                                height: 75,
                                child: GestureDetector(
                                  onTap: () {
                                    print('cliquei');
                                    // Navigator.pushNamed(context, '/servicos');
                                  },
                                  child: Image.asset(
                                    'assets/images/servicos.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  'Serviços',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle.bodyHome,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(width: 105),

                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 60,
                                height: 75,
                                child: GestureDetector(
                                  onTap: () {
                                    print('cliquei');
                                    // Navigator.pushNamed(context, '/profissionais');
                                  },
                                  child: Image.asset(
                                    'assets/images/profissionais.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  'Profissionais',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle.bodyHome,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
