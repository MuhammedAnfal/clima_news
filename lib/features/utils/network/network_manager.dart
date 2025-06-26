import 'dart:async';

import 'package:clima_news/features/utils/constants/string_constants.dart';
import 'package:clima_news/features/utils/popups/loaders.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NetworkManager extends GetxController {
  static NetworkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubScription;
  final Rx<ConnectivityResult> _connectionStatus = ConnectivityResult.none.obs;

  //-- initialize network manage and setup stream to countinually check connection status
  @override
  void onInit() {
    super.onInit();
    _connectivitySubScription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );
  }

  //-- update the connection status based on the changes in connectivity and show relevant popups for internet connection
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _connectionStatus.value = result;
    if (_connectionStatus.value == ConnectivityResult.none) {
      Loaders.customToast(message: AppStrings.noInternetText);
    }
  }

  //-- check the internet connection status
  //-- return true if connected ,false otherwise
  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      if (result == ConnectivityResult.none) {
        return false;
      } else {
        return true;
      }
    } on PlatformException catch (_) {
      return false;
    }
  }

  //-- dispose or close the active connectivity stream
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    _connectivitySubScription.cancel();
  }
}
