class ProductModel {
  final String id;
  final String name;
  final String photo;
  final String price;
  final String parentCategoryId;
  final String mainCategoryName;

  ProductModel(
      {required this.id,
        required this.name,
        required this.price,
        required this.photo,
        required this.parentCategoryId,
        required this.mainCategoryName});

  factory ProductModel.fromJason(Map<String, dynamic> subsection) {
    return ProductModel(
      id: subsection["id"],
      name: subsection["name"] ?? "",
      photo: subsection["photo"] ?? "",
      price: subsection["price"] ?? "",
      parentCategoryId: subsection["parentCategoryId"] ?? "",
      mainCategoryName: subsection["mainCategoryName"] ?? "",
    );
  }
}
