class AppDynamicCasteType<T> {
  final T Function(String) fromString;
  AppDynamicCasteType(this.fromString);
}

Map<String, AppDynamicCasteType> dynamicTypes = {
  "int": AppDynamicCasteType<int>((s) => int.parse(s)),
  "double": AppDynamicCasteType<double>((s) => double.parse(s)),
  "bool": AppDynamicCasteType<bool>((s) => bool.parse(s)),
};