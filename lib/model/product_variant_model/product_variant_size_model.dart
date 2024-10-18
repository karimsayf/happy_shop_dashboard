class ProductVariantSizeModel {
  final String size;
  final String price;

  ProductVariantSizeModel( {
    required this.size,
    required this.price,
  });

  factory ProductVariantSizeModel.fromJason(Map<String, dynamic> size) {
    return ProductVariantSizeModel(
      size: size["sizeName"] ?? "",
      price: size["price"].toString() ?? "",
    );
  }
}
