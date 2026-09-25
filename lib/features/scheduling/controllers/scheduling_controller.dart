import 'package:flutter/material.dart';

const Color black = Color(0xFF0E0E0E);
const Color white = Color(0xFFFFFFFF);
const Color background = Color(0xFFF4F4F2);
const Color orange = Color(0xFFB4530F);
const Color grey = Color(0xFF898989);

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  static String route = '/schedule';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: black,
        foregroundColor: white,
        toolbarHeight: 64,
        centerTitle: true,
        title: Text(
          'AGENDAR',
          style: TextStyle(
            fontFamily: 'Barlow',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications_none)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                buildChoiceCard(
                  initial: 'C',
                  title: 'Corte',
                  subtitle: 'R\$ 45,00 - 30 min',
                ),
                SizedBox(height: 10),
                buildChoiceCard(
                  initial: 'C',
                  title: 'Carlos Mendes',
                  subtitle: 'Barbeiro',
                ),
                SizedBox(height: 16),
                buildDateAndTimeBox(),
              ],
            ),
          ),
          buildFooter(),
        ],
      ),
    );
  }

  Widget buildChoiceCard({
    required String initial,
    required String title,
    required String subtitle,
  }) {
    return Container(
      height: 80,
      padding: EdgeInsets.only(left: 16, right: 8),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: Color(0xFFD6D6D2),
            child: Text(initial, style: TextStyle(fontSize: 22, color: black)),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Barlow',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: orange,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontFamily: 'Barlow',
                    fontSize: 14,
                    color: grey,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              'Alterar',
              style: TextStyle(
                fontFamily: 'Barlow',
                fontWeight: FontWeight.bold,
                color: orange,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDateAndTimeBox() {
    List<String> slots = ['09:00', '09:30', '10:00', '10:30', '11:00', '14:00'];

    return Container(
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(
            height: 56,
            color: black,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(Icons.calendar_month, color: white),
                SizedBox(width: 12),
                Text(
                  'Selecione uma data e horário',
                  style: TextStyle(
                    fontFamily: 'Barlow',
                    fontSize: 18,
                    color: white,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'quinta, 24 setembro',
                  style: TextStyle(
                    fontFamily: 'Barlow',
                    fontSize: 18,
                    color: black,
                  ),
                ),
                Icon(Icons.arrow_drop_down, color: black),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 4, 16, 16),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (String slot in slots) buildSlot(slot, slot == '10:00'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSlot(String time, bool selected) {
    return SizedBox(
      width: 72,
      height: 44,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: selected ? black : white,
          foregroundColor: selected ? white : black,
          side: BorderSide(color: selected ? black : grey),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: Text(
          time,
          style: TextStyle(fontFamily: 'Barlow', fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildFooter() {
    return Container(
      color: white,
      padding: EdgeInsets.all(16),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('A partir de', style: TextStyle(color: grey)),
                Text(
                  'R\$ 45,00',
                  style: TextStyle(
                    fontFamily: 'Barlow',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('30 minutos', style: TextStyle(color: grey)),
              ],
            ),
            SizedBox(width: 16),
            Expanded(
              child: SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: black,
                    foregroundColor: white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Text(
                    'CONFIRMAR',
                    style: TextStyle(
                      fontFamily: 'Barlow',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
