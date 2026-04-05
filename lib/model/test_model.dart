// class TestModel {
//   String name;
//   String description;
//   double price;
//   String id;

//   TestModel({
//     required this.name,
//     required this.description,
//     required this.price,
//     required this.id,
//   });

//   factory TestModel.fromJson(Map<String, dynamic> json) {
//     return TestModel(
//       name: json['name'],
//       description: json['description'],
//       price: json['price'],
//       id: json['id'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {'description': description, 'price': price, 'name': name, 'id': id};
//   }
// }

// model/test_model.dart
class TestModel {
  final String id;
  final String name;
  final String description;
  final double price;

  const TestModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
  });

  factory TestModel.fromJson(Map<String, dynamic> json) {
    return TestModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'price': price,
  };
}
