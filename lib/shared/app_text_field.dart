import 'package:barberhub/shared/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;

  const AppTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.obscureText = false,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool isObscure;

  void initState() {
    super.initState();
    isObscure = widget.obscureText;
  }

  void toggleObscure() {
    setState(() {
      isObscure = !isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.orangeDark,
      controller: widget.controller,
      obscureText: isObscure,
      style: TextStyle(color: AppColors.white),
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: TextStyle(color: AppColors.orangeDark),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: AppColors.orangeDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: AppColors.orangeDark),
        ),
        suffixIcon: widget.obscureText
            ? IconButton(
                onPressed: toggleObscure,
                icon: Icon(
                  isObscure ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.orangeDark,
                ),
              )
            : null,
      ),
    );
  }
}
