import 'dart:math';

int generateUniqueId() {
  DateTime now = DateTime.now();
  int timestamp = now.microsecondsSinceEpoch;
  int random = Random().nextInt(pow(2, 32).toInt());
  int uniqueId = timestamp ^ random;
  return uniqueId;
}

String dateFormat(DateTime date) {
  String formatTwoDigits(int value) {
    return value.toString().padLeft(2, '0');
  }

  return '${formatTwoDigits(date.day)}/${formatTwoDigits(date.month)}/${date.year}\n'
      '${formatTwoDigits(date.hour)}:${formatTwoDigits(date.minute)}.${formatTwoDigits(date.second)}';
}
