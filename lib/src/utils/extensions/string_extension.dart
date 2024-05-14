import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../../presentation/widgets/organisms/app_component.dart';

extension StringUtil on String {
  String get capitalize {
    if (isEmpty) return '';
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String capitalizeString() {
    if (contains(' ')) {
      var split = this.split(' ');
      var string = [];
      for (var i = 0; i < split.length; i++) {
        string.add(
            split[i][0].toUpperCase() + split[i].substring(1).toLowerCase());
      }

      return string.join(' ');
    } else {
      return this[0].toUpperCase() + substring(1).toLowerCase();
    }
  }

  String formatted(double value) {
    return '\$${NumberFormat('#,##0', 'es_CO').format(value)}';
  }

  String formattedWithOutDecimal(int value) {
    return '\$ ${NumberFormat('#,###.##', 'es_CO').format(value)}';
  }

  String formattedCompact(String str) {
    var result = NumberFormat.compact(locale: 'es').format(double.parse(str));
    return result;
  }

  String formattedMillion(String str) {
    var result = NumberFormat.compact(locale: 'en').format(double.parse(str));
    return result;
  }

  replaceCharAt(String oldString, int index, String newChar) {
    return oldString.substring(0, index) +
        newChar +
        oldString.substring(index + 1);
  }

  ComponentTypes toEnum() =>
      ComponentTypes.values.firstWhere((d) => describeEnum(d) == toLowerCase());
}
