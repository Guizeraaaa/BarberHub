import 'package:barberhub/shared/app_colors.dart';
import 'package:barberhub/shared/app_text_style.dart';
import 'package:barberhub/shared/models/barber.dart';
import 'package:flutter/material.dart';

class AppDropdownButtonFormField extends StatelessWidget {
  const AppDropdownButtonFormField({
    super.key,
    required this.selectedItem,
    required this.items,
    required this.onChanged,
  });

  final String selectedItem;
  final List<Barber> items;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      icon: Icon((Icons.keyboard_arrow_down)),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.greyLight),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.greyLight),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.black, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      initialValue: selectedItem,
      items: [
        DropdownMenuItem(
          value: '',
          child: Text(
            'Todos',
            style: AppTextStyle.subTittle.copyWith(
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        ...items.map(
          (item) => DropdownMenuItem(
            value: item.name,
            child: Text(
              item.name,
              style: AppTextStyle.subTittle.copyWith(
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
      ],
      onChanged: onChanged,
    );
  }
}
