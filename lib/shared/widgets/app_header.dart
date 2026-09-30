import 'package:barberhub/shared/app_colors.dart';
import 'package:barberhub/shared/app_text_style.dart';
import 'package:flutter/material.dart';

enum HeaderLeading { menu, back }

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppHeader({
    super.key,
    required this.title,
    this.leading = HeaderLeading.menu,
    this.showBell = true,
    this.onLeadingTap,
    this.onBellTap,
  });

  final String title;
  final HeaderLeading leading;
  final bool showBell;
  final VoidCallback? onLeadingTap;
  final VoidCallback? onBellTap;

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    final isMenu = leading == HeaderLeading.menu;

    return AppBar(
      backgroundColor: AppColors.black,
      foregroundColor: AppColors.white,
      toolbarHeight: 64,
      centerTitle: true,
      title: Text(
        title.toUpperCase(),
        style: AppTextStyle.tittle.copyWith(color: AppColors.white),
      ),
      leading: IconButton(
        icon: Icon(isMenu ? Icons.menu : Icons.arrow_back),
        tooltip: isMenu ? 'Abrir menu' : 'Voltar',
        onPressed:
            onLeadingTap ??
            () {
              if (isMenu) {
                Scaffold.maybeOf(context)?.openDrawer();
              } else {
                Navigator.pop(context);
              }
            },
      ),

      actions: [
        if (showBell)
          IconButton(
            icon: const Icon(Icons.notifications_none),
            tooltip: 'Notificações',
            onPressed: onBellTap,
          ),
      ],
    );
  }
}
