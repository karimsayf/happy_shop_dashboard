class EmployeeModel {
  final String id;
  final String name;
  final String username;
  final String status;
  final String password;

  EmployeeModel(
      {required this.id,
        required this.name,
        required this.username,
        required this.status,
        required this.password,
      });

  factory EmployeeModel.fromJason(Map<String, dynamic> employee) {
    return EmployeeModel(
      id: employee["_id"] ?? "",
      name: employee["name"] ?? "",
      username: employee["username"] ?? "",
      status: employee["status"],
      password: employee["password"] ?? "",
    );
  }
}
