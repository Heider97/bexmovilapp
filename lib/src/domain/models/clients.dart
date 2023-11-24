const String tableClients = 'clients';

class ClientsFields{
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
    created_by_id,
    created_at,
    updated_at,
    deleted_at,
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
  static const String created_by_id = 'created_by_id';
  static const String created_at = 'created_at';
  static const String updated_at = 'updated_at';
  static const String deleted_at = 'deleted_at';

}

class Clients {
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
    late int created_by_id;
    late String created_at;
    late String updated_at;
    late String deleted_at;

  Clients({
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
    required this.created_by_id,
    required this.created_at,
    required this.updated_at,
    required this.deleted_at
  });

  Clients.fromJson(Map<String, dynamic> json){
    coddashboard = json['coddashboard'];
    codvendedor = json['codvendedor'];
    description = json['description'];
    urldesc = json['urldesc'];
    categoria = json['categoria'];
    codcliente = json['codcliente'];
    fechaevento = json['fechaevento'];
    fechafinevento = json['fechafinevento'];
    fecgra = json['fecgra'];
    requerido = json['requerido'];
    created_by_id = json['created_by_id'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
    deleted_at = json['deleted_at'];
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
    data['created_by_id'] = created_by_id;
    data['created_at'] = created_at;
    data['updated_at'] = updated_at;
    data['deleted_at'] = deleted_at;
    return data;
  }

  factory Clients.fromMap(Map<String, dynamic> map){
    return Clients(
      coddashboard: map['coddashboard'] != null ? map['coddashboard'] : null, 
      codvendedor: map['codvendedor'] != null ? map['codvendedor'] : null, 
      description: map['description'] != null ? map['description'] : null, 
      urldesc: map['urldesc'] != null ? map['urldesc'] : null, 
      categoria: map['categoria'] != null ? map['categoria'] : null, 
      codcliente: map['codcliente'] != null ? map['codcliente'] : null, 
      fechaevento: map['fechaevento'] != null ? map['fechaevento'] : null, 
      fechafinevento: map['fechafinevento'] != null ? map['fechafinevento'] : null, 
      fecgra: map['fecgra'] != null ? map['fecgra'] : null, 
      requerido: map['requerido'] != null ? map['requerido'] : null,
      created_by_id: map['created_by_id'] != null ? map['created_by_id'] : null,
      created_at: map['created_at'] != null ? map['created_at'] : null,
      updated_at: map['updated_at'] != null ? map['updated_at'] : null,
      deleted_at: map['deleted_at'] != null ? map['deleted_at'] : null
    );
  }

}