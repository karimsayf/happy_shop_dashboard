class RequestModel {
  final String id;
  final String totalQuantity;
  final String totalPrice;
  final String tableNumber;
  final String captainId;
  final String captainName;
  final String status;

  RequestModel(
      {required this.id,
      required this.totalQuantity,
      required this.totalPrice,
      required this.tableNumber,
      required this.captainId,
      required this.captainName,
      required this.status});

  factory RequestModel.fromJason(Map<String, dynamic> request) {
    return RequestModel(
        id: request["id"].toString(),
        totalQuantity: request["totalQuantity"].toString(),
        totalPrice: request["totalPrice"].toString(),
        tableNumber: request["tableNumber"].toString(),
        captainId: request["captainId"].toString(),
        captainName: request["captainName"] ?? "",
        status: request["status"]);
  }
}
