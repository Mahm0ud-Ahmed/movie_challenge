import 'package:flutter/material.dart';
import 'package:movie_challange/src/core/utils/constant.dart';

class GenericTextField extends StatelessWidget {
  final String hintText;
  final Function(String)? onChange;
  final Function(String?)? onTab;
  final TextEditingController? controller;

  const GenericTextField({
    super.key,
    this.onChange,
    this.onTab,
    this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: TextFormField(
        controller: controller,
        cursorColor: kTextPrimaryColor,
        decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          prefixIcon: const Icon(
            Icons.search,
          ),
          hintText: hintText,
        ),
        onChanged: onChange,
        onSaved: onTab,
      ),
    );
  }
}
