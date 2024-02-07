import 'package:equatable/equatable.dart';

const String tableKpis = 'kpis';

class KpiFields {
  static final List<String> values = [id, title, value, percent];

  static const String id = 'id';
  static const String title = 'title';
  static const String type = 'type';
  static const String value = 'value';
  static const String percent = 'percent';
}

class Kpi extends Equatable {
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

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, title, value, percent];
}
