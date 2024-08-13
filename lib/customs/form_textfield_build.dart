import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderCustom extends StatelessWidget {

  final String name;
  final bool obscureText;
  final String hintText;
  final String? Function(String?)? validator;
  final IconData icon;
  final TextInputType keytype;

  const FormBuilderCustom({
    super.key,
    required this.name,
    required this.obscureText,
    required this.hintText,
    required this.validator,
    required this.icon,
    required this.keytype,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FormBuilderTextField(
        autovalidateMode: AutovalidateMode.onUserInteraction, 
        name: name,
        obscureText: obscureText,
        validator: validator,
        keyboardType: keytype,
        decoration: InputDecoration(
          errorStyle: const TextStyle(color: Colors.red, fontSize: 11),
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50)
          ),
          suffixIcon: Icon(icon),
          suffixIconColor: Colors.grey,
          fillColor: Colors.white,
          filled: true
        ),
      ),
    );
  }
}