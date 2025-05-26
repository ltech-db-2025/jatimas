// ignore_for_file: unused_element

part of '../main.dart';

/* Future<void> _initConnectivity(_AppState state) async {
  ConnectivityResult result;
  // Platform messages may fail, so we use a try/catch PlatformException.
  try {
    result = await _connectivity.checkConnectivity();
    return _updateConnectionStatus(state, result);
  } on PlatformException catch (e) {
    dp('Kegagalan Cek Koneksi: $e');
  }
  if (!state.mounted) {
    return Future.value(null);
  }
} */

Future<void> updateConnectionStatus(List<ConnectivityResult> result) async {
  if (result.contains(ConnectivityResult.none)) {
    koneksi = 'Failed to get connectivity.';
    isOnline = false;
  } else {
    koneksi = result.toString().replaceFirst('ConnectivityResult.', '');
    isOnline = true;
  }
}
