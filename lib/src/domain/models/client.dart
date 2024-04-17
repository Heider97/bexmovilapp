const String tableClients = 'tblmcliente';

class Client {
  //CORE
  int? id;
  String? nit;
  String? name;
  String? address;
  String? businessName;
  String? email;
  String? cellphone;
  String? branch;
  String? price;
  String? wayToPay;
  int? quota;
  String? latitude;
  String? longitude;
  String? distance;
  String? duration;
  int? color;
  //ALTERNATIVES
  String? estadoCliente;
  bool? isBooked;
  String? docType;
  String? expireDate;
  String? movDate;
  int? hasCompleted;
  DateTime? startTimeOfMeeting;
  DateTime? endTimeOfMeeting;
  DateTime? lastVisited;
  String? averageSales;
  String? salesEffectiveness;
  int? total;
  int? wallet;
  String? rutero;

  Client(
      {this.id,
      this.nit,
      this.name,
      this.address,
      this.businessName,
      this.email,
      this.cellphone,
      this.branch,
      this.price,
      this.wayToPay,
      this.quota,
      this.isBooked,
      this.estadoCliente,
      this.startTimeOfMeeting,
      this.endTimeOfMeeting,
      this.averageSales,
      this.salesEffectiveness,
      this.lastVisited,
      this.docType,
      this.expireDate,
      this.movDate,
      this.total,
      this.wallet,
      this.latitude,
      this.longitude,
      this.rutero,
      this.distance,
      this.duration,
      this.color,
      this.hasCompleted = 0});

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
        id: json['CODCLIENTE'] ?? json['codcliente'],
        nit: json['NITCLIENTE'],
        name: json['NOMCLIENTE'] ?? json['nomcliente'],
        address: json['DIRCLIENTE'],
        businessName: json['RAZCLIENTE'],
        email: json['email'],
        cellphone: json['TELCLIENTE'],
        branch: json['SUCCLIENTE'],
        price: json['CODPRECIO'],
        wayToPay: json['CODFPAGOVTA'],
        quota: json['CUPO'],
        estadoCliente: json['estadocliente'],
        startTimeOfMeeting: json['startTimeOfMeeting'],
        endTimeOfMeeting: json['endTimeOfMeeting'],
        averageSales: json['averageSales'],
        salesEffectiveness: json['salesEffectiveness'],
        lastVisited: json['lastVisited'],
        docType: json['docType'],
        expireDate: json['expireDate'],
        movDate: json['movDate'],
        total: json['total'],
        wallet: json['wallet'],
        latitude: json['latitud'],
        longitude: json['longitud'],
        rutero: json['rutero']);
  }

  Map<String, dynamic> toJson() {
    return {
      'CODCLIENTE': id,
      'NITCLIENTE': nit,
      'NOMCLIENTE': name,
      'DIRCLIENTE': address,
      'RAZCLIENTE': businessName,
      'email': email,
      'TELCLIENTE': cellphone,
      'SUCCLIENTE': branch,
      'CODPRECIO': price,
      'CODFPAGOVTA': wayToPay,
      'CUPO': quota,
      'estadocliente': estadoCliente,
      'rutero': "rutero"
    };
  }
}
