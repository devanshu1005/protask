import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protask1/app/utils/widgets/dialogue_helper.dart';

class CommonInputField extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool isPassword;
  final bool readOnly;
  final VoidCallback? onTap;
  final RxBool? isVisibleObs;
  final Widget? suffixBuilder; // 👈 NEW

  const CommonInputField({
    super.key,
    required this.icon,
    required this.hintText,
    required this.controller,
    this.keyboardType,
    this.isPassword = false,
    this.readOnly = false,
    this.onTap,
    this.isVisibleObs,
    this.suffixBuilder, // 👈 NEW
  });

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade300),
    );

    Widget buildTextField({required bool obscure}) {
      return TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscure,
        readOnly: readOnly,
        onTap: () {
          if (readOnly) {
            DialogHelper.showInfo('This field cannot be edited');
          } else {
            onTap?.call();
          }
        },
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey,
              ),
          prefixIcon: Icon(
            icon,
            color: Colors.grey,
            size: 20,
          ),
          suffixIcon: suffixBuilder ??
              (isPassword && isVisibleObs != null
                  ? IconButton(
                      icon: Icon(
                        obscure
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.grey,
                        size: 20,
                      ),
                      onPressed: () {
                        isVisibleObs!.value = !isVisibleObs!.value;
                      },
                    )
                  : null),
          enabledBorder: inputBorder,
          focusedBorder: inputBorder,
          border: inputBorder,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      );
    }

    if (isPassword && isVisibleObs != null) {
      return Obx(() => buildTextField(obscure: !isVisibleObs!.value));
    } else {
      return buildTextField(obscure: false);
    }
  }
}

