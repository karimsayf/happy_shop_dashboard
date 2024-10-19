class ProductModel {
  final String id;
  final String name;
  final String photo;
  final String finalPrice;
  final String priceBefore;
  final String components;
  final String description;
  final String quantity;
  final String weight;
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
        required this.quantity,
        required this.weight
      });

  factory ProductModel.fromJason(Map<String, dynamic> product) {
    return ProductModel(
      id: product["_id"] ?? "",
      name: product["name"] ?? "",
      photo: product["photo"] ?? "",
      finalPrice: product["finalPrice"].toString(),
      components: product["component"] ?? "-",
      description: product["description"] ?? "-",
      priceBefore: product['priceBefore'] == null ? "0" :product['priceBefore'].toString(),
    categoryName: product["categoryName"] ?? "",
      categoryId: product["categoryId"] ?? "",
      variants: product["variants"],
      weight: product['weight'] == null ? "-" :product['weight'].toString(),
      quantity: product['quantity'] == null ? "-" :product['quantity'].toString()
    );
  }
}