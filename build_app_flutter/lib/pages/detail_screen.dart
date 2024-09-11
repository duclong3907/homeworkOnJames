import 'package:flutter/material.dart';

import '../models/product.dart';
import '../widgets/custom_image.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(product.title),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBanner(),
              _buildMain(context),
            ],
          ),
        ));
  }

  Widget _buildBanner() {
    return Hero(
      tag: product.title,
      transitionOnUserGestures: true,
      child: Center(
        child: CustomImageWidget(imagePath: product.image),
      ),
    );
  }

  Widget _buildMain(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            'Categories: ${product.categories}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            'Description: ${product.description}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
