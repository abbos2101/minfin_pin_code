import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';

class BiometricAuth {
  final _auth = LocalAuthentication();

  Future<bool> isSupported() async {
    try {
      if (await _auth.canCheckBiometrics || await _auth.isDeviceSupported()) {
        final list = await _auth.getAvailableBiometrics();
        return list.contains(BiometricType.strong) ||
            list.contains(BiometricType.fingerprint) ||
            list.contains(BiometricType.face);
      } else {
        return false;
      }
    } catch (_) {
      return false;
    }
  }

  Future<bool> isAuthenticated() async {
    try {
      return await _auth.authenticate(
        localizedReason: 'Come In',
        options: const AuthenticationOptions(biometricOnly: true),
      );
    } catch (e) {
      if (kDebugMode) print("MinfinPinCode(biometric_auth): $e");
      return false;
    }
  }
}
