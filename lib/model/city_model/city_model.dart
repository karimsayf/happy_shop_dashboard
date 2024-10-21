class CityModel {
  final String id;
  final String name;
  final String price;


  CityModel(
      {required this.id,
        required this.name,
        required this.price,

      });

  factory CityModel.fromJason(Map<String, dynamic> city) {
    return CityModel(
      id: city["_id"] ?? "",
      name: city["name"] ?? "",
      price: city["price"].toString() ?? "",
    );
  }
}
