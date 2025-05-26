import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:get/get.dart';
import '../tools/env.dart';

tryjsonDecode(s) {
  try {
    var kv = s.substring(0, s.length - 1).substring(1).split(",");
    final Map<String, dynamic> pairs = {};

    for (int i = 0; i < kv.length; i++) {
      var thisKV = kv[i].split(":");
      pairs[thisKV[0]] = thisKV[1].trim();
    }
    return pairs;
  } catch (e) {
    dp("$e");
    return null;
  }
}

onMessage(_) {
  var x = tryjsonDecode(_);

  if (x == null) {
    dp("null ${_.runtimeType}: $_");
  } else {
    dp("id: ${x['id']}");
    dp("kdtrans: ${x['kdtrans']}");
    dp("x: ${x['x']}");
  }
}

onCheckid(int id) {
  if (id == getidKontak()) {
    socket.emit('absena', 1);
  }
}

_onConnect(_) {
  var idkontak = getidKontak();
  dp('connect: ${socket.id}');
  socket.emit('msg', 'test');
  if (idkontak > 0) {
    socket.emit('absen', idkontak);
  }
  _setsocketConnected();
}

initialSocket() {
  socket = io.io('https://luckyjayagroup.com:3000', {
    'transports': ['websocket'],
    'autoConnect': true,
  });
  socket.onConnect((_) => _onConnect(_));

  socket.onDisconnect((_) {
    dp('disconnect');
    _setsocketConnected(false);
  });
  socket.on('fromServer', (_) => onMessage(_));
  socket.on('absen', (_) => onCheckid(_));

/*   socket.onAny((eventName, x) {
    dp("$eventName: $x");
  }); */
  socket.connect();
}

connectToSocket() {
  try {
    dp("connectToSocket");
    initialSocket();
  } catch (e) {
    dp("Errrrorrr caak: $e");
    _setsocketConnected(false);
  }
}

sendMessage(String message) {
  socket.emit("pesan", {"sip": getidKontak(), "kpd": "kamu", "pesan": message});
}

sendtoLokasi(String message) {
  socket.emit("pesan", {"sip": getidKontak(), "idlokasi": "gudang", "pesan": message});
}

_setsocketConnected([bool value = true]) {
  dp("_setsocketConnected:$value");
  repo.socketconnected.value = value;
  repo.update();
}

class RepoController extends GetxController {
  RepoController();
  var socketconnected = false.obs;

  setsocketConnected([bool value = false]) {
    dp("socket.connected -> ${socket.connected}");
    if (value) {
      initialSocket();
    } else {
      socket.disconnect();
    }
    dp("$value -> ${socket.connected}");
    update();
  }
}
