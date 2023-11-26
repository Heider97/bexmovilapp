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
    late int codvendedor;
    late String description;
    late String urldesc;
    late int categoria;
    late int codcliente;
    late String fechaevento;
    late String fechafinevento;
    late String fecgra;
    late String requerido;
    late int createdById;
    late String createdAt;
    late String updatedAt;
    late String deletedAt;

  Feature({
    required this.coddashboard, 
    required this.codvendedor, 
    required this.description, 
    required this.urldesc, 
    required this.categoria, 
    required this.codcliente, 
    required this.fechaevento, 
    required this.fechafinevento, 
    required this.fecgra, 
    required this.requerido, 
    required this.createdById,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt
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