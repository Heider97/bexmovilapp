extension StringUtil on String {
  String get capitalize {
    if(isEmpty) return "";
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}