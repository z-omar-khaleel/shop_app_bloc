import 'package:connectivity/connectivity.dart';

ConnectivityResult networkState() {
  Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
    print('$result is result');
    return result;
  });
}
