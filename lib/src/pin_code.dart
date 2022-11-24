import 'package:flutter/material.dart';
import 'widget_keyboard.dart';
import 'pin_controller.dart';
import 'pin_pref.dart';

class MinfinPinCode extends StatefulWidget {
  final String title;
  final String descEnterPin;
  final String descSetPin;
  final String descRepeatPin;
  final String descNotEqual;
  final Function()? onFail;
  final Function()? onSuccess;

  const MinfinPinCode._({
    Key? key,
    this.title = "Pin Kod",
    this.descEnterPin = "Pinkodingizni kiriting",
    this.descSetPin = "Pinkodingizni o'rnating",
    this.descRepeatPin = "Qayta kiriting",
    this.descNotEqual = "Mos kelmadi :(",
    this.onFail,
    this.onSuccess,
  }) : super(key: key);

  static MinfinPinCode? _instance;

  static void ensureInitialized({
    String title = "Pin Kod",
    String descEnterPin = "Pinkodingizni kiriting",
    String descSetPin = "Pinkodingizni o'rnating",
    String descRepeatPin = "Qayta kiriting",
    String descNotEqual = "Mos kelmadi :(",
    Function()? onFail,
    Function()? onSuccess,
  }) {
    _instance = MinfinPinCode._(
      title: title,
      descEnterPin: descEnterPin,
      descSetPin: descSetPin,
      descRepeatPin: descRepeatPin,
      descNotEqual: descNotEqual,
      onFail: onFail,
      onSuccess: onSuccess,
    );
  }

  static MinfinPinCode getInstance() {
    if (_instance != null) return _instance!;
    throw "MinfinOneIDPage ensureInitialized qilinmagan";
  }

  ;

  static Future<void> clear() async {
    final pref = PinPref();
    await pref.init();
    pref.saveCode("");
  }

  @override
  State<MinfinPinCode> createState() => _MinfinPinCodeState();
}

class _MinfinPinCodeState extends State<MinfinPinCode> {
  late final controller = PinController(
        () => setState(() {}),
        () => widget.onSuccess?.call(),
  );

  String get desc {
    if (controller.hasError) return widget.descNotEqual;
    if (controller.hasCode) return widget.descEnterPin;
    if (controller.code.isEmpty) return widget.descSetPin;
    return widget.descRepeatPin;
  }

  @override
  void initState() {
    controller.load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (controller.hasError) {
      widget.onFail?.call();
    }
    return Scaffold(
      body: WidgetKeyboard(
        title: widget.title,
        desc: desc,
        text: controller.text,
        error: controller.hasError,
        hasBiometric: controller.hasBiometric,
        onTapClear: () => controller.removeKeys(),
        onTapFinger: () => controller.onTapFinger(),
        onTapKeys: (key) => controller.addKeys(key),
      ),
    );
  }
}
