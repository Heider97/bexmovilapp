import '../../domain/models/config.dart';

class AppDynamicCasteType<T> {
  final T Function(String) fromString;
  AppDynamicCasteType(this.fromString);
}

Map<String, AppDynamicCasteType> dynamicTypes = {
  "int": AppDynamicCasteType<int>((s) => int.parse(s)),
  "double": AppDynamicCasteType<double>((s) => double.parse(s)),
  "bool": AppDynamicCasteType<bool>((s) => bool.parse(s)),

  // "List<Client>": AppDynamicCasteType<List<Client>>(s) => parseClient(s)>
};

Future<dynamic> generateVariable(Config config) async {
  return null;
}