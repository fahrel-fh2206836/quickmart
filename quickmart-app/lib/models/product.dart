class Product {
  String id;
  String title;
  String category;
  String description;
  double price;
  int rating;
  String imageName;

  Product(
      {required this.id,
      required this.title,
      required this.category,
      required this.description,
      required this.price,
      required this.rating,
      required this.imageName});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      description: json['description'],
      price: json['price'],
      rating: json['rating'],
      imageName: json['imageName'],
    );
  }
}
