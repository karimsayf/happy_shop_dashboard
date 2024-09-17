class ProductModel {
  final String id;
  final String name;
  final String photo;
  final String price;
  final String components;
  final String categoryName;
  final String categoryId;

  ProductModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.photo,
      required this.components,
      required this.categoryName,
      required this.categoryId});

  factory ProductModel.fromJason(Map<String, dynamic> product) {
    return ProductModel(
      id: product["id"].toString(),
      name: product["name"] ?? "",
      photo: product["photo"] ?? "",
      price: product["price"].toString(),
      components: product["components"] ?? "",
      categoryName: product["categoryName"] ?? "",
      categoryId: product["categoryId"].toString(),
    );
  }
}
