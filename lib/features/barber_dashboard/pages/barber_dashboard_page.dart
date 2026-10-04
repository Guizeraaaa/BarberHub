import 'package:barberhub/features/barber_dashboard/controllers/barber_dashboard_controller.dart';
import 'package:barberhub/features/barber_dashboard/widgets/dashboard_stat_card.dart';
import 'package:barberhub/features/barber_dashboard/widgets/service_bar_chart.dart';
import 'package:barberhub/features/barber_dashboard/widgets/status_pie_chart.dart';
import 'package:barberhub/shared/app_colors.dart';
import 'package:barberhub/shared/app_text_style.dart';
import 'package:barberhub/shared/models/appointment.dart';
import 'package:barberhub/shared/utils.dart';
import 'package:barberhub/shared/widgets/app_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BarberDashboardPage extends StatelessWidget {
  const BarberDashboardPage({super.key});

  static String route = '/barber-dashboard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(
        title: 'Painel',
        leading: HeaderLeading.back,
        showBell: false,
      ),
      body: Consumer<BarberDashboardController>(
        builder: (context, dashboardController, child) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                'Olá, ${dashboardController.barberName}',
                style: AppTextStyle.tittle.copyWith(color: AppColors.black),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: DashboardStatCard(
                      icon: Icons.today,
                      label: 'Agendados hoje',
                      value: '${dashboardController.todayCount}',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DashboardStatCard(
                      icon: Icons.attach_money,
                      label: 'Faturado no mês',
                      value: Utils.formatCurrency(
                        dashboardController.monthRevenue,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _sectionTitle('ATENDIMENTOS POR STATUS'),
              StatusPieChart(
                scheduled: dashboardController.countByStatus(
                  AppointmentStatus.agendado,
                ),
                completed: dashboardController.countByStatus(
                  AppointmentStatus.concluido,
                ),
                canceled: dashboardController.countByStatus(
                  AppointmentStatus.cancelado,
                ),
              ),
              const SizedBox(height: 24),
              _sectionTitle('ATENDIMENTOS POR SERVIÇO'),
              ServiceBarChart(
                countByService: dashboardController.countByService,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: AppTextStyle.subTittle.copyWith(color: AppColors.grey),
      ),
    );
  }
}
