import 'package:ljm/env/env.dart';

import 'env.dart';
/* kirimPesan(int id, String title, dynamic body, String to, {Map<String, dynamic>? payload}) async {
  payload = payload ?? {"idpengirim": opr.idkontak, "idlokasi": opr.idlokasi};
  dp("to: $to, Payload: $payload");
  String peringatan = "";
  final data = {
    "notification": {"title": title, "body": body, "click_action": "FLUTTER_NOTIFICATION_CLICK"},
    "data": {
      "id": id,
      "title": title,
      "content": {"id": id, "title": title, "body": body, "payload": payload, "channelKey": "big_picture", "notificationLayout": "NotificationLayout.BigPicture", "showWhen": "true", "autoCancel": "false", "privacy": "Private"}
    },
    "to": to
  };
  final aheaders = {
    'content-type': 'application/json',
    'Authorization': auth,
  };
  BaseOptions aoptions = BaseOptions(connectTimeout: 5000, receiveTimeout: 3000, headers: aheaders);

  try {
    final response = await Dio(aoptions).post(urlMsg, data: data);
    if (response.statusCode == 200) {
      peringatan = 'Permintaan terkirim';
    } else {
      peringatan = 'notification sending failed';

      // on failure do sth
    }
  } catch (e) {
    peringatan = "Permintaan gagal terkirim\n$e" "Permintaan gagal terkirim\n$e";
    dp('exception $e');
    pesanError(peringatan);
  }
  return peringatan;
} */

Future<bool> kirimpesan(String to, int id, String groupKey, {String body = 'body', Map<String, dynamic>? payload, String layout = 'basic_channels'}) async {
  var resBool = false;
  payload ??= {};
  Map<String, String> sip = {"idpengirim": user.idkontak.toString(), "idlokasi": user.idlokasi.toString()};
  payload.addAll(sip);
  final aheaders = {
    'content-type': 'application/json',
    'Authorization': Env.AUTH,
  };
  Map<String, dynamic> data = {
    "to": "/topics/$to",
    "mutable_content": true,
    "content_available": true,
    "priority": "high",
    "data": {
      "id": id.toString(),
      "content": {
        "id": id.toString(),
        "channelKey": 'basic_channel',
        "groupKey": groupKey,
        "criticalAlert": true,
        "body": body,
        "payload": payload,
        "notificationLayout": layout,
        "showWhen": "true",
        "autoCancel": "false",
        "privacy": "Private",
      }
    },
  };

  final response = await postResponse(urlMsg, data, contentType: 'application/json', aheaders: aheaders);
  if (response != null) {
    pesan = 'Permintaan terkirim';
    dp('Pesan terkirim ke $to');
    resBool = true;
    return true;
  } else {
    dp('notification sending failed');
  }
  return resBool;
}

/* listenMessage() async {
  var idlokasi = getidLokasi();
  var idkontak = getidKontak();
  if (!kIsWeb) {
    if (Platform.isAndroid) {
      await FirebaseMessaging.instance.subscribeToTopic('$il$idlokasi');
      dp("subscribeToTopic($il$idlokasi)");
      await FirebaseMessaging.instance.subscribeToTopic('$ip$idkontak');
      dp("subscribeToTopic($ip$idkontak)");
      await FirebaseMessaging.instance.subscribeToTopic('umum');
      dp("subscribeToTopic(umum)");
    }
  }
} */

/* unlistenMessage() async {
  if (!kIsWeb) {
    if (Platform.isAndroid) {
      await FirebaseMessaging.instance.unsubscribeFromTopic('$il${getidLokasi()}');
      await FirebaseMessaging.instance.unsubscribeFromTopic('$ip${getidKontak()}');
      await FirebaseMessaging.instance.unsubscribeFromTopic('umum');
    }
  }
}
 */
