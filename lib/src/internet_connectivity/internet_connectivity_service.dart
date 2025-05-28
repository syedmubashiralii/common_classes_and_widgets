import 'package:connectivity_plus/connectivity_plus.dart';

class InternetConnectivityService {
  static final Connectivity _connectivity = Connectivity();
  static Stream<List<ConnectivityResult>> get connectivityStream =>
      _connectivity.onConnectivityChanged;

  static Future<bool> isConnected() async {
    final result = await _connectivity.checkConnectivity();
    return !result.contains(ConnectivityResult.none);
  }
}