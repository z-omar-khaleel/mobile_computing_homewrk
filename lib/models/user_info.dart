class UserInformation {
  String email;
  String name;
  String id;
  String gender;
  int age;

  UserInformation(
      {required this.email,
      this.gender = 'Male',
      required this.name,
      required this.id,
      this.age = 0});

  Map<String, dynamic> toMap() {
    return {
      'email': this.email,
      'name': this.name,
      'id': this.id,
      'gender': this.gender,
      'age': this.age,
    };
  }

  factory UserInformation.fromMap(Map<String, dynamic> map) {
    return UserInformation(
      email: map['email'] as String,
      name: map['name'] as String,
      id: map['id'] as String,
      gender: map['gender'] as String,
      age: map['age'] as int,
    );
  }
}
