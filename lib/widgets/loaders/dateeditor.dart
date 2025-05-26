// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ljm/tools/env.dart';

class DatePickerTextFieldWidget extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateChanged;
  final String label;

  DatePickerTextFieldWidget({super.key, this.label = "Periode", required this.selectedDate, required this.onDateChanged});

  final TextEditingController _datePickerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _datePickerController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
    return TextField(
      textAlignVertical: TextAlignVertical.center,
      enableInteractiveSelection: false,
      canRequestFocus: false,
      controller: _datePickerController,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        isCollapsed: true,
        prefixIconConstraints: const BoxConstraints(maxHeight: 50),
        isDense: true,
        contentPadding: const EdgeInsets.all(5),
        border: const OutlineInputBorder(),
        labelText: label,
        prefixIcon: const Icon(Icons.calendar_month_outlined, color: mainColor),
      ),
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );

        if (picked != null && picked != selectedDate) {
          onDateChanged(picked);
          _datePickerController.text = DateFormat('dd/MM/yyyy').format(picked);
        }
      },
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}
