import 'package:flutter/material.dart';
import 'widget_keyboard.dart';
import 'pin_controller.dart';

class MinfinPinCode extends StatefulWidget {
  //final String title;
  const MinfinPinCode({Key? key}) : super(key: key);

  @override
  State<MinfinPinCode> createState() => _MinfinPinCodeState();
}

class _MinfinPinCodeState extends State<MinfinPinCode> {
  late final controller = PinController(
    () => setState(() {}),
    () => print("SUCCESSSSSSSS"),
  );

  String get desc {
    if (controller.hasError) return "Mos kelmadi :(";
    if (controller.hasCode) return "Pinkodingizni kiriting";
    if (controller.code.isEmpty) return "Pinkodingizni o'rnating";
    return "Qayta kiriting";
  }

  @override
  void initState() {
    controller.load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WidgetKeyboard(
        title: "Xizmat Safari",
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
