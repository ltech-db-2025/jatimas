// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ljm/tools/env.dart';

class MyTextFieldDatePicker extends StatefulWidget {
  final ValueChanged<DateTime>? onDateChanged;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateFormat? dateFormat;
  final FocusNode? focusNode;
  final String? labelText;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final TextEditingController? controller;

  const MyTextFieldDatePicker({
    super.key,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.focusNode,
    this.dateFormat,
    this.controller,
    @required this.lastDate,
    @required this.firstDate,
    @required this.initialDate,
    @required this.onDateChanged,
  })  : assert(initialDate != null),
        assert(firstDate != null),
        assert(lastDate != null),
        // assert(initialDate!.isBefore(firstDate!), 'initialDate must be on or after firstDate'),
        // assert(initialDate!.isAfter(lastDate!), 'initialDate must be on or before lastDate'),
        // ssert(firstDate!.isAfter(lastDate!), 'lastDate $lastDate must be on or after firstDate $firstDate'),
        assert(onDateChanged != null, 'onDateChanged must not be null');

  @override
  State<MyTextFieldDatePicker> createState() => _MyTextFieldDatePicker();
}

class _MyTextFieldDatePicker extends State<MyTextFieldDatePicker> {
  TextEditingController? _controllerDate;
  DateFormat? _dateFormat;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();

    if (widget.dateFormat != null) {
      _dateFormat = widget.dateFormat;
    } else {
      _dateFormat = DateFormat('dd/MM/yyyy');
    }

    _selectedDate = widget.initialDate;

    _controllerDate = (widget.controller == null) ? TextEditingController() : widget.controller;
    _controllerDate!.text = _dateFormat!.format(_selectedDate!);
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(skala)),
      child: Card(
        margin: const EdgeInsets.only(left: 0, right: 0, top: 10),
        elevation: 0,
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        child: TextField(
          focusNode: widget.focusNode,
          controller: _controllerDate,
          decoration: InputDecoration(
            labelStyle: const TextStyle(letterSpacing: 2.0),
            contentPadding: const EdgeInsets.all(0),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
            labelText: widget.labelText,
          ),
          onTap: () => _selectDate(context),
          readOnly: true,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controllerDate!.dispose();
    super.dispose();
  }

  Future _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate!,
      firstDate: widget.firstDate!,
      lastDate: widget.lastDate!,
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      _selectedDate = pickedDate;
      _controllerDate!.text = _dateFormat!.format(_selectedDate!);
      widget.onDateChanged!(_selectedDate!);
    }

    if (widget.focusNode != null) {
      widget.focusNode!.nextFocus();
    }
  }

  Widget textFieldsTheme(Widget textField, {Color? primaryColor}) {
    return Theme(
      data: ThemeData(
        primaryColor: primaryColor,
        hintColor: Colors.black38,
        cardTheme: const CardTheme(color: Colors.red),
        textSelectionTheme: const TextSelectionThemeData(selectionColor: Colors.yellow),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black),
      ),
      child: textField,
    );
  }
}

class MaskedTextController extends TextEditingController {
  String? mask;
  Map<String, RegExp>? translator;
  MaskedTextController({super.text, this.mask, translator}) {
    translator = translator ?? MaskedTextController.getDefaultTranslator();

    addListener(() {
      var previous = _lastUpdatedText;
      if (beforeChange(previous, text)) {
        updateText(text);
        afterChange(previous, text);
      } else {
        updateText(_lastUpdatedText);
      }
    });

    updateText(text);
  }

  Function afterChange = (String previous, String next) {};
  Function beforeChange = (String previous, String next) {
    return true;
  };

  String _lastUpdatedText = '';

  void updateText(String text) {
    text = _applyMask(mask!, text);
    _lastUpdatedText = this.text;
  }

  void updateMask(String mask, {bool moveCursorToEnd = true}) {
    this.mask = mask;
    updateText(text);

    if (moveCursorToEnd) {
      this.moveCursorToEnd();
    }
  }

  void moveCursorToEnd() {
    var text = _lastUpdatedText;
    selection = TextSelection.fromPosition(TextPosition(offset: (text).length));
  }

  @override
  set text(String newText) {
    if (super.text != newText) {
      super.text = newText;
      moveCursorToEnd();
    }
  }

  static Map<String, RegExp> getDefaultTranslator() {
    return {'A': RegExp(r'[A-Za-z]'), '0': RegExp(r'[0-9]'), '@': RegExp(r'[A-Za-z0-9]'), '*': RegExp(r'.*')};
  }

  String _applyMask(String mask, String value) {
    String result = '';

    var maskCharIndex = 0;
    var valueCharIndex = 0;

    while (true) {
      // if mask is ended, break.
      if (maskCharIndex == mask.length) {
        break;
      }

      // if value is ended, break.
      if (valueCharIndex == value.length) {
        break;
      }

      var maskChar = mask[maskCharIndex];
      var valueChar = value[valueCharIndex];

      // value equals mask, just set
      if (maskChar == valueChar) {
        result += maskChar;
        valueCharIndex += 1;
        maskCharIndex += 1;
        continue;
      }

      // apply translator if match
      if (translator!.containsKey(maskChar)) {
        if (translator![maskChar]!.hasMatch(valueChar)) {
          result += valueChar;
          maskCharIndex += 1;
        }

        valueCharIndex += 1;
        continue;
      }

      // not masked value, fixed char on mask
      result += maskChar;
      maskCharIndex += 1;
      continue;
    }

    return result;
  }
}

class MoneyMaskedTextController extends TextEditingController {
  final String decimalSeparator;
  final String thousandSeparator;
  final String rightSymbol;
  final String leftSymbol;
  final int precision;

  MoneyMaskedTextController({double initialValue = 0.0, this.decimalSeparator = ',', this.thousandSeparator = '.', this.rightSymbol = '', this.leftSymbol = '', this.precision = 2}) {
    _validateConfig();

    addListener(() {
      updateValue(numberValue);
      afterChange(text, numberValue);
    });

    updateValue(initialValue);
  }

  Function afterChange = (String maskedValue, double rawValue) {};

  double _lastValue = 0.0;

  void updateValue(double value) {
    if (value != 0) {
      double valueToUse = value;

      if (value.toStringAsFixed(0).length > 12) {
        valueToUse = _lastValue;
      } else {
        _lastValue = value;
      }

      String masked = _applyMask(valueToUse);

      if (rightSymbol.isNotEmpty) {
        masked += rightSymbol;
      }

      if (leftSymbol.isNotEmpty) {
        masked = leftSymbol + masked;
      }

      if (masked != text) {
        text = masked;

        var cursorPosition = super.text.length - rightSymbol.length;
        selection = TextSelection.fromPosition(TextPosition(offset: cursorPosition));
      }
    }
  }

  double get numberValue {
    if (text == '') {
      return 0;
    } else {
      List<String> parts = _getOnlyNumbers(text).split('').toList(growable: true);

      parts.insert(parts.length - precision, '.');

      return double.tryParse(parts.join()) ?? 0;
    }
  }

  _validateConfig() {
    bool rightSymbolHasNumbers = _getOnlyNumbers(rightSymbol).isNotEmpty;

    if (rightSymbolHasNumbers) {
      throw ArgumentError("rightSymbol must not have numbers.");
    }
  }

  String _getOnlyNumbers(String text) {
    String cleanedText = text;

    var onlyNumbersRegex = RegExp(r'[^\d]');

    cleanedText = cleanedText.replaceAll(onlyNumbersRegex, '');

    return cleanedText;
  }

  String _applyMask(double value) {
    List<String> textRepresentation = value.toStringAsFixed(precision).replaceAll('.', '').split('').reversed.toList(growable: true);

    textRepresentation.insert(precision, decimalSeparator);

    for (var i = precision + 4; true; i = i + 4) {
      if (textRepresentation.length > i) {
        textRepresentation.insert(i, thousandSeparator);
      } else {
        break;
      }
    }

    return textRepresentation.reversed.join('');
  }
}

Widget textEditor(String label, String hint, TextEditingController controller, {TextInputType? textInputType, TextAlign? textAlign = TextAlign.left}) {
  return Card(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      // color: Color(0XFF406B96),
      child: TextField(
        textAlign: textAlign!,
        keyboardType: textInputType,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        controller: controller,
      ));
}

Widget angkaEditor(String labelText, String hintText, controller, {String? prefixText}) {
  return Card(
    margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    // color: Color(0XFF406B96),
    child: TextField(
        textAlign: TextAlign.right,
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          prefixText: prefixText,
        )),
  );
}

Widget tanggalEditor({DateTime? firstDate, DateTime? lastDate, DateTime? initialDate, String? labelText, String? format = 'dd/MM/yyyy', void Function(DateTime)? onChanged}) {
  return MyTextFieldDatePicker(
    dateFormat: DateFormat(format),
    labelText: labelText,
    prefixIcon: const Icon(Icons.date_range),
    suffixIcon: const Icon(Icons.arrow_drop_down),
    lastDate: (lastDate == null) ? DateTime.now().add(const Duration(days: 366)) : lastDate,
    firstDate: (firstDate == null) ? DateTime.now() : firstDate,
    initialDate: (initialDate == null) ? DateTime.now() : initialDate,
    onDateChanged: (selectedDate) {
      onChanged!(selectedDate);
    },
  );
}

Widget tanggalEditor1({DateTime? firstDate, DateTime? lastDate, DateTime? initialDate, String? labelText, String? format = 'dd/MM/yyyy', void Function(DateTime)? onChanged}) {
  return MyTextFieldDatePicker(
    dateFormat: DateFormat(format),
    labelText: labelText,
    prefixIcon: const Icon(Icons.date_range),
    suffixIcon: const Icon(Icons.arrow_drop_down),
    firstDate: DateTime.now(),
    lastDate: DateTime.now().add(const Duration(days: 366)),
    initialDate: DateTime.now(),
    onDateChanged: (selectedDate) {
      onChanged!(selectedDate);
    },
  );
}
