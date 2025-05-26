part of 'env.dart';

insertRepo2(String label, String val) async {
  /*  await dBase.transaction((txn) async {
    var value = {'label': label, 'value': val};
    await txn.insert('repo', value, conflictAlgorithm: ConflictAlgorithm.replace);
    Repo(label: label, value: val);
    final i = listRepo.indexWhere((element) => element.label == label);
    if (i > 0) listRepo.removeAt(i);
    listRepo.add(Repo(label: label, value: val));
  }); */
}

const periodex = {'periode': '1'};
const sf = 0.8;

enum Kategori { kebawah, kesamping }

enum Varian { kebawah, group }

enum GambarPenjualan { tampil, tidak }

enum GambarPembelian { tampil, tidak }

enum UrutanKeranjang { abjad, inputan }

enum NamaOutlet { ya, tidak }

Kategori ptKategori = Kategori.kesamping;
Varian ptVarian = Varian.group;
GambarPenjualan ptGambarPenjualan = GambarPenjualan.tampil;
GambarPembelian ptGambarPembelian = GambarPembelian.tampil;
UrutanKeranjang ptUrutanKeranjang = UrutanKeranjang.inputan;
NamaOutlet ptNamaOutlet = NamaOutlet.ya;
DateTime awal = DateTime(DateTime.now().year, DateTime.now().month);
DateTime akhir = DateTime.now();
bool showMerk = true;
bool stokPembelian = true;
bool stokPenjualan = true;
