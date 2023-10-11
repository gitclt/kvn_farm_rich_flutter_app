import 'package:flutter/material.dart';
import 'package:kvn_farm_rich/constraints/app_colors.dart';

class DrowpDownButton extends StatelessWidget {
  final FormFieldValidator validator;
  final Function onChanged;
  final String label;
  final String hintText;
  final List<DropdownMenuItem<dynamic>> iteams;
  const DrowpDownButton({
    super.key,
    required this.validator,
    required this.onChanged,
    required this.iteams,
    required this.label,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      borderRadius: BorderRadius.circular(15),
      icon: const Icon(
        Icons.expand_more_outlined,
        size: 25,
        color: redColor,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 14, color: Color(0xFF9A9A9A)),
        labelStyle: const TextStyle(fontSize: 14, color: Colors.grey),
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        labelText: label,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF939393), width: .5),
          borderRadius: BorderRadius.circular(15),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF939393), width: .5),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF939393), width: .5),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      validator: validator,
      items: iteams,
      onChanged: (value) {
        onChanged(value);
      },
    );
  }
}
