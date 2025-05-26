import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ljm/provider/models/barang.dart';
import 'package:ljm/widgets/customtextfield.dart';
import 'package:ljm/widgets/lookup/golongan.dart';
import 'package:ljm/widgets/lookup/jenis.dart';
import 'package:ljm/widgets/lookup/kategori.dart';
import 'package:ljm/widgets/lookup/kelompok.dart';
import 'package:ljm/widgets/lookup/merk.dart';
import 'package:ljm/widgets/lookup/satuan.dart';
import 'package:ljm/widgets/lookup/supplier.dart';
import 'package:ljm/widgets/tombol/custom_tombol.dart'; // Jika Anda ingin menggunakan ImagePicker untuk memilih gambar

class EditBarangPage3 extends StatefulWidget {
  final BARANG data;
  final String? judul;

  const EditBarangPage3(
    this.data, {
    super.key,
    this.judul,
  });

  @override
  _EditBarangPage3State createState() => _EditBarangPage3State();
}

class _EditBarangPage3State extends State<EditBarangPage3> {
  final TextEditingController angkaController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController kodeController = TextEditingController();
  final TextEditingController beliController = TextEditingController(text: 'Rp 0');
  final TextEditingController salesController = TextEditingController(text: 'Rp 0');
  final TextEditingController spesialController = TextEditingController(text: 'Rp 0');
  final TextEditingController partaiController = TextEditingController(text: 'Rp 0');
  final TextEditingController eceranController = TextEditingController(text: 'Rp 0');
  XFile? _image; // Variabel untuk menyimpan gambar

  @override
  void initState() {
    super.initState();
    namaController.text = widget.data.nama;
    kodeController.text = widget.data.kode!;
    // Inisialisasi controller lainnya sesuai kebutuhan
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? selectedImage = await picker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      setState(() {
        _image = selectedImage; // Simpan gambar yang dipilih
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.judul ?? 'Tambah Barang'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Menampilkan gambar jika ada
              GestureDetector(
                onTap: _pickImage, // Ganti gambar saat ditekan
                child: Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                      // border: Border.all(color: Colors.blue, width: 1),
                      ),
                  child: _image == null
                      ? Image.asset('assets/tambahgambar.png', fit: BoxFit.cover) // Gambar dari assets
                      : Image.file(File(_image!.path), fit: BoxFit.cover), // Gambar yang dipilih
                ),
              ),

              Padding(padding: EdgeInsets.symmetric(vertical: 16.0), child: Container(padding: EdgeInsets.all(8.0), height: 40, width: double.infinity, color: Colors.grey, child: Text('INFORMASI BARANG'))),
              CustomTextField(
                controller: kodeController,
                label: 'Kode Barang',
              ),
              CustomTextField(
                controller: namaController,
                floatingLabelBehavior: CustomTextFieldFloatingLabelBehavior.always,
                label: 'Nama Barang',
              ),

              _inputMerkKategori(context),
              _inputGolonganJenis(context),
              _inputKelompokSatuan(context),
              Padding(padding: EdgeInsets.symmetric(vertical: 16.0), child: Container(padding: EdgeInsets.all(8.0), height: 40, width: double.infinity, color: Colors.grey, child: Text('DISTRIBUTOR'))),
              _inputSupplier(context),
              Padding(padding: EdgeInsets.symmetric(vertical: 16.0), child: Container(padding: EdgeInsets.all(8.0), height: 40, width: double.infinity, color: Colors.grey, child: Text('INFORMASI HARGA'))),

              _inputHargaBeli(context),
              _inputHargaSalesSpesial(context),
              _inputHargaPartaiEceran(context)
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TombolSimpan(onPressed: () {}),
      ),
    );
  }

  Widget _inputMerkKategori(BuildContext context) {
    return Row(
      children: [
        Expanded(child: PilihMerk()),
        SizedBox(
          width: 10,
        ),
        Expanded(child: PilihKategori()),
      ],
    );
  }

  Widget _inputGolonganJenis(BuildContext context) {
    return Row(
      children: [
        Expanded(child: PilihGolongan()),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: PilihJenis(),
        ),
      ],
    );
  }

  Widget _inputKelompokSatuan(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PilihKelompok(),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: PilihSatuan(),
        ),
      ],
    );
  }

  Widget _inputSupplier(BuildContext context) {
    return PilihSupplier();
  }

  Widget _inputHargaBeli(BuildContext context) {
    return inputHargaBeli(
      controller: beliController,
      label: 'Harga Beli',
    );
  }

  Widget _inputHargaSalesSpesial(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: inputHargaSales(
            controller: salesController,
            label: 'Harga Sales',
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: inputHargaSpesial(
            controller: spesialController,
            label: 'Harga Spesial',
          ),
        ),
      ],
    );
  }

  Widget _inputHargaPartaiEceran(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: inputHargaPartai(
            controller: partaiController,
            label: 'Harga Partai',
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: inputHargaEceran(
            controller: eceranController,
            label: 'Harga Eceran',
          ),
        ),
      ],
    );
  }
}
