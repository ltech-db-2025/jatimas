import 'package:flutter/foundation.dart';
import 'package:ljm/env/env.dart';
import 'package:ljm/provider/models/transaksi/transaksi.dart';
import 'package:ljm/tools/env.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String? csrfToken;
Future<String?> getCsrfToken() async {
  final response = await http.get(Uri.https('leontech.luckyjayagroup.com', '/csrf-token'));
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data['csrf_token'];
  }
  return null;
}

Future<IResultSet?> executeSql2(
  String sql, [
  Map<String, dynamic>? params,
  bool iterable = false,
]) async {
  var kon = await MySQLConnection.createConnection(
    host: Env.DATABASE_HOST,
    port: Env.DATABASE_PORT,
    userName: Env.DATABASE_USER,
    password: Env.DATABASE_PASSWORD,
    databaseName: Env.DATABASE_NAME,
    secure: false,
  );
  await kon.connect();
  final res = await kon.execute(sql, params, iterable);
  await kon.close();
  return res;
}

/* Future<List> executeSql(String sql) async {
  if (kIsWeb) {
    try {
      var response = await http.get(Uri.https(Env.urlexc_base, Env.urlexc_add2, {'req': encryptData(sql)}));
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        return jsonResponse;
      } else {
        dp('Request failed with status: ${response.statusCode}.');
        return [];
      }
    } catch (e) {
      dp(e.toString());
      dp("sql: $sql");
      return [];
    }
  } else {
    try {
      var kon = await MySQLConnection.createConnection(
        host: Env.DATABASE_HOST,
        port: Env.DATABASE_PORT,
        userName: Env.DATABASE_USER,
        password: Env.DATABASE_PASSWORD,
        databaseName: Env.DATABASE_NAME,
        secure: false,
      );
      await kon.connect();
      final res = await kon.execute(sql);
      await kon.close();
      List<Map<String, dynamic>> data = [];
      if (res.isNotEmpty) {
        for (var a in res.rows) {
          data.add(a.assoc());
        }
      }

      return data;
    } catch (e) {
      dp(sql);
      dp("errrrrooor: ${e.toString()}");
      return [];
    }
  }
} */
Future<List> executeSql(String sql) async {
  try {
    var response = await http.get(Uri.https(Env.urlexc_base, Env.urlexc_add2, {'req': encryptData(sql)}));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse is Map<String, dynamic>) {
        return [jsonResponse];
      }
      return jsonResponse;
    } else {
      dp('Request failed with status: ${response.statusCode}.');
      return [];
    }
  } catch (e, stackTrace) {
    dp("error (executeSql3) : \n $e");
    dp("stackTrace (executeSql3) : $stackTrace");
    return [];
  }
}

Future<List> executeSql3(String sql) async {
  try {
    var response = await http.get(Uri.https(Env.urlexc_base, Env.urlexc_add2, {'req': encryptData(sql)}));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse is Map<String, dynamic>) {
        return [jsonResponse];
      }
      return jsonResponse;
    } else {
      dp('Request failed with status: ${response.statusCode}.');
      return [];
    }
  } catch (e, stackTrace) {
    dp("error (executeSql3) : \n $e");
    dp("stackTrace (executeSql3) : $stackTrace");
    return [];
  }
}

Future<TRANSAKSI?> draftBaru() async {
  try {
    var response = await http.get(Uri.https(Env.homeleontech, 'draft/baru'));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse is Map<String, dynamic>) {
        return TRANSAKSI.fromMap(jsonResponse);
      }
      return TRANSAKSI.fromMap((jsonResponse as List).first);
    } else {
      dp('Request failed with status: ${response.statusCode}.');
      return null;
    }
  } catch (e, stackTrace) {
    dp("error (executeSql3) : \n $e");
    dp("stackTrace (executeSql3) : $stackTrace");
    return null;
  }
}

Future<TRANSAKSI?> draftToTrans(int id) async {
  try {
    var response = await http.get(Uri.https(Env.homeleontech, '/draft/totrans/$id'));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse is Map<String, dynamic>) {
        return TRANSAKSI.fromMap(jsonResponse);
      }
      if (jsonResponse is List) return TRANSAKSI.fromMap(jsonResponse.first);
      return TRANSAKSI.fromJson(jsonResponse);
    } else {
      dp('Request failed with status: ${response.statusCode}.');
      return null;
    }
  } catch (e, stackTrace) {
    dp("draftToTrans\nerror :\n $e\nstackTrace : $stackTrace");
    return null;
  }
}

Future<TRANSAKSI?> updateBayar(TRANSAKSI data) async {
  try {
    if (csrfToken == null) {
      csrfToken = await getCsrfToken();
    }

    var response = await http.post(Uri.https(Env.homeleontech, '/penjualan/update-pembayaran'),
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-TOKEN': csrfToken!,
        },
        body: encryptData(data.toJson()));
    if (response.statusCode == 200) {
      try {
        var jsonResponse = json.decode(response.body);
        if (jsonResponse is Map<String, dynamic>) {
          return TRANSAKSI.fromMap(jsonResponse);
        }
        if (jsonResponse is List) {
          if (jsonResponse.isEmpty) {
            pesanError('Transaksi Tidak di temukan');
            return null;
          }

          return TRANSAKSI.fromMap(jsonResponse.first);
        }
        return TRANSAKSI.fromJson(jsonResponse);
      } catch (e, stackTrace) {
        dp("response.body :\n ${response.body}\n${data.toJson()}\nstackTrace : $stackTrace");
        return null;
      }
    } else {
      dp('Request failed with status: ${response.statusCode}.');
      return null;
    }
  } catch (e, stackTrace) {
    dp("updateBayar\nerror :\n $e\nstackTrace : $stackTrace");
    return null;
  }
}

Future<List?> updateData(String data, String path) async {
  try {
    if (csrfToken == null) {
      csrfToken = await getCsrfToken();
    }

    var response = await http.post(Uri.https(Env.homeleontech, path),
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-TOKEN': csrfToken!,
        },
        body: encryptData(data));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse is Map<String, dynamic>) {
        return [jsonResponse];
      }
      return jsonResponse;
    } else {
      dp('Request failed with status: ${response.statusCode}.');
      return null;
    }
  } catch (e, stackTrace) {
    dp("updateBayar\nerror :\n $e\nstackTrace : $stackTrace");
    return null;
  }
}

Future<bool> hapusData(String data, String path) async {
  try {
    if (csrfToken == null) csrfToken = await getCsrfToken();
    var response = await http.delete(Uri.https(Env.homeleontech, path), headers: {'Content-Type': 'application/json', 'X-CSRF-TOKEN': csrfToken!}, body: encryptData(data));
    if (response.statusCode == 200) {
      return true;
    } else {
      dp('Request failed with status: ${response.statusCode}.');
    }
  } catch (e, stackTrace) {
    dp("updateBayar\nerror :\n $e\nstackTrace : $stackTrace");
  }
  return false;
}

Future<List?> getUrlData(String path, [Map<String, dynamic>? query]) async {
  try {
    if (csrfToken == null) {
      csrfToken = await getCsrfToken();
    }

    var response = await http.get(
      Uri.https(Env.homeleontech, path, query),
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-TOKEN': csrfToken!,
      },
    );
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse is Map<String, dynamic>) {
        return [jsonResponse];
      }
      return jsonResponse;
    } else {
      dp('Request failed with status: ${response.statusCode}.');
      return null;
    }
  } catch (e, stackTrace) {
    dp("getUrlData\nerror :\n $e\nstackTrace : $stackTrace");
    return null;
  }
}
