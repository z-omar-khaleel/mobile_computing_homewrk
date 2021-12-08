class FoodModel {
  String name, category, photo;
  String? id;
  double calory;

  FoodModel(
      {required this.name,
      this.id,
      required this.category,
      required this.photo,
      required this.calory});

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'category': this.category,
      'photo': this.photo,
      'id': this.id ?? '',
      'calory': this.calory,
    };
  }

  factory FoodModel.fromMap(Map<String, dynamic> map) {
    return FoodModel(
      name: map['name'] as String,
      category: map['category'] as String,
      photo: map['photo'] as String,
      id: map['id'] as String?,
      calory: map['calory'] as double,
    );
  }
}
