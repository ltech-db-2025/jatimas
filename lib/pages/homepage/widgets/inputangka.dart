import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ljm/pages/homepage/widgets/plusminus.dart';
import 'package:ljm/tools/env.dart';

Future showDoubleDialog(
  BuildContext context,
  double d, {
  String? label,
  Function? onDelete,
  required Function(double) onSubmit,
  required Row Function(dynamic context, dynamic onDelete, dynamic onSubmit) buttonBuilder,
}) async {
  double wid = (onDelete != null) ? 90 : 170;
  double newd = d;
  await showDialog<double>(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: (label == null) ? null : Text(label),
        contentPadding: const EdgeInsets.all(20),
        children: <Widget>[
          /* ListTile(
            trailing: IconButton(
                onPressed: () {
                  newd++;
                  controller = TextEditingController(text: formatangka(newd));
                },
                icon: Icon(Icons.add_circle)),
            title: TextField(
                controller: controller,
                keyboardType: TextInputType.numberWithOptions(),
                onChanged: (value) {
                  if (double.tryParse(value) != null) newd = double.tryParse(value) ?? 0;
                }),
            leading: IconButton(
                onPressed: () {
                  newd--;
                  controller = TextEditingController(text: formatangka(newd));
                },
                icon: Icon(Icons.remove_circle)),
          ), */
          PlusMinusButtons(
              padding: const EdgeInsets.all(8),
              width: 200,
              //padding: const EdgeInsets.symmetric(horizontal: 50),
              size: 2,
              add: () => newd++,
              min: () => newd--,
              onmanual: (p0) => newd = double.tryParse(p0) ?? 0,
              nilai: newd),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              if (onDelete != null)
                IconButton(
                  color: Colors.red,
                  onPressed: () => onDelete(),
                  icon: const Icon(Icons.delete_rounded),
                ),
              SizedBox(
                  width: wid,
                  child: ElevatedButton(
                    style: ebWhite,
                    onPressed: () => Get.back(result: d),
                    child: const Text('Batal', style: TextStyle(color: mainColor)),
                  )),
              SizedBox(width: wid, child: ElevatedButton(onPressed: () => onSubmit(newd), child: const Text('OK'))),
            ],
          ),
        ],
      );
    },
  );
}
