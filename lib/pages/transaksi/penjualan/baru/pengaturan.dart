import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ljm/provider/models/harga.dart';
import 'package:ljm/provider/models/kontak.dart';
import 'package:ljm/provider/models/lokasi.dart';
import 'package:ljm/widgets/lookup/harga.dart';
import 'package:ljm/widgets/lookup/lokasi.dart';
import 'package:ljm/widgets/lookup/sales.dart';
import 'package:ljm/provider/models/transaksi/transaksi.dart';
import 'package:ljm/tools/env.dart';

class PengaturanPenjualan extends StatelessWidget {
  final TRANSAKSI? data;
  final bool pilihharga;
  final bool pilihlokasi;
  final Function(LOKASI?)? onLokasiChanged;
  final Function(HARGA?)? onHargaChanged;
  PengaturanPenjualan({
    super.key,
    this.data,
    this.pilihharga = true,
    this.pilihlokasi = true,
    this.onLokasiChanged,
    this.onHargaChanged,
  });

  @override
  Widget build(BuildContext context) {
    LOKASI _deflokasi = (data != null) ? LOKASI(id: data!.idlokasi) : LOKASI();
    HARGA _defharga = (data != null) ? HARGA(kode: data!.jharga) : HARGA();
    List<DropdownMenuEntry<bool>> opsiSemuaStok = [];

    opsiSemuaStok.add(const DropdownMenuEntry<bool>(value: true, label: 'Iya'));
    opsiSemuaStok.add(const DropdownMenuEntry<bool>(value: false, label: 'Tidak'));
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
      ),
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: const TextScaler.linear(sf),
        ),
        child: Scaffold(
          appBar: AppBar(elevation: 0, title: const Text("Pengaturan Tampilan Penjualan")),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                if (pilihlokasi)
                  PilihLokasi(
                    initial: _deflokasi,
                    onPilih: (p0) {
                      if (onLokasiChanged != null) onLokasiChanged!(p0);
                    },
                  ),
                if (pilihharga)
                  PilihHarga(
                    initial: _defharga,
                    onPilih: (p0) {
                      if (onHargaChanged != null) onHargaChanged!(p0);
                    },
                  ),
                if (iAdmin() || iDireksi())
                  PilihSales(
                    initial: (data != null) ? KONTAK(id: data!.idpegawai) : salesAktif,
                    onPilih: (p0) {
                      if (p0 != null) {
                        if (data != null) {
                          data!.idpegawai = p0.id;
                          data!.pegawai = p0.kode;
                        }
                      }
                    },
                  ),
                OpsiPengaturan<bool>(
                  opsiSemuaStok,
                  label: 'Tampilkan Barang Tanpa Stok',
                  initial: stokPenjualan,
                  onSelected: (p0) {
                    stokPenjualan = p0 ?? false;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OpsiAtur {}

class OpsiPengaturan<T> extends StatelessWidget {
  final String label;
  final void Function(T?)? onSelected;
  final T? initial;
  final List<DropdownMenuEntry<T>> dropdownMenuEntries;
  const OpsiPengaturan(this.dropdownMenuEntries, {this.label = '', this.initial, this.onSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 50,
      child: Flex(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        direction: Axis.horizontal,
        children: [
          Flexible(flex: 1, child: Text(label)),
          Flexible(
            flex: 1,
            child: DropdownMenu<T>(
              width: 150,
              textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              trailingIcon: const Padding(padding: EdgeInsets.zero, child: Icon(Icons.arrow_drop_down, size: 15)),
              initialSelection: initial,
              onSelected: onSelected,
              inputDecorationTheme: const InputDecorationTheme(
                alignLabelWithHint: true,
                isCollapsed: true,
                constraints: BoxConstraints(maxHeight: 30),
                helperMaxLines: 1,
                filled: true,
                isDense: true,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              ),
              dropdownMenuEntries: dropdownMenuEntries,
            ),
          )
        ],
      ),
    );
  }
}
