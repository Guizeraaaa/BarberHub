import 'package:barberhub/shared/app_colors.dart';
import 'package:barberhub/shared/app_text_style.dart';
import 'package:barberhub/shared/widgets/avatar_card.dart';
import 'package:flutter/material.dart';

// Dialog genérico para escolher um item de uma lista (serviço, profissional...).
class AppSelectDialog<T> extends StatelessWidget {
  const AppSelectDialog({
    super.key,
    required this.title,
    required this.items,
    required this.selectedItem,
    required this.nameOf,
    required this.subtitleOf,
    required this.onSelected,
  });

  final String title;
  final List<T> items;
  final T? selectedItem;
  final String Function(T) nameOf;
  final String Function(T) subtitleOf;
  final Function(T value) onSelected;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(20),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: AppColors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            height: 60,
            color: AppColors.black,
            padding: const EdgeInsets.only(left: 20, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title.toUpperCase(),
                  style: AppTextStyle.tittle.copyWith(color: AppColors.white),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close, color: AppColors.white, size: 30),
                ),
              ],
            ),
          ),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final isSelected = item == selectedItem;

                return ListTile(
                  leading: AppAvatar(size: 44, initial: nameOf(item)[0]),
                  title: Text(
                    nameOf(item),
                    style: AppTextStyle.subTittle.copyWith(
                      color: isSelected
                          ? AppColors.orangeDark
                          : AppColors.black,
                    ),
                  ),
                  subtitle: Text(
                    subtitleOf(item),
                    style: AppTextStyle.body.copyWith(
                      fontSize: 14,
                      color: AppColors.grey,
                    ),
                  ),
                  trailing: isSelected
                      ? Icon(Icons.check, color: AppColors.orangeDark)
                      : null,
                  onTap: () {
                    onSelected(item);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
