class ProductModel {
  final String id;
  final String name;
  final String photo;
  final String price;
  final String components;
  final String categoryName;
  final String categoryId;
  final List<dynamic> sizes;

  ProductModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.photo,
      required this.components,
      required this.categoryName,
      required this.categoryId,
      required this.sizes});

  factory ProductModel.fromJason(Map<String, dynamic> product) {
    return ProductModel(
      id: product["_id"] ?? "",
      name: product["name"] ?? "",
      photo: product["photo"] ?? "",
      price: product["price"].toString(),
      components: product["component"] ?? "",
      categoryName: product["categoryName"] ?? "",
      categoryId: product["categoryId"] ?? "",
      sizes: product["sizes"],
    );
  }
}