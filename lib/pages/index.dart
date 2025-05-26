// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ljm/main.dart';

import 'package:ljm/pages/homepage/admin/widgets/saldokas.dart';
import 'package:ljm/pages/homepage/direksi/pages/saldokas.dart';
import 'package:ljm/pages/homepage/sales/controller.dart';
import 'package:ljm/pages/homepage/sales/page.dart';
import 'package:ljm/pages/master/barang/barang.dart';
import 'package:ljm/pages/master/barang/barang3.dart';
import 'package:ljm/pages/master/barang/kategori/page.dart';

import 'package:ljm/pages/master/kontak/baru_pelanggan.dart';
import 'package:ljm/pages/transaksi/penjualan/baru/cetaknotapenjualan.dart';
import 'package:ljm/pages/transaksi/penjualan/baru/pembayaran.dart';
import 'package:ljm/pages/transaksi/penjualan/baru/rincian2.dart';
import 'package:ljm/pages/transaksi/penjualan/penjualan.dart';
import 'package:ljm/pages/transaksi/penjualan/penjualan_list.dart';
import 'package:ljm/pages/users/login2/login.dart';
import 'package:ljm/provider/models/harga.dart';
import 'package:ljm/provider/models/lokasi.dart';
// import 'package:ljm/pages/homepage/sales/widgets/saldokas.dart';
/* import 'package:ljm/pages/master/barang/support/jenis/view.dart';
import 'package:ljm/pages/master/barang/support/kategori/view.dart';
import 'package:ljm/pages/master/barang/support/merk/view.dart';
import 'package:ljm/pages/master/barang/view/page.dart';
import 'package:ljm/pages/master/kontak/view/page.dart';
import 'package:ljm/pages/master/lokasi/page.dart';
import 'package:ljm/pages/master/notifikasi/page.dart';
import 'package:ljm/pages/master/peletakan/page.dart'; */
// import 'package:ljm/pages/setting.dart';
// import 'package:ljm/pages/splash.dart';
/* import 'package:ljm/pages/transaksi/mutasi/permintaan/baru/page.dart';
import 'package:ljm/pages/transaksi/mutasi/permintaan/getx/view/page.dart';
import 'package:ljm/pages/transaksi/opname/page.dart';
import 'package:ljm/pages/transaksi/pelunasan/page.dart';
import 'package:ljm/pages/transaksi/penjualan/baru/page.dart';
import 'package:ljm/pages/transaksi/penjualan/page.dart';
import 'package:ljm/pages/transaksi/piutang/view/page.dart'; */
import 'package:ljm/widgets/blank.dart';
import 'package:ljm/provider/models/kontak.dart';
import 'package:ljm/provider/models/transaksi/transaksi.dart';
import 'package:ljm/tools/env.dart';

import 'homepage/admin/controller.dart';
import 'homepage/admin/page.dart';
import 'homepage/direksi/pages/mainpage.dart';

import 'homepage/member/page.dart';
import 'lib/views/screens/home_page.dart';
import 'master/barang/detail.dart';
import 'master/barang/jenis/edit.dart';
import 'master/barang/jenis/page.dart';
import 'master/barang/kategori/edit.dart';
import 'master/kontak/page.dart';
import 'transaksi/pelunasan_piutang/baru.dart';
import 'transaksi/pelunasan_piutang/piutang.dart';
import 'transaksi/penjualan/baru/input_penjualan.dart';
import 'transaksi/penjualan/baru/listbarang.dart';
import 'transaksi/penjualan/baru/pembayaran2.dart';
import 'transaksi/penjualan/baru/pengaturan.dart';
import 'master/kontak/detail_pelanggan.dart';
import 'transaksi/pelunasan_piutang/rincian_pembayaran.dart';
import 'transaksi/penjualan/baru/rincian.dart';
import 'transaksi/penjualan/rincian.dart';
import 'transaksi/penjualan/piutang.dart';
import 'transaksi/piutang_group_kontak.dart';
/* import 'master/akuntansi/klasifikasi/page.dart';
import 'master/barang/support/kelompok/view.dart';
import 'master/lokasi/rak/page.dart'; */
// import 'users/poin/page.dart';

/* const PageKontak listPelanggan = PageKontak();
const PiutangViewPage piutangViewPage = PiutangViewPage();
PageBarang pageBarang = const PageBarang();
VPenjualan penjualanViewPage = const VPenjualan();
PageOrderBaru pageorderbaru = const PageOrderBaru();
ReqMutasiPage reqMutasi = const ReqMutasiPage();
VPermintaanPage permintaanMutasiPage = const VPermintaanPage();
SettingPage pageSetting = const SettingPage();
LokasiPage pageLokasi = LokasiPage();
BlankPage pageBlank = const BlankPage();
PelunasanPageView pelunasanPageView = const PelunasanPageView();
NotifikasiPage notifikasiPage = const NotifikasiPage(); */
/*



final PageMutasi pagemutasi = PageMutasi();
final PageMutasiBaru pagemutasibaru = PageMutasiBaru();
final ReqMutasiPage reqMutasi = ReqMutasiPage();

final PageTest coba = PageTest();


final InventoryDashboard dashboardgudang = InventoryDashboard();
 */

// PenjualanGudang transaksiGudang = const PenjualanGudang();
var rPage = [
  GetPage(name: '/', page: () => const wellcome()),
  GetPage(name: '/login', page: () => const LoginPage()),
  GetPage(
      name: '/home',
      page: () {
        switch (TipeOperator.values[user.tipe]) {
          case TipeOperator.admin:
            return GetBuilder<DBAdminController>(
              init: DBAdminController(),
              builder: (_) {
                return DBAdmin(user);
              },
            );
          case TipeOperator.sales:
            return GetBuilder<DBSalesController>(
              init: DBSalesController(),
              builder: (_) {
                return DBSales(user);
              },
            );
          case TipeOperator.direksi:
            return GetBuilder<DBAdminController>(
              init: DBAdminController(),
              builder: (_) {
                return DBAdmin(user);
              },
            );
          default:
            dp("default: ${TipeOperator.values[user.tipe]}");
            return const MemberPage();
        }
      }),
  GetPage(name: '/penjualan', page: () => const PenjualanPage()),
  GetPage(
    name: '/penjualan/rincian',
    page: () {
      final TRANSAKSI item =
          (Get.arguments != null && Get.arguments['item'] != null)
              ? Get.arguments['item'] as TRANSAKSI
              : TRANSAKSI();
      return RincianPenjualan(item: item);
    },
  ),
  GetPage(
    name: '/penjualan/harian',
    page: () {
      // Mengambil argumen dari Get.arguments
      final KONTAK? sales =
          (Get.arguments != null && Get.arguments['sales'] != null)
              ? Get.arguments['sales'] as KONTAK?
              : null;

      final TRANSAKSI? invoice =
          (Get.arguments != null && Get.arguments['invoice'] != null)
              ? Get.arguments['invoice'] as TRANSAKSI?
              : null;

      final bool semuaNota =
          Get.arguments != null && Get.arguments['semuaNota'] != null
              ? Get.arguments['semuaNota']
              : true;

      return ListPenjualan(
          invoice: invoice, sales: sales, semuaNota: semuaNota);
    },
  ),
  GetPage(name: '/penjualan/baru', page: () => const PenjualanBaru()),
  GetPage(
      name: '/penjualan/baru/detail',
      page: () {
        if (Get.arguments != null) return PriceListPage(data: Get.arguments);
        dp('PriceListPage()');
        return PriceListPage();
      }),
  GetPage(
      name: '/penjualan/baru/rincian',
      page: () {
        return RincianDraftPenjualan2(Get.arguments);
      }),
  GetPage(
    name: '/piutang',
    page: () {
      // Mengambil argumen dari Get.arguments
      final String tit =
          (Get.arguments != null && Get.arguments['title'] != null)
              ? Get.arguments['title']
              : 'Daftar Piutang';
      final KONTAK? sales =
          (Get.arguments != null && Get.arguments['sales'] != null)
              ? Get.arguments['sales'] as KONTAK?
              : null;
      final TRANSAKSI? params =
          (Get.arguments != null && Get.arguments['params'] != null)
              ? Get.arguments['params'] as TRANSAKSI?
              : null;
      final bool tempoonly =
          Get.arguments != null && Get.arguments['tempoonly'] != null
              ? Get.arguments['tempoonly']
              : false;

      return ListPiutang(
          title: tit, sales: sales, params: params, tempoonly: tempoonly);
    },
  ),
  GetPage(
    name: '/piutang/group/kontak',
    page: () {
      final String tit =
          (Get.arguments != null && Get.arguments['title'] != null)
              ? Get.arguments['title']
              : 'Daftar Piutang';
      final KONTAK? sales =
          (Get.arguments != null && Get.arguments['sales'] != null)
              ? Get.arguments['sales'] as KONTAK?
              : null;
      final bool tempoonly =
          Get.arguments != null && Get.arguments['tempoonly'] != null
              ? Get.arguments['tempoonly']
              : false;
      return ListPiutangByKontak(
          title: tit, sales: sales, tempoonly: tempoonly);
    },
  ),
  GetPage(
      name: '/penjualan/pengaturan',
      page: () {
        TRANSAKSI? data;
        var pilihharga = true;
        var pilihlokasi = true;
        Function(LOKASI?)? onLokasiChanged;
        Function(HARGA?)? onHargaChanged;
        if (Get.arguments != null) {
          if (Get.arguments is TRANSAKSI) {
            data = Get.arguments as TRANSAKSI;
          } else {
            if (Get.arguments['data'] != null)
              data = Get.arguments['data'] as TRANSAKSI;
            if (Get.arguments['pilihharga'] != null)
              pilihharga = Get.arguments['pilihharga'] as bool;
            if (Get.arguments['pilihlokasi'] != null)
              pilihlokasi = Get.arguments['pilihlokasi'] as bool;
            if (Get.arguments['onLokasiChanged'] != null)
              onLokasiChanged = Get.arguments['onLokasiChanged'];
            if (Get.arguments['onHargaChanged'] != null)
              onHargaChanged = Get.arguments['onHargaChanged'];
          }
        }
        return PengaturanPenjualan(
            data: data,
            pilihharga: pilihharga,
            pilihlokasi: pilihlokasi,
            onLokasiChanged: onLokasiChanged,
            onHargaChanged: onHargaChanged);
      }),
  GetPage(
      name: '/penjualan/pembayaran1',
      page: () => PagePembayaran(Get.arguments)),
  GetPage(
      name: '/penjualan/pembayaran',
      page: () => Pembayaran2Page(Get.arguments)),
  GetPage(
      name: '/penjualan/pembayaranpiutang',
      page: () => PagePembayaranPiutang()),
  GetPage(
      name: '/penjualan/pembayaran/cetaknotapenjualan',
      page: () => PageCetakNotaPenjualan(Get.arguments)),
  GetPage(name: '/barang', page: () => const BarangPage()),
  GetPage(name: '/barang3', page: () => const BarangPage3()),
  GetPage(name: '/barang/detail', page: () => DetailBarangPage(Get.arguments)),
  GetPage(name: '/barang/kategori', page: () => BrgKategoriPage()),
  GetPage(
      name: '/barang/kategori/edit',
      page: () => BrgKategoriEditorPage(Get.arguments)),
  GetPage(name: '/barang/jenis', page: () => BrgJenisPage()),
  GetPage(
      name: '/barang/jenis/edit', page: () => BrgJenisEditor(Get.arguments)),
  GetPage(name: '/kontak', page: () => const PageKontak()),
  GetPage(name: '/kontak/baru', page: () => const PageKontakBaru()),
  GetPage(
    name: '/kontak/pelanggan/detail',
    page: () {
      final String judul =
          (Get.arguments != null && Get.arguments['judul'] != null)
              ? Get.arguments['judul']
              : 'Rincian Invoice Penjualan';
      final KONTAK? kontak =
          (Get.arguments != null && Get.arguments['kontak'] != null)
              ? Get.arguments['kontak'] as KONTAK?
              : null;
      return DetailPelanggan(judul: judul, kontak: kontak);
    },
  ),
  GetPage(name: '/pelunasan/piutang', page: () => const PelunasanPiutangPage()),
  GetPage(
      name: '/pelunasan/piutang/baru',
      page: () => const PelunasanPiutangBaru()),
  GetPage(
      name: '/piutang/pelunasan/rincian',
      page: () => RincianPembayaran(Get.arguments)),
/*   GetPage(name: '/permintaanmutasi', page: () => const VPermintaanPage()),
  GetPage(name: '/penjualan', page: () => const VPenjualan()),
  GetPage(name: '/ReqMutasiPage', page: () => const ReqMutasiPage()),
  GetPage(name: '/peletakan', page: () => const PeletakanPage()),
  GetPage(name: '/lokasi', page: () => LokasiPage()),
  GetPage(name: '/rak', page: () => RakPage()),
  GetPage(name: '/jenisbarang', page: () => BrgJenisPage()),
  GetPage(name: '/merkbarang', page: () => BrgMerkPage()),
  GetPage(name: '/kategoribarang', page: () => BrgKategoriPage()),
  GetPage(name: '/kelompokbarang', page: () => BrgKelompokPage()),
  GetPage(name: '/barang', page: () => const PageBarang()),
  
  GetPage(name: '/pelunasan', page: () => const PelunasanPageView()),
  GetPage(name: '/saldokas', page: () => const SaldoKasPage()),
  GetPage(name: '/saldokasglobal', page: () => const SaldoKasGlobalPage()),
  GetPage(name: '/saldokassales', page: () => const SaldoKasSales()),
  GetPage(name: '/blank', page: () => pageBlank),
  GetPage(name: '/setting', page: () => pageBlank),
  GetPage(name: '/opname', page: () => const OpnamePage()),
  GetPage(name: '/loading', page: () => showloading()),
  GetPage(name: '/piutang', page: () => const PiutangViewPage()),
  GetPage(name: '/mutasi', page: () => const VPermintaanPage()),
  GetPage(name: '/poin', page: () => const PoinPage()),
  GetPage(name: '/klasifikasi', page: () => KlasifikasiPage()), */
];/* 
Future showpageblank(context) async {
  final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => pageBlank));
  if (result != null) {
    pesanSukses(result.toString());
  }
}

Future showNotifikasi(context) async {
  final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => notifikasiPage));
  if (result != null) {
    pesanSukses(result.toString());
  }
}

Future showPenjualan(context) async {
  final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => penjualanViewPage));
  if (result != null) {
    pesanSukses(result.toString());
  }
}

Future showReqMutasi(context) async {
  final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => reqMutasi));
  if (result != null) {
    pesanSukses(result.toString());
  }
}

Future showListMutasi(context) async {
  final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => permintaanMutasiPage));
  if (result != null) {
    pesanSukses(result.toString());
  }
}

Future showpiutangpage(context) async {
  final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => piutangViewPage));
  if (result != null) {
    pesanSukses(result.toString());
  }
}

Future showpelunasanpage(context) async {
  final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => pelunasanPageView));
  if (result != null) {
    pesanSukses(result.toString());
  }
}

Future showpagesetting(context) async {
  final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => pageSetting));
  if (result != null) {
    pesanSukses(result.toString());
  }
}

Future showpagepermintaanmutasi(context) async {
  final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => permintaanMutasiPage));
  if (result != null) {
    pesanSukses(result.toString());
  }
}

Future showpagesaldokas(context) async {
  final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => const SaldoKasPage()));
  if (result != null) {
    pesanSukses(result.toString());
  }
}

Future showpageorderbaru(context) async {
  final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => pageorderbaru));
  if (result != null) {
    pesanSukses(result.toString());
  }
}

Future showpagemutasibaru(context) async {
/*   final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => pagemutasibaru));
  if (result != null) {
    pesanSukses( result.toString());
  } */
}

Future showpagecoba(context) async {
/*   final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => coba));
  if (result != null) {
    pesanSukses( result.toString());
  } */
}

Future showpagebarang(context) async {
  final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => pageBarang));
  if (result != null) {
    pesanSukses(result.toString());
  }
}

Future showpagekontak(context) async {
  final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => listPelanggan));
  if (result != null) {
    pesanSukses(result.toString());
  }
}

showpageLokasi(context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => pageLokasi));
}
 */