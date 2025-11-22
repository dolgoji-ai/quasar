String formatEventDate(DateTime date) {
  final year = date.year;
  final month = date.month;
  final day = date.day;

  final hour = date.hour;
  final minute = date.minute;

  final period = hour < 12 ? '오전' : '오후';
  final displayHour = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
  final displayMinute = minute.toString().padLeft(2, '0');

  return '$year-$month-$day $period $displayHour:$displayMinute';
}
