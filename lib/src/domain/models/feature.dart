const String tableFeature = 'features';

class FeaturesFields{
  static final List<String> values = [
    coddashboard,
    codvendedor,
    description,
    urldesc,
    categoria,
    codcliente,
    fechaevento,
    fechafinevento,
    fecgra,
    requerido,
    createdById,
    createdAt,
    updatedAt,
    deletedAt,
  ];

  static const String coddashboard = 'coddashboard';
  static const String codvendedor = 'codvendedor';
  static const String description = 'description';
  static const String urldesc = 'urldesc';
  static const String categoria = 'categoria';
  static const String codcliente = 'codcliente';
  static const String fechaevento = 'fechaevento';
  static const String fechafinevento = 'fechafinevento';
  static const String fecgra = 'fecgra';
  static const String requerido = 'requerido';
  static const String createdById = 'created_by_id';
  static const String createdAt = 'created_at';
  static const String updatedAt = 'updated_at';
  static const String deletedAt = 'deleted_at';

}

class Feature {
    late int coddashboard;
    String? codvendedor;
    String? description;
    String? urldesc;
    String? categoria;
    String? codcliente;
    String? fechaevento;
    String? fechafinevento;
    String? fecgra;
    String? requerido;
    int? createdById;
    String? createdAt;
    String? updatedAt;
    String? deletedAt;

  Feature({
    required this.coddashboard,
    this.codvendedor,
    this.description,
    this.urldesc,
    this.categoria,
    this.codcliente,
    this.fechaevento,
    this.fechafinevento,
    this.fecgra,
    this.requerido,
    this.createdById,
    this.createdAt,
    this.updatedAt,
    this.deletedAt
  });

    factory Feature.fromMap(Map<String, dynamic> map){
      return Feature(
          coddashboard: map['coddashboard'],
          codvendedor: map['codvendedor'],
          description: map['description'],
          urldesc: map['urldesc'],
          categoria: map['categoria'],
          codcliente: map['codcliente'],
          fechaevento: map['fechaevento'],
          fechafinevento: map['fechafinevento'],
          fecgra: map['fecgra'],
          requerido: map['requerido'],
          createdById: map['created_by_id'],
          createdAt: map['created_at'],
          updatedAt: map['updated_at'],
          deletedAt: map['deleted_at']
      );
    }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['coddashboard'] = coddashboard;
    data['codvendedor'] = codvendedor;
    data['description'] = description;
    data['urldesc'] = urldesc;
    data['categoria'] = categoria;
    data['codcliente'] = codcliente;
    data['fechaevento'] = fechaevento;
    data['fechafinevento'] = fechafinevento;
    data['fecgra'] = fecgra;
    data['requerido'] = requerido;
    data['created_by_id'] = createdById;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }



}