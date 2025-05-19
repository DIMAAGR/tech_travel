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
