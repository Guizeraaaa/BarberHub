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
        backgroundColor: AppColors.black,
        centerTitle: true,
        title: Text(
          'Home',
          style: AppTextStyle.tittle.copyWith(color: AppColors.white),
        ),
      ),
      body: SafeArea(
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
                Image(
                  image: AssetImage('assets/images/barberhub.jpg'),
                  height: 350,
                ),
                SizedBox(height: 45),

                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 70,
                            height: 70,
                            child: GestureDetector(
                              onTap: () {},
                              child: Image.asset(
                                'assets/images/agendar.jpeg',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),

                          const SizedBox(width: 105),

                          SizedBox(
                            width: 95,
                            height: 95,
                            child: GestureDetector(
                              onTap: () {},
                              child: Image.asset(
                                'assets/images/localizacao.jpeg',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 105),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 95,
                            height: 95,
                            child: GestureDetector(
                              onTap: () {},
                              child: Image.asset(
                                'assets/images/servicos.jpeg',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),

                          const SizedBox(width: 105),

                          SizedBox(
                            width: 95,
                            height: 95,
                            child: GestureDetector(
                              onTap: () {},
                              child: Image.asset(
                                'assets/images/profissionais.jpeg',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
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
  }
}
