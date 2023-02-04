import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:kkn_siwalan/src/utils/enums.dart';

class NetworkStatusServices {
  StreamController<NetworkStatus> networkStatusController =
      StreamController<NetworkStatus>();

  NetworkStatusServices() {
    Connectivity().onConnectivityChanged.listen((status) {
      networkStatusController.add(_getNetworkStatus(status));
    });
  }

  NetworkStatus _getNetworkStatus(ConnectivityResult status) {
    return status == ConnectivityResult.mobile ||
            status == ConnectivityResult.wifi
        ? NetworkStatus.online
        : NetworkStatus.offline;
  }
}
