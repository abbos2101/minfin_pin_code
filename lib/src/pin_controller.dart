//SetStatening UI va logika ajratilgan ko'rinishi
import 'package:flutter/foundation.dart';

import 'biometric_auth.dart';
import 'pin_pref.dart';

class PinController {
  final Function() onSuccess;
  final Function() _changed; //buyerga pagedan setState((){}) berib yuboriladi
  //late final controller = PinController(() => setState(() {}));

  final _auth = BiometricAuth();
  final _pref = PinPref();

  PinController(this._changed, this.onSuccess);

  bool _hasBiometric = false;
  bool _hasError = false;
  bool _hasCode = false;
  String _text = "";
  String _code = "";

  Future<void> load() async {
    _hasBiometric = await _auth.isSupported();
    _changed();
    await _pref.init();
    _code = _pref.code;
    _changed();
    if (_code.length == 4) {
      _hasCode = true;
      _changed();
      if (_hasBiometric) await onTapFinger();
    }
  }

  void addKeys(String key) {
    _hasError = false;
    if (_text.length < 4) {
      _text += key;
      _changed();
      if (_text.length == 4) {
        if (_code.length == 4) {
          if (_code == _text) {
            _pref.saveCode(_code);
            myPrint("Saved PinCode");
            myPrint("PinCode = ${_pref.code}");
            onSuccess();
          } else {
            _hasError = true;
            _changed();
          }
        } else {
          _code = _text;
          _text = "";
          _changed();
        }
      }
    }
    myPrint(_text);
  }

  void removeKeys() {
    if (_text.isNotEmpty) {
      _hasError = false;
      _text = _text.substring(0, _text.length - 1);
      _changed();
    }
  }

  Future<void> onTapFinger() async {
    if (_hasBiometric && await _auth.isAuthenticated()) {
      myPrint("Login via FaceId");
      myPrint("PinCode = ${_pref.code}");
      onSuccess();
    }
  }

  bool get hasBiometric => _hasBiometric;

  bool get hasError => _hasError;

  bool get hasCode => _hasCode;

  String get text => _text;

  String get code => _code;
}

void myPrint(dynamic msg) {
  if (kDebugMode) print("MinfinPinCode: $msg");
}
