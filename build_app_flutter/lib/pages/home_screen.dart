import 'package:build_app_flutter/pages/detail_screen.dart';
import 'package:build_app_flutter/repo/product_repo.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Product> _products;

  @override
  void initState() {
    super.initState();
    _products = ProductRepository.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          return InkWell(
            child: Hero(
              tag: _products[index].title,
              child: ProductCard(product: _products[index]),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(product: _products[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
