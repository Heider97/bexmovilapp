import 'package:intl/intl.dart';

extension StringUtil on String {
  String get capitalize {
    if (isEmpty) return "";
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String formatted(double value) {
    return '\$${NumberFormat('#,##0.00', 'es_CO').format(value)}';
  }

  String formattedWithOutDecimal(int value) {
    return '\$ ${NumberFormat('#,###.##', 'es_CO').format(value)}';
  }

  String formattedCompact(String str) {
    var result = NumberFormat.compact(locale: 'en').format(double.parse(str));
    return result;
  }
}
