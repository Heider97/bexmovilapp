

import 'package:bexmovil/src/domain/models/clients.dart';
import 'package:equatable/equatable.dart';

class SyncResponse extends Equatable{
  
  final bool status;
  final String message;
  final Clients clients;  //aqui va una clase con la informacion que me va a recibir

  const SyncResponse({
    required this.status,
    required this.message,
    required this.clients
  });

  factory SyncResponse.fromMap(Map<String, dynamic>map){
    return SyncResponse(
      status: map['status'], 
      message: map['message'],
      clients: Clients.fromMap(map)
    );
  }

  @override 
  bool get stringify => true;

  @override
  List<Object> get props => [status, message, clients];

}