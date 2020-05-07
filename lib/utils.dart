bool isSameDate(DateTime that, DateTime other) {
  DateTime a = that.toLocal();
  DateTime b = other.toLocal();
  return a.year == b.year && a.month == b.month && a.day == b.day;
}

bool isSameMonth(DateTime that, DateTime other) {
  DateTime a = that.toLocal();
  DateTime b = other.toLocal();
  return a.year == b.year && a.month == b.month;
}
