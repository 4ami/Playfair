import 'dart:developer';

import 'package:flutter/material.dart';

class EncryptionDecryptionTable extends StatefulWidget {
  const EncryptionDecryptionTable({super.key, required this.alphabet});
  final String alphabet;
  @override
  State<EncryptionDecryptionTable> createState() =>
      _EncryptionDecryptionTableState();
}

class _EncryptionDecryptionTableState extends State<EncryptionDecryptionTable> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 50,
        vertical: 10,
      ),
      child: Table(
        border: TableBorder.all(),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: _generateGrid(alphabet: widget.alphabet, context: context),
      ),
    );
  }
}

TableRow _tableRow(BuildContext context, List<String> alphabet) {
  return TableRow(
    children: alphabet
        .map(
          (e) => Text(
            e,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        )
        .toList(),
  );
}

List<TableRow> _generateGrid({
  required String alphabet,
  required BuildContext context,
}) {
  List<TableRow> rows = [];
  bool ij = false;
  // List<List<String>> alphabetMatrix = [];
  List<String> temp = [];
  for (int i = 0; i < alphabet.length; i++) {
    if (alphabet[i] == 'J' || alphabet[i] == 'I') {
      if (!ij) {
        temp.add('I/J');
        ij = true;
      }
    } else {
      temp.add(alphabet[i]);
    }
    if ((temp.length) % 5 == 0 && temp.isNotEmpty) {
      rows.add(_tableRow(context, temp));
      log('$temp');
      temp = [];
    }
  }
  return rows;
}
