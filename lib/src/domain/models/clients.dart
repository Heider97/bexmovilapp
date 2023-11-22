import 'package:equatable/equatable.dart';

class Clients extends Equatable{
  final int coddashboard;
  final int codvendedor;
  final String description;
  final String urldesc;
  final int categoria;
  final int codcliente;
  final String fechaevento;
  final String fechafinevento;
  final String fecgra;
  final String requerido;
  final int created_by_id;
  final String created_at;
  final String updated_at;
  final String deleted_at;

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

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [];

}