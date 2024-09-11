class Product {
  final String title;
  final String image;
  final String categories;
  final String description;

  Product({
    required this.title,
    required this.image,
    required this.categories,
    required this.description,
  });

  factory Product.fromMap(Map<String, String> map) {
    return Product(
      title: map['title']?? 'No title',
      image: map['image']?? 'No Url',
      categories: map['categories']?? 'No categories',
      description: map['description']?? 'No description',
    );
  }
}
