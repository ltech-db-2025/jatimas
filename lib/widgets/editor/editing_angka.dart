import 'package:flutter/material.dart';
import 'package:ljm/tools/env.dart';

class NumberInput extends StatefulWidget {
  final String? initial;
  final Function(String)? onChanged;
  NumberInput({this.onChanged, this.initial});

  @override
  _NumberInputState createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInput> {
  int _value = 0;

  void _increase() {
    setState(() {
      _value++;
      if (widget.onChanged != null) widget.onChanged!(_value.toString());
    });
  }

  void _decrease() {
    if (_value > 0) {
      setState(() {
        _value--;
        if (widget.onChanged != null) widget.onChanged!(_value.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color(0xFF00b3b0),
            shape: BoxShape.circle, // Bentuk lingkaran
          ),
          width: 30, // Lebar
          height: 30, // Tinggi
          child: IconButton(
            icon: Icon(
              Icons.remove,
              color: Colors.white,
              size: 12,
            ),
            onPressed: _decrease,
          ),
        ),
        Container(
          width: 50,
          alignment: Alignment.center,
          child: Text(widget.initial ?? '', style: TextStyle(fontSize: 10)),
        ),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFF00b3b0),
            shape: BoxShape.circle, // Bentuk lingkaran
          ),
          width: 30, // Lebar
          height: 30, // Tinggi
          child: IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
              size: 12,
            ),
            onPressed: _increase,
          ),
        ),
      ],
    );
  }
}

class NumberInput2 extends StatefulWidget {
  final String? initial;
  final Function(String)? onChanged;
  NumberInput2({this.onChanged, this.initial});

  @override
  _NumberInput2State createState() => _NumberInput2State();
}

class _NumberInput2State extends State<NumberInput2> {
  double _value = 0;

  void _increase() {
    setState(() {
      _value++;
      controller.text = _value.toString();
      if (widget.onChanged != null) widget.onChanged!(_value.toString());
    });
  }

  void _decrease() {
    if (_value > 0) {
      setState(() {
        _value--;
        controller.text = _value.toString();
        if (widget.onChanged != null) widget.onChanged!(_value.toString());
      });
    }
  }

  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    _value = makeDouble(widget.initial) ?? 0;
    if (widget.initial != null) controller.text = widget.initial!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 100,
      decoration: BoxDecoration(
        border: Border.all(color: mainColor, width: 0),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: _decrease,
            child: Icon(
              Icons.remove,
              size: 12,
            ),
          ),
          Container(
              width: 40,
              alignment: Alignment.center,
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.numberWithOptions(),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                onChanged: (value) {
                  _value = double.tryParse(value) ?? 0;
                  if (widget.onChanged != null) widget.onChanged!(_value.toString());
                },
              )),
          GestureDetector(
            onTap: _increase,
            child: Icon(
              Icons.add,
              size: 12,
            ),
          ),
        ],
      ),
    );
  }
}
