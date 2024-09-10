import 'package:flutter/material.dart';
import '../models/idolKorean_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DetailsScreen extends StatelessWidget {
  final Idolkorean singer;

  DetailsScreen({required this.singer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(singer.name, style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.pink,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBanner(),
            _buildMain(context),
            GestureDetector(
              child: Container(
                height: 54,
                decoration: BoxDecoration(
                  color: Colors.blueGrey, // Background color
                  border: Border.all(
                    color: Colors.white, // Border color
                    width: 2.0, // Border width
                  ),
                  borderRadius: BorderRadius.circular(8.0), // Rounded corners
                ),
                child: Center(
                  child: Text(
                      'View Details',
                      style: TextStyle(color: Colors.white), // Text color
                  ),
                ),
              ),
              onTap: () => _launchCourse(singer.link),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _buildBanner(){
    return Hero( // dung de hien thi animation khi chuyen trang
      tag: 'imageHero${singer.name}',
      transitionOnUserGestures: true,
      child: Center(
          child: Image.asset(singer.image)
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
            singer.name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            'Group: ${singer.group}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            'Description: ${singer.description}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  void _launchCourse(String link) {
    launchUrlString(
        'https://vi.wikipedia.org/wiki/$link',
        mode: LaunchMode.externalApplication // Open in external browser
    );

  }
}

