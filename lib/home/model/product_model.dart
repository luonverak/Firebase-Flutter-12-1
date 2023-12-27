class ProductModel {
  final int id;
  final String name;
  final String description;
  final double price;
  final String image;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });
  Map<String, dynamic> fromJson() {
    return ({
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'image': image
    });
  }
}
