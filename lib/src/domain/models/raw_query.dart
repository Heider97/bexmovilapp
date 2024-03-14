const String tableRawQueries = 'raw_queries';

class RawQueryFields {
  static final List<String> values = [id, sentence, replaceAll];

  static const String id = 'id';
  static const String sentence = 'sentence';
  static const String replaceAll = 'replace_all';
}

class RawQuery {
  int? id;
  String? sentence;
  bool? replaceAll;

  RawQuery({
    this.id,
    this.sentence,
    this.replaceAll
  });

  factory RawQuery.fromJson(Map<String, dynamic> json) => RawQuery(
    id: json['id'],
    sentence: json['sentence'],
    replaceAll: json['replace_all']
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'sentence': sentence,
    'replace_all': replaceAll
  };
}
