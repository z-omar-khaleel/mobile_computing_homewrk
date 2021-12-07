class FoodModel {
  String name, category, photo;
  double calory;

  FoodModel(
      {required this.name,
      required this.category,
      required this.photo,
      required this.calory});

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'category': this.category,
      'photo': this.photo,
      'calory': this.calory,
    };
  }

  factory FoodModel.fromMap(Map<String, dynamic> map) {
    return FoodModel(
      name: map['name'] as String,
      category: map['category'] as String,
      photo: map['photo'] as String,
      calory: map['calory'] as double,
    );
  }
}
