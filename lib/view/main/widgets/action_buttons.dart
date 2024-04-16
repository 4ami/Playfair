import 'package:flutter/material.dart';

class ActionButtons extends StatefulWidget {
  const ActionButtons(
      {super.key,
      required this.onPressedDecryption,
      required this.onPressedEncryption});
  final VoidCallback onPressedEncryption;
  final VoidCallback onPressedDecryption;
  @override
  State<ActionButtons> createState() => _ActionButtonsState();
}

class _ActionButtonsState extends State<ActionButtons> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _encryptButton(callback: widget.onPressedEncryption),
          const SizedBox(height: 50),
          _decryptButton(callback: widget.onPressedDecryption),
        ],
      ),
    );
  }
}

ElevatedButton _decryptButton({required VoidCallback callback}) {
  return ElevatedButton.icon(
    onPressed: callback,
    icon: const Icon(Icons.lock_open),
    label: const Text("Decrypt"),
    style: _buttonStyle().copyWith(
      foregroundColor: const MaterialStatePropertyAll(Colors.black),
      backgroundColor: MaterialStatePropertyAll(Colors.greenAccent[100]),
    ),
  );
}

ElevatedButton _encryptButton({required VoidCallback callback}) {
  return ElevatedButton.icon(
    onPressed: callback,
    icon: const Icon(Icons.lock),
    label: const Text("Encrypt"),
    style: _buttonStyle().copyWith(
      foregroundColor: const MaterialStatePropertyAll(Colors.black),
      backgroundColor: MaterialStatePropertyAll(Colors.redAccent[100]),
    ),
  );
}

ButtonStyle _buttonStyle() {
  return ButtonStyle(
    backgroundColor: const MaterialStatePropertyAll(Colors.white),
    shadowColor: MaterialStatePropertyAll(Colors.grey[200]),
    overlayColor: MaterialStatePropertyAll(Colors.teal[50]),
    surfaceTintColor: const MaterialStatePropertyAll(Colors.transparent),
  );
}
