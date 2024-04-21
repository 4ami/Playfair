import 'package:flutter/material.dart';

class ActionButtons extends StatefulWidget {
  const ActionButtons({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  State<ActionButtons> createState() => _ActionButtonsState();
}

class _ActionButtonsState extends State<ActionButtons> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _encryptButton(callback: widget.onPressed),
        ],
      ),
    );
  }
}

ElevatedButton _encryptButton({required VoidCallback callback}) {
  return ElevatedButton.icon(
    onPressed: callback,
    icon: Icon(
      Icons.edit_document,
      color: Colors.grey[200]!,
    ),
    label: const Text("Proccess Text"),
    style: _buttonStyle().copyWith(
      foregroundColor: const MaterialStatePropertyAll(Colors.black),
      backgroundColor: MaterialStatePropertyAll(Colors.greenAccent[400]),
    ),
  );
}

ButtonStyle _buttonStyle() {
  return ButtonStyle(
    backgroundColor: const MaterialStatePropertyAll(Colors.white),
    shadowColor: MaterialStatePropertyAll(Colors.grey[200]),
    overlayColor: MaterialStatePropertyAll(Colors.orangeAccent[400]),
    surfaceTintColor: const MaterialStatePropertyAll(Colors.transparent),
  );
}
