import 'package:flutter/material.dart';
import 'package:barberhub/shared/widgets/app_header.dart';
import 'package:barberhub/shared/widgets/list_card.dart';

class SchedulingPage extends StatelessWidget {
  const SchedulingPage({super.key});

  static const String route = '/scheduling';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(title: 'Agendar'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListCard(
            title: 'aleatorio',
            subtitle: 'Barbeiro',
            avatar: const CircleAvatar(child: Icon(Icons.person)),
            onTap: () {
              debugPrint('Clickou');
            },
          ),
          const SizedBox(height: 16),
          ListCard(
            title: 'corte de cabelo',
            subtitle: '30 minutos',
            tone: CardTone.plain,
            avatar: const CircleAvatar(child: Icon(Icons.content_cut)),
          ),
        ],
      ),
    );
  }
}
