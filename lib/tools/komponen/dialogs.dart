import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ljm/tools/env.dart';

class CustomDialogBox extends StatefulWidget {
  final String title;
  final Image? img;

  const CustomDialogBox({super.key, this.title = '', this.img});

  @override
  State<CustomDialogBox> createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  late Function sheetSetState;
  late Timer timer;

  void addTime() {
    sheetSetState(() {
      final seconds = messageDuration.inSeconds + 1;
      messageDuration = Duration(seconds: seconds);
      if (messageDuration >= durasiPesan) Navigator.of(context).pop();
    });
  }

  @override
  void dispose() {
    dialogMessageOpened = false;
    timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    // ignore: unused_local_variable
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
    dialogMessageOpened = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
      sheetSetState = setState;
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: contentBox(context),
      );
    });
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 20, top: 45 + 20, right: 20, bottom: 20),
          margin: const EdgeInsets.only(top: 45),
          decoration: BoxDecoration(shape: BoxShape.rectangle, color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: const [
            BoxShadow(color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
          ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.title,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                dialogMessageText,
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 22,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Tutup  ${((durasiPesan.inSeconds - messageDuration.inSeconds) > 60) ? '' : durasiPesan.inSeconds - messageDuration.inSeconds}", style: const TextStyle(fontSize: 18))),
              ),
            ],
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 45,
            child: ClipRRect(borderRadius: const BorderRadius.only(topRight: Radius.circular(45), topLeft: Radius.circular(45)), child: widget.img ?? Image.asset('assets/l1.png')),
          ),
        ),
      ],
    );
  }
}
