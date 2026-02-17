import 'package:intl/intl.dart';

class DateFormatter {
  // Prevent instantiation
  DateFormatter._();

  /// Format a DateTime to a readable date string (e.g., "Dec 24, 2023")
  static String formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  /// Format a DateTime to a full date string (e.g., "December 24, 2023")
  static String formatFullDate(DateTime date) {
    return DateFormat('MMMM dd, yyyy').format(date);
  }

  /// Format a DateTime to a short date string (e.g., "12/24/2023")
  static String formatShortDate(DateTime date) {
    return DateFormat('MM/dd/yyyy').format(date);
  }

  /// Format a DateTime to a time string (e.g., "2:30 PM")
  static String formatTime(DateTime date) {
    return DateFormat('h:mm a').format(date);
  }

  /// Format a DateTime to a date and time string (e.g., "Dec 24, 2023 at 2:30 PM")
  static String formatDateTime(DateTime date) {
    return '${formatDate(date)} at ${formatTime(date)}';
  }

  /// Format a date range (e.g., "Dec 24 - Dec 31, 2023")
  static String formatDateRange(DateTime start, DateTime end) {
    if (start.year == end.year && start.month == end.month) {
      return '${DateFormat('MMM dd').format(start)} - ${DateFormat('dd, yyyy').format(end)}';
    } else if (start.year == end.year) {
      return '${DateFormat('MMM dd').format(start)} - ${DateFormat('MMM dd, yyyy').format(end)}';
    } else {
      return '${formatDate(start)} - ${formatDate(end)}';
    }
  }

  /// Calculate the number of days between two dates
  static int daysBetween(DateTime start, DateTime end) {
    final startDate = DateTime(start.year, start.month, start.day);
    final endDate = DateTime(end.year, end.month, end.day);
    return endDate.difference(startDate).inDays;
  }

  /// Check if a date is today
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  /// Check if a date is in the past
  static bool isPast(DateTime date) {
    return date.isBefore(DateTime.now());
  }

  /// Check if a date is in the future
  static bool isFuture(DateTime date) {
    return date.isAfter(DateTime.now());
  }
}
