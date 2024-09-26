class ProductDetailsModel {
  final String productId;
  final String productName;
  final String productComponent;
  final String productPhoto;
  final String sizeName;
  final String totalPrice;
  final String pricePerOne;
  final String quantity;

  ProductDetailsModel(
      {required this.productId,
      required this.productName,
      required this.productComponent,
      required this.productPhoto,
      required this.sizeName,
      required this.totalPrice,
        required this.pricePerOne,
      required this.quantity});

  factory ProductDetailsModel.fromJason(Map<String, dynamic> productDetails) {
    return ProductDetailsModel(
        productId: productDetails["productId"] ?? "",
        productName: productDetails["productName"] ?? "",
        productComponent: productDetails["productComponents"] ?? "",
        productPhoto: productDetails["productPhoto"] ?? "",
        sizeName: productDetails["sizeName"] ?? "",
        pricePerOne: productDetails["pricePerOne"].toString(),
        totalPrice: productDetails["totalPrice"].toString(),
        quantity: productDetails["quantity"].toString());
  }
}
