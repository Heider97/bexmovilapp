class Kpi {
  int? id;
  String? title;
  double? value;
  double? percent;

  Kpi({this.id, this.title, this.value, this.percent});

  factory Kpi.fromJson(Map<String, dynamic> json) {
    return Kpi(
      id: json['id'],
      title: json['title'],
      value: json['value'],
      percent: json['percent'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'value': value,
      'percent': percent,
    };
  }
}
