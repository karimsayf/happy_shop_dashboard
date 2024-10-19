class ProductVariantSizeModel {
  final String size;
  final String price;
  final String quantity;

  ProductVariantSizeModel( {
    required this.size,
    required this.price,
    required this.quantity
  });

  factory ProductVariantSizeModel.fromJason(Map<String, dynamic> size) {
    return ProductVariantSizeModel(
      size: size["sizeName"] ?? "",
      price: size["price"].toString() ?? "",
      quantity: size['quantity'] == null ? "" :size['quantity'].toString(),
    );
  }
}
