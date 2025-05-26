// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

/* import 'dart:async';
import 'dart:developer' as developer;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';

final Connectivity _connectivity = Connectivity();
List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
Future<void> initConnectivity() async {
  late List<ConnectivityResult> result;
  // Platform messages may fail, so we use a try/catch PlatformException.
  try {
    result = await _connectivity.checkConnectivity();
  } on PlatformException catch (e) {
    developer.log('Couldn\'t check connectivity status', error: e);
    return;
  }

  // If the widget was removed from the tree while the asynchronous platform
  // message was in flight, we want to discard the reply rather than calling
  // setState to update our non-existent appearance.

  return _updateConnectionStatus(result);
}

Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
  _connectionStatus = result;
}
 */