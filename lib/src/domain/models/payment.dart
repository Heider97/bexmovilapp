class Payment {
  Payment({required this.method, required this.paid});

  Payment.fromJson(Map<String, dynamic> json) {
    method = json['method'];
    paid = json['paid'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['method'] = method;
    data['paid'] = paid;
    return data;
  }

  late String method;
  late String paid;
}
