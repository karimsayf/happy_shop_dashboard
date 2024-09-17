class ProductSizeModel {
  final String id;
  final String size;
  final String price;
  final String productId;
  final String sizeId;

  ProductSizeModel( {
    required this.id,
    required this.size,
    required this.price,
    required this.productId,
    required this.sizeId,
  });

  factory ProductSizeModel.fromJason(Map<String, dynamic> size) {
    return ProductSizeModel(
      id: size["id"].toString(),
      size: size["size"] ?? "",
      price: size["price"].toString(),
      productId: size["productId"].toString(),
      sizeId: size["sizeId"].toString(),
    );
  }
}
