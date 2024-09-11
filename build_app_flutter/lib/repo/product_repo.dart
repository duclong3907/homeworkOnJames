import '../models/product.dart';

class ProductRepository {
  static List<Product> getProducts() {
    List<Map<String, String>> productData = [
      {'title': 'Lego', 'image': 'https://media-api.advertisingvietnam.com/oapi/v1/media?uuid=433d57b6-f805-47d5-98b9-e243073f0320&resolution=1440x756&type=image', 'categories': 'Lego', 'desciption': 'hello shirt'},
      {'title': 'LEGO Star Wars 75346', 'image':'https://i1.haypley.vn/2023/11/07/lego-star-wars-75346-phi-thuyen-hai-tac-6fdf8e.jpg', 'categories': 'Lego', 'desciption': 'hello shirt'},
      {'title': 'LEGO Technic App-Controlled Transformation Vehicle', 'image': 'https://i.ytimg.com/vi/adZ2KRoOTM0/maxresdefault.jpg', 'categories': 'Lego', 'desciption': 'hello shirt'},
      {'title': 'Lego Technic 42115 Lamborghini Sián FKP 37', 'image': 'https://d2ly9j2wcshstw.cloudfront.net/productimages/113403/big/42115_alt3.jpg', 'categories': 'Lego', 'desciption': 'hello shirt'},
    ];
    return productData.map((product) => Product.fromMap(product)).toList();
  }
}
