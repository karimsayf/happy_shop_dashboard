class MainSizeModel {
  final String id;
  final String size;

  MainSizeModel({
    required this.id,
    required this.size,
  });

  factory MainSizeModel.fromJason(Map<String, dynamic> size) {
    return MainSizeModel(
      id: size["_id"] ?? "",
      size: size["name"] ?? "",
    );
  }
}
