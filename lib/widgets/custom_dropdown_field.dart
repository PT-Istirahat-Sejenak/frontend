import 'package:flutter/material.dart';

class CustomDropdownField extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> options;
  final void Function(String?) onChanged;

  const CustomDropdownField({
    super.key,
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        value: value,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        ),
        icon: const Icon(Icons.keyboard_arrow_down),
        items: options.map((String val) {
          return DropdownMenuItem<String>(
            value: val,
            child: Text(val),
          );
        }).toList(),
      ),
    );
  }
}
