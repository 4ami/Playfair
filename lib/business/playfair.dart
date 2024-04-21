import 'dart:developer';

import 'package:playfair/business/build_grid.dart';

class Playfair extends BuildGrid {
  const Playfair({required super.key});

  List<String> divideMessage({required String message}) {
    message = message.replaceAll(' ', '').toUpperCase();
    if (message.length % 2 != 0) {
      message += 'Z';
    }
    log('Remove Spaces + Capitalize: $message');
    List<String> temp = [];
    temp = _padSimilarities(message: message);
    return temp;
  }

  List<String> _padSimilarities({required String message}) {
    List<String> temp = [];

    int i = 0;
    while (i < message.length - 1) {
      if (message[i] == message[i + 1]) {
        temp.add('${message[i]}Z');
        i++;
      } else {
        temp.add(message.substring(i, i + 2));
        i += 2;
      }
      log('Message Proccess [${(i)}]: $temp');
    }
    return temp;
  }

  String encrypt({required List<String> message, required String key}) {
    String cipher = '';
    List<List<String>> keyMatrix = [];
    key = key.padRight((key.length / 5).ceil() * 5);
    for (int i = 0; i < key.length; i += 5) {
      keyMatrix.add(key.substring(i, i + 5).split(''));
    }
    List<String> temp = [];
    log('Message: $message');
    for (String group in message) {
      log('Group: $group');
      String fLetter = group[0] == 'J' ? 'I' : group[0];
      String sLetter = group[1] == 'J' ? 'I' : group[1];

      int r1 = -1, col1 = -1, r2 = -1, col2 = -1;
      for (int i = 0; i < 5; i++) {
        if (keyMatrix[i].contains(fLetter)) {
          r1 = i;
          col1 = keyMatrix[i].indexOf(fLetter);
        }
        if (keyMatrix[i].contains(sLetter)) {
          r2 = i;
          col2 = keyMatrix[i].indexOf(sLetter);
        }
      }
      if (r1 != -1 && col1 != -1 && r2 != -1 && col2 != -1) {
        if (r1 == r2) {
          temp.add(
            '${keyMatrix[r1][(col1 + 1) % 5]}${keyMatrix[r2][(col2 + 1) % 5]}',
          );
          log('Added: ${temp.last}');
        } else if (col1 == col2) {
          temp.add(
            '${keyMatrix[(r1 + 1) % 5][col1]}${keyMatrix[(r2 + 1) % 5][col2]}',
          );
          log('Added: ${temp.last}');
        } else {
          temp.add(
            '${keyMatrix[r1][col2]}${keyMatrix[r2][col1]}',
          );
          log('Added: ${temp.last}');
        }
      }
      log('Cipher: $temp');
    }
    cipher = temp.join(' ');
    return cipher;
  }

  String decrypt({required List<String> message, required String key}) {
    String decrypted = '';
    List<List<String>> keyMatrix = [];
    key = key.padRight((key.length / 5).ceil() * 5);
    for (int i = 0; i < key.length; i += 5) {
      keyMatrix.add(key.substring(i, i + 5).split(''));
    }

    List<String> temp = [];
    log('Message: $message');
    for (String group in message) {
      log('Group: $group');
      String fLetter = group[0] == 'J' ? 'I' : group[0];
      String sLetter = group[1] == 'J' ? 'I' : group[1];

      int r1 = -1, col1 = -1, r2 = -1, col2 = -1;
      for (int i = 0; i < 5; i++) {
        if (keyMatrix[i].contains(fLetter)) {
          r1 = i;
          col1 = keyMatrix[i].indexOf(fLetter);
        }
        if (keyMatrix[i].contains(sLetter)) {
          r2 = i;
          col2 = keyMatrix[i].indexOf(sLetter);
        }
      }
      if (r1 != -1 && col1 != -1 && r2 != -1 && col2 != -1) {
        if (r1 == r2) {
          temp.add(
            '${keyMatrix[r1][(col1 - 1 + 5) % 5]}${keyMatrix[r2][(col2 - 1 + 5) % 5]}',
          );
        } else if (col1 == col2) {
          temp.add(
            '${keyMatrix[(r1 - 1 + 5) % 5][col1]}${keyMatrix[(r2 - 1 + 5) % 5][col2]}',
          );
        } else {
          temp.add(
            '${keyMatrix[r1][col2]}${keyMatrix[r2][col1]}',
          );
        }
      }
      log('Decrypted: $temp');
    }
    decrypted = temp.join(' ');
    return decrypted;
  }
}
