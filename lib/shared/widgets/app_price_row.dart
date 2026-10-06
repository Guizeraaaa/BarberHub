import 'package:barberhub/shared/app_colors.dart';
import 'package:barberhub/shared/app_text_style.dart';
import 'package:barberhub/shared/utils.dart';
import 'package:flutter/material.dart';

class AppPriceRow extends StatelessWidget {
  const AppPriceRow({super.key, required this.name, required this.price});

  final String name;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          border: BorderDirectional(
            bottom: BorderSide(color: AppColors.greyLight, width: 1.5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: AppTextStyle.subTittle.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
            Row(
              spacing: 10,
              children: [
                Text(
                  '//',
                  style: AppTextStyle.subTittle.copyWith(
                    color: AppColors.orangeLigth,
                  ),
                ),
                Text(
                  Utils.formatCurrency(price),
                  style: AppTextStyle.subTittle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
