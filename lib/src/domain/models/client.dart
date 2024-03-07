const String tableClients = 'tblmcliente';

class ClientFields {
  static final List<String> values = [id, name, type, value, module];

  static const String id = 'id';
  static const String name = 'name';
  static const String type = 'type';
  static const String value = 'value';
  static const String module = 'module';
}

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
  String? quota;
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
      this.distance,
      this.duration,
      this.color,
      this.hasCompleted = 0});

  factory Client.fromJson(Map<String, dynamic> json) {
    print(json);

    return Client(
        id: json['CODCLIENTE'],
        nit: json['NITCLIENTE'],
        name: json['NOMCLIENTE'],
        address: json['DIRCLIENTE'],
        businessName: json['SUCCLIENTE'],
        email: json['email'],
        cellphone: json['TELCLIENTE'],
        branch: json['email'],
        price: json['email'],
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
        longitude: json['longitud']);
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
      'DIRCLIENTE': price,
      'CODFPAGOVTA': wayToPay,
      'CUPO': quota,


      'email': email,
      'estadocliente': estadoCliente,
    };
  }
}
