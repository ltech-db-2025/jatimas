import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ljm/tools/env.dart';
import 'package:ljm/widgets/customtextfield.dart';

class PageKontakBaru extends StatefulWidget {
  const PageKontakBaru({super.key});

  @override
  State<PageKontakBaru> createState() => _PageKontakBaruState();
}

class _PageKontakBaruState extends State<PageKontakBaru> {
  final TextEditingController kodeController = TextEditingController();
  final TextEditingController namaController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pelanggan Baru'),
      ),
      body: _inputDataPelanggan(context),
      bottomNavigationBar: Container(
          padding: EdgeInsets.all(8.0),
          height: 70,
          color: Colors.white,
          child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: mainColor, // Set the background color to yellow
              ),
              child: Text('Simpan'))),
    );
  }

  Widget _inputDataPelanggan(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CustomTextField(
                controller: namaController,
                floatingLabelBehavior: CustomTextFieldFloatingLabelBehavior.always,
                label: 'Kode',
                hint: 'contoh : AND-AG1',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CustomTextField(
                controller: namaController,
                floatingLabelBehavior: CustomTextFieldFloatingLabelBehavior.always,
                label: 'Nama',
                hint: 'contoh : ANDI AGUS',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CustomTextField(
                controller: namaController,
                floatingLabelBehavior: CustomTextFieldFloatingLabelBehavior.always,
                label: 'Jabatan',
                hint: 'contoh : SALES',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: namaController,
                      floatingLabelBehavior: CustomTextFieldFloatingLabelBehavior.always,
                      label: 'No. Telephone',
                      hint: 'contoh : 0342 - 834234',
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CustomTextField(
                      controller: namaController,
                      floatingLabelBehavior: CustomTextFieldFloatingLabelBehavior.always,
                      label: 'No. WhatsApp',
                      hint: 'contoh : 082345234888',
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 5,
            ),
            _alamatPenagihan(context),
            Divider(
              thickness: 5,
            ),
            _alamatPengiriman(context),
            Divider(
              thickness: 5,
            ),
          ],
        ),
      ),
    );
  }

  Widget _alamatPenagihan(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text('Alamat Penagihan'),
            ),
            TextButton(
                onPressed: () {
                  Get.to(InputDataAlamat());
                },
                child: Text(
                  'Tambah Alamat',
                  style: TextStyle(color: mainColor),
                ))
          ],
        )
      ],
    );
  }

  Widget _alamatPengiriman(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text('Alamat Pengiriman'),
            ),
            TextButton(
                onPressed: () {},
                child: Text(
                  'Tambah Alamat',
                  style: TextStyle(color: Colors.grey),
                ))
          ],
        )
      ],
    );
  }
}

class InputDataAlamat extends StatefulWidget {
  const InputDataAlamat({super.key});

  @override
  State<InputDataAlamat> createState() => _InputDataAlamatState();
}

class _InputDataAlamatState extends State<InputDataAlamat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Alamat'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomTextField(
              // controller: namaController,
              floatingLabelBehavior: CustomTextFieldFloatingLabelBehavior.always,
              label: 'Alamat Lengkap',
              hint: 'contoh : JL. Panjer No. 02 Turen - Malang',
              maxlines: 5,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
          padding: EdgeInsets.all(8.0),
          height: 70,
          color: Colors.white,
          child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: mainColor, // Set the background color to yellow
              ),
              child: Text('Simpan'))),
    );
  }
}
