class DateTimeUtils {
  DateTimeUtils._();

  static bool isLateNight(DateTime dateTime) {
    return dateTime.hour >= 0 && dateTime.hour <= 4;
  }

  static bool isMorningRush(DateTime dateTime) {
    return dateTime.hour >= 6 && dateTime.hour <= 8;
  }

  static Duration timeSince(DateTime dateTime) {
    return DateTime.now().difference(dateTime);
  }
}
