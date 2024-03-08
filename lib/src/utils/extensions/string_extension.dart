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

  String formattedBasedOnM(String str) {
    var result = NumberFormat.compact(locale: 'en').format(double.parse(str));
    if (result.contains('K') && result.length > 3) {
      result = result.substring(0, result.length - 1);
      var prefix = (result.split('.').last.length) + 1;
      var temp = (double.parse(result) * .001).toStringAsFixed(prefix);
      result = '${double.parse(temp)}M';
    }
    return result;
  }
}
