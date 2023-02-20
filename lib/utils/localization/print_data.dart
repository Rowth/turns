import 'package:flutter/foundation.dart';

void printData(message) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(message).forEach((match) {
    if (kDebugMode) {
      print(match.group(0));
    }
  });
}
