import 'package:flutter/material.dart';

const _keys = <String>[
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",
  "*",
  "0",
  "#",
];

class WidgetKeyboard extends StatelessWidget {
  final String title;
  final String desc;
  final String text;
  final bool error;
  final bool hasBiometric;
  final int length;
  final Color backgroundButton;
  final Color colorText;
  final Color colorPrimary;
  final Color colorError;
  final Function(String key)? onTapKeys;
  final Function()? onTapFinger;
  final Function()? onTapClear;

  const WidgetKeyboard({
    Key? key,
    required this.title,
    required this.desc,
    this.text = "",
    this.error = false,
    this.hasBiometric = true,
    this.length = 4,
    this.backgroundButton = const Color(0xFFE9EEF8),
    this.colorText = Colors.black,
    this.colorPrimary = Colors.blue,
    this.colorError = Colors.redAccent,
    this.onTapKeys,
    this.onTapFinger,
    this.onTapClear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.15,
      ),
      child: Column(
        children: [
          const Spacer(),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: colorText,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: desc.isNotEmpty ? 12 : 0),
          desc.isEmpty
              ? const SizedBox()
              : Text(
                  desc,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: colorText,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
          const SizedBox(height: 20),
          SizedBox(
            height: 20,
            child: ListView.separated(
              itemCount: length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (_, i) => const SizedBox(width: 10),
              itemBuilder: (_, i) => Container(
                width: 15,
                decoration: BoxDecoration(
                  color: text.length > i
                      ? (error ? colorError : colorPrimary)
                      : backgroundButton,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: GridView.builder(
              itemCount: _keys.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (_, i) {
                if (_keys[i] == "*") {
                  if (!hasBiometric) return const SizedBox();
                  return GestureDetector(
                    onTap: onTapFinger,
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: backgroundButton,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        Icons.fingerprint_rounded,
                        color: colorPrimary,
                        size: kToolbarHeight * 0.8,
                      ),
                    ),
                  );
                }
                if (_keys[i] == "#") {
                  return GestureDetector(
                    onTap: onTapClear,
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: backgroundButton,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        Icons.backspace_outlined,
                        color: colorText.withOpacity(text.isEmpty ? 0.2 : 1),
                        size: kToolbarHeight * 0.5,
                      ),
                    ),
                  );
                }
                return GestureDetector(
                  onTap: () => onTapKeys?.call(_keys[i]),
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: backgroundButton,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _keys[i],
                      style: TextStyle(
                        color: colorText,
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
