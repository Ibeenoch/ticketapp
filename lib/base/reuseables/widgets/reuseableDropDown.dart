import 'package:flutter/material.dart';

class ReuseableDropDown<T> extends StatelessWidget {
  final String labelText;
  final List<T> items;
  final T? selectedValue;
  final FocusNode? focusNode;
  final ValueChanged<T?>? onChanged;
  final String Function(T item)? displayText;

  const ReuseableDropDown(
      {super.key,
      required this.labelText,
      this.displayText,
      required this.items,
      this.selectedValue,
      required this.focusNode,
      required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
      focusNode: focusNode,
      value: selectedValue,
      items: items.map((item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(
            displayText != null ? displayText!(item) : item.toString(),
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
