import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ljm/pages/homepage/widgets/editor.dart';
import 'package:ljm/provider/models/barangjenis.dart';
import 'package:ljm/tools/env.dart';

import 'controller.dart';

final _formKey = GlobalKey<FormState>();
BARANGJENIS jenis = BARANGJENIS();

class BrgJenisEditor extends StatefulWidget {
  final BARANGJENIS data;
  const BrgJenisEditor(this.data, {super.key});

  @override
  State<BrgJenisEditor> createState() => _BrgJenisEditorState();
}

class _BrgJenisEditorState extends State<BrgJenisEditor> {
  var c = Get.put(getJensiBarangController());
  @override
  void initState() {
    jenis = widget.data.copyWith();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text((jenis.id == null) ? "Jenis Barang Baru" : "Edit Jenis Barang"),
          ],
        ),
      ),
      floatingActionButton: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          onPressed: () async {
            if (jsonEncode(jenis.toJson()) == jsonEncode(widget.data.toJson())) {
              Get.back();
              Get.snackbar('Penyimpanan', "Tidak ada perubahan");
            } else {
              if (_formKey.currentState!.validate()) {
                var res = await c.updateBrgJenis(jenis);
                if (res != null) {
                  jenis = res.copyWith();
                  Get.back(result: jenis);
                  Get.snackbar('Penyimpanan', "Diupdate");
                } else {
                  Get.snackbar('Penyimpanan', "gagal");
                }
              }
            }
          },
          heroTag: "fab1",
          child: const Icon(Icons.save),
        ),
        const SizedBox(width: 10),
        FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () async {
            if (await konfirmasi('Hapus data BARANGJENIS ${jenis.id} jenis: ${jenis.jenis}') == true) {
              if (await c.hapus(jenis)) {
                Get.back(result: true);
              }
            }
          },
          heroTag: "fab2",
          mini: true,
          child: const Icon(Icons.delete),
        ),
      ]),
      body: const SafeArea(child: EKDataPribadi()),
    );
  }
}

class EKDataPribadi extends StatefulWidget {
  const EKDataPribadi({super.key});

  @override
  State<EKDataPribadi> createState() => _EKDataPribadiState();
}

class _EKDataPribadiState extends State<EKDataPribadi> {
  @override
  Widget build(BuildContext context) {
    editor(String label, String? initial, {void Function(String)? onChanged}) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label),
            const SizedBox(height: 5),
            TextField(
              controller: TextEditingController(text: initial),
              onEditingComplete: () => FocusScope.of(context).nextFocus(),
              onChanged: onChanged,
              decoration: InputDecoration(labelStyle: labelstyle, filled: true, fillColor: Colors.white),
            ),
            const SizedBox(height: 10),
          ],
        ),
      );
    }

    return Container(
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: FocusTraversalGroup(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              editor('Nama BARANGJENIS (Wajib)', jenis.jenis, onChanged: (p0) => jenis.jenis = p0),
            ],
          )),
        ),
      ),
    );
  }
}
