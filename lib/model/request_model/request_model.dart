class RequestModel {
  final String id;
  final String totalPrice;
  final String tableNumber;
  final String captainId;
  final String captainName;
  final String status;
  final List<dynamic> products;

  RequestModel({
    required this.id,
    required this.totalPrice,
    required this.tableNumber,
    required this.captainId,
    required this.captainName,
    required this.status,
    required this.products,
  });

  factory RequestModel.fromJason(Map<String, dynamic> request) {
    return RequestModel(
        id: request["_id"] ?? "",
        totalPrice: request["totalPrice"] ?? "",
        tableNumber: request["tableNumber"] ?? "",
        captainId: request["captainId"] ?? "",
        captainName: request["captainName"] ?? "",
        status: request["status"],
        products: request["products"]);
  }
}
