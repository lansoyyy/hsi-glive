import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

class AuthenticationService {
  final LocalAuthentication auth = LocalAuthentication();

  authchack(context, String path) async {
    List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();

    if (Platform.isIOS) {
      if (availableBiometrics.contains(BiometricType.face)) {
        startBioMetricAuth(context, "Use Face ID", path);
      } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
        startBioMetricAuth(context, "Use Touch ID", path);
      }
    } else {
      startBioMetricAuth(context, "Use Fingerprint", path);
    }
  }

  startBioMetricAuth(context, String message, String path) async {
    try {
      bool didAuthenticate = await auth.authenticate(localizedReason: message);
      if (didAuthenticate) {
        Get.toNamed(path);
        // your login function
      } else {
        // showSnackBar(context, 'failed to authenticate');
      }
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Error: ${e.message}");
      }
    }
  }
}
