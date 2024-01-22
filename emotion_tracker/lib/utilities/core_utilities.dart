import 'dart:developer';

int generateUniqueId() {
  DateTime now = DateTime.now();
  int uniqueId = now.microsecondsSinceEpoch.remainder(100000000);
  log(uniqueId.toString());
  return uniqueId;
}

String dateFormat(DateTime date) {
  String formatTwoDigits(int value) {
    return value.toString().padLeft(2, '0');
  }

  return '${formatTwoDigits(date.day)}/${formatTwoDigits(date.month)}/${date.year}\n'
      '${formatTwoDigits(date.hour)}:${formatTwoDigits(date.minute)}.${formatTwoDigits(date.second)}';
}
