import 'package:ljm/provider/models/termin.dart';
import 'package:ljm/provider/models/user.dart';
import 'package:ljm/provider/connection.dart';
import 'package:ljm/provider/models/harga.dart';
import 'package:ljm/provider/models/kontak.dart';
import 'package:ljm/provider/models/lokasi.dart';

Future<HARGA?> getHargaByID(String? kode) async {
  if (kode != null) {
    final res = await executeSql("select * from harga where kode = '$kode'");
    if (res.isNotEmpty) return HARGA.fromMap(res.first);
  }
  return null;
}

Future<LOKASI?> getLokasiByID(int? id) async {
  if (id != null) {
    final res = await executeSql('select * from lokasi where id = $id');
    if (res.isNotEmpty) return LOKASI.fromMap(res.first);
  }
  return null;
}

Future<KONTAK?> getKontakByID(int? id) async {
  if (id != null) {
    final res = await executeSql('select * from kontak where id = $id');
    if (res.isNotEmpty) {
      var result = KONTAK.fromMap(res.first);

      return result;
    }
  }
  return null;
}

Future<TERMIN?> getTerminByID(String? kode) async {
  if (kode != null) {
    final res = await executeSql("select * from termin where kode = '$kode'");
    if (res.isNotEmpty) {
      var result = TERMIN.fromMap(res.first);

      return result;
    }
  }
  return null;
}

Future<User?> getUserByID(String? email) async {
  if (email != null) {
    final res = await executeSql("""
  select inet.*,
  ( SELECT 
      GROUP_CONCAT(
        CONCAT(
          '{"id": "', k.id, 
          '", "kode": "', k.kode, 
          '", "nama": "', k.nama,
          '"}')
        SEPARATOR ','
      )
      FROM kontak k WHERE k.id = inet.idkontak
  ) AS kontak,
   concat('[',
  ( SELECT 
      GROUP_CONCAT(
        CONCAT(
          '{"idlokasi": "', x.id, 
          '", "kode": "', x.kode, 
          '", "nama": "', x.nama,
          '"}')
        SEPARATOR ','
      )
    FROM 
    (
      select l.id, l.kode, l.nama from inetakseslokasi k inner join lokasi l on l.id = k.idlokasi
      WHERE k.email = '$email' and id not in (select idlokasi from inet where email = '$email')
      union all
      select l.id, l.kode, l.nama  FROM lokasi l where l.id = (select idlokasi from inet where email = '$email')
    ) x 
    
  ), ']')
   AS akseslokasi,
   concat('[',
  ( SELECT 
      GROUP_CONCAT(
        CONCAT(
          '{"id": "', x.kode, 
          '", "rekening": "', x.akun, 
          '"}')
        SEPARATOR ','
      )
    FROM 
    inetakseskas k inner join rekening x on x.kode = k.id
    WHERE k.email = inet.email    
    
  ), ']')
   AS akseskas

 from inet where email = '$email'
    
    """);
    if (res.isNotEmpty) {
      var result = User.fromMap(res.first);
      return result;
    }
  }
  return null;
}
