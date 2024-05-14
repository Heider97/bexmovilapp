const String tableRawQueries = 'app_raw_queries';

class RawQueryFields {
  static final List<String> values = [id, sentence, replaceAll];

  static const String id = 'id';
  static const String sentence = 'sentence';
  static const String arguments = 'arguments';
  static const String replaceAll = 'replace_all';
}

class RawQuery {
  int? id;
  String? sentence;
  String? arguments;
  bool? replaceAll;

  RawQuery({this.id, this.sentence, this.arguments, this.replaceAll});

  factory RawQuery.fromJson(Map<String, dynamic> json) => RawQuery(
      id: json['id'],
      sentence: json['name'],
      arguments: json['arguments'],
      replaceAll: json['replace_all'] == 1 ? true : false);

  Map<String, dynamic> toJson() => {
        'id': id,
        'sentence': sentence,
        'arguments': arguments,
        'replace_all': replaceAll
      };
}
