class ProductModel {
  final String id;
  final String name;
  final String photo;
  final String finalPrice;
  final String priceBefore;
  final String components;
  final String description;
  final String categoryName;
  final String categoryId;
  final List<dynamic> variants;

  ProductModel(
      {required this.id,
      required this.name,
        required this.finalPrice,
        required   this.priceBefore,
      required this.photo,
        required this.components,
        required this.description,
      required this.categoryName,
      required this.categoryId,
      required this.variants,
      });

  factory ProductModel.fromJason(Map<String, dynamic> product) {
    return ProductModel(
      id: product["_id"] ?? "",
      name: product["name"] ?? "",
      photo: product["photo"] ?? "",
      finalPrice: product["finalPrice"].toString(),
      components: product["component"] ?? "",
      description: product["description"] ?? "",
      priceBefore: product["priceBefore"].toString(),
      categoryName: product["categoryName"] ?? "",
      categoryId: product["categoryId"] ?? "",
      variants: product["variants"],
    );
  }
}