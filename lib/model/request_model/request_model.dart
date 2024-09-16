class RequestModel {
  final String id;
  final String service;
  final String customerId;
  final String customerName;
  final String orderStatus;
  final List<dynamic> createdDate;

  RequestModel(
      {required this.id,
      required this.service,
      required this.customerId,
      required this.customerName,
      required this.orderStatus,
      required this.createdDate});

  factory RequestModel.fromJason(Map<String, dynamic> request) {
    return RequestModel(
        id: request["id"],
        service: request["service"] ?? "",
        customerId: request["customerId"] ?? "",
        customerName: request["customerName"] ?? "",
        orderStatus: request["orderStatus"] ?? "",
        createdDate: request["createdDate"] ?? "");
  }
}
