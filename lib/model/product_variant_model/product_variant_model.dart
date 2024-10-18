import 'package:menu_dashboard/model/product_variant_model/product_variant_size_model.dart';

class ProductVariantModel {
  final String id;
  final String color;
  List<ProductVariantSizeModel>? sizes;

  ProductVariantModel( {
    required this.id,
    required this.color,
    this.sizes,
  });

  factory ProductVariantModel.fromJason(Map<String, dynamic> variant) {
    return ProductVariantModel(
      id: variant["_id"] ?? "",
      color: variant["color"].toString()?? "",
      sizes: (variant['sizes']??[]).map<ProductVariantSizeModel>((size)=> ProductVariantSizeModel.fromJason(size)).toList(),
    );
  }
}
