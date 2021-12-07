class UserInformation {
  String email;
  String name;
  String id;

  UserInformation({
    required this.email,
    required this.name,
    required this.id,
  });

  factory UserInformation.fromJson(Map<String, dynamic> json) {
    return UserInformation(
      email: json['email'],
      name: json['name'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['id'] = this.id;

    return data;
  }
}
