class ProductSizeModel {
  final String size;
  final String price;

  ProductSizeModel( {
    required this.size,
    required this.price,
  });

  factory ProductSizeModel.fromJason(Map<String, dynamic> size) {
    return ProductSizeModel(
      size: size["sizeName"] ?? "",
      price: size["price"].toString(),
    );
  }
}
