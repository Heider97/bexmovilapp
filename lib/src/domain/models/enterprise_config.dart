import 'package:equatable/equatable.dart';

class EnterpriseConfig extends Equatable {
  final int? id;
  final bool? allowInsetsBellow,
      hadTakePicture,
      canBlockClients,
      requiredArrived,
      skipUpdate;
  final String? mapbox;
  final String? codeQr;
  final int? limitDaysWorks;
  final bool? blockPartial;

  const EnterpriseConfig(
      {this.id,
      this.allowInsetsBellow,
      this.hadTakePicture,
      this.canBlockClients,
      this.requiredArrived,
      this.mapbox,
      this.codeQr,
      this.blockPartial,
      this.skipUpdate,
      this.limitDaysWorks});

  factory EnterpriseConfig.fromMap(Map<String, dynamic> map) {
    return EnterpriseConfig(
      id: map['id'] != null ? map['id'] as int : null,
      allowInsetsBellow: map['allow_insets_bellow'] != null
          ? map['allow_insets_bellow'] as bool
          : null,
      hadTakePicture: map['had_take_picture'] != null
          ? map['had_take_picture'] == 1 ? true : false
          : null,
      canBlockClients: map['can_block_clients'] != null
          ? map['can_block_clients'] == 1 ? true : false
          : null,
      requiredArrived: map['require_arrived'] != null
          ? map['require_arrived'] == 1 ? true : false
          : null,
      mapbox: map['mapbox'] != null ? map['mapbox'] as String : null,
      codeQr: map['code_qr'] != null ? map['code_qr'] as String : null,
      blockPartial:
          map['block_partial'] != null ? map['block_partial'] == 1 ? true : false : null,
      skipUpdate:
          map['skip_update'] != null ? map['skip_update'] == 1 ? true : false : null,
      limitDaysWorks: map['limit_days_works'] != null
          ? map['limit_days_works'] as int
          : null,
    );
  }

  Map toMap() {
    return {
      'id': id,
      'allow_insets_bellow': allowInsetsBellow,
      'had_take_picture': hadTakePicture,
      'can_block_clients': canBlockClients,
      'required_arrived': requiredArrived,
      'mapbox': mapbox,
      'code_qr': codeQr,
      'block_partial': blockPartial,
      'skip_update': skipUpdate,
      'limit_days_works': limitDaysWorks,
    };
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props =>
      [id, allowInsetsBellow, mapbox, codeQr, blockPartial];
}
