import 'package:flutter/material.dart';

class CustomImageWidget extends StatelessWidget {
  final String imagePath;

  CustomImageWidget({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Image.asset(imagePath, width: 100, height: 100);
  }
}