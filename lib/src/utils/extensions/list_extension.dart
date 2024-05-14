extension ListToMapExtension<K, V> on List<MapEntry<K, V>> {
  Map<K, V> get asMap => Map.fromEntries(this);
}

extension ListExtension on List {
  bool hasDuplicates() => length != toSet().length;

  List getDuplicates() => where((x) => !toSet().remove(x)).toList();
}