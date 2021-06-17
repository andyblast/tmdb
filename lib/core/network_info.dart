import 'dart:io';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl();

  @override
  Future<bool> get isConnected async {
    try {
      final list = await InternetAddress.lookup('google.com');
      if (list.isNotEmpty && list[0].rawAddress.isNotEmpty) {
        return Future<bool>.value(true);
      } else {
        return Future<bool>.value(false);
      }
    } on SocketException catch (_) {
      return Future<bool>.value(false);
    }
  }
}
