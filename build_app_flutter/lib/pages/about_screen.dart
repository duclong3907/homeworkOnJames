import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'ToyStore is an online shopping app that specializes in offering a wide range of high-quality toys for children of all ages. With a user-friendly interface, ToyStore makes it easy to search, select, and purchase your favorite toys for your kids in just a few simple steps. We are committed to providing a safe, fast, and convenient shopping experience while regularly updating our selection with the latest toys to meet the needs of every family.',
            textAlign: TextAlign.justify,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }
}
