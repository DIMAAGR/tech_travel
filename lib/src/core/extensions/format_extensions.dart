import 'package:intl/intl.dart';

extension IntExtension on int {
  String toThousands({String locale = 'pt_BR'}) {
    return NumberFormat.decimalPattern(locale).format(this);
  }
}

extension StringExtension on String {
  String get capitalize {
    return '${substring(0, 1).toUpperCase()}${substring(1)}';
  }
}

extension DateTimeExtension on DateTime {
  String toShortFormatted() {
    return DateFormat('MMM dd, yyyy').format(this).capitalize.replaceAll('.', '');
  }
}

extension TimeAgoExtension on DateTime {
  String timeAgo() {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays >= 30) {
      final months = (difference.inDays / 30).floor();
      return months == 1 ? '1 month ago' : '$months months ago';
    } else if (difference.inDays >= 7) {
      final weeks = (difference.inDays / 7).floor();
      return weeks == 1 ? '1 week ago' : '$weeks weeks ago';
    } else if (difference.inDays >= 1) {
      return difference.inDays == 1 ? '1 day ago' : '${difference.inDays} days ago';
    } else if (difference.inHours >= 1) {
      return difference.inHours == 1 ? '1 hour ago' : '${difference.inHours} hours ago';
    } else if (difference.inMinutes >= 1) {
      return difference.inMinutes == 1 ? '1 minute ago' : '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }
}
