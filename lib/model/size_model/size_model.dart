class SizeModel {
  final String id;
  final String name;
  final String price;

  SizeModel({
    required this.id,
    required this.name,
    required this.price,
  });

  factory SizeModel.fromJason(Map<String, dynamic> size) {
    return SizeModel(
      id: size["id"],
      name: size["name"] ?? "",
      price: size["price"] ?? "",
    );
  }
}
