class ProductDetailsModel {
  final String id;
  final String productName;
  final String productComponent;
  final String productPhoto;
  final String size;
  final String price;
  final String quantity;

  ProductDetailsModel(
      {required this.id,
      required this.productName,
      required this.productComponent,
      required this.productPhoto,
      required this.size,
      required this.price,
      required this.quantity});

  factory ProductDetailsModel.fromJason(Map<String, dynamic> productDetails) {
    return ProductDetailsModel(
        id: productDetails["id"].toString(),
        productName: productDetails["productName"],
        productComponent: productDetails["productComponent"],
        productPhoto: productDetails["productPhoto"],
        size: productDetails["size"],
        price: productDetails["price"].toString(),
        quantity: productDetails["quantity"].toString());
  }
}
