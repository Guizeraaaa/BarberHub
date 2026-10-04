import 'package:barberhub/shared/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;

  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Color? textColor;

  const AppTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.obscureText = false,
    this.validator,
    this.keyboardType,
    this.textColor,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool isObscure;

  @override
  void initState() {
    super.initState();
    isObscure = widget.obscureText;
  }

  void toggleObscure() {
    setState(() {
      isObscure = !isObscure;
    });
  }

  OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: BorderSide(color: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.orangeDark,
      controller: widget.controller,
      obscureText: isObscure,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      style: TextStyle(color: widget.textColor ?? AppColors.white),
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: TextStyle(color: AppColors.orangeDark),
        enabledBorder: _border(AppColors.orangeDark),
        focusedBorder: _border(AppColors.orangeDark),
        errorBorder: _border(AppColors.red),
        focusedErrorBorder: _border(AppColors.red),
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
