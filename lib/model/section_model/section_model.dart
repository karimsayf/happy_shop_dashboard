class SectionModel {
  final String id;
  final String name;
  final String photo;

  SectionModel(
      {required this.id,
      required this.name,
      required this.photo,});

  factory SectionModel.fromJason(Map<String, dynamic> subsection) {
    return SectionModel(
      id: subsection["id"],
      name: subsection["name"] ?? "",
      photo: subsection["photo"] ?? "",
    );
  }
}
