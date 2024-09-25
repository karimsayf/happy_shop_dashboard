class ProductSizeModel {
  final String id;
  final String size;
  final String price;
  final String sizeId;

  ProductSizeModel( {
    required this.id,
    required this.size,
    required this.price,
    required this.sizeId,
  });

  factory ProductSizeModel.fromJason(Map<String, dynamic> size) {
    return ProductSizeModel(
      id: size["_id"] ?? "",
      size: size["name"] ?? "",
      price: size["price"].toString(),
      sizeId: size["sizeId"] ?? "",
    );
  }
}
