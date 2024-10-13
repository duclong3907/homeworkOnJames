import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rwnews/view_models/news_view_model.dart';
import 'package:shimmer/shimmer.dart';

import 'add_edit_news_screen.dart';

final NewsViewModel _newsViewModel = Get.find<NewsViewModel>();

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Obx(() {
          if (_newsViewModel.isLoading.value) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: ListView.builder(
                itemCount: _newsViewModel.newsList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const CircleAvatar(),
                    title: Container(
                      height: 10,
                      color: Colors.grey,
                    ),
                    subtitle: Container(
                      height: 10,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            );
          } else if (_newsViewModel.newsList.isEmpty) {
            return Center(
              child: Text('Chưa có bài viết nào, hãy thêm bài viết tại đây” + Nút'),
            );
          } else {
            return ListView.builder(
              itemCount: _newsViewModel.newsList.length,
              itemBuilder: (context, index) {
                final news = _newsViewModel.newsList[index];
                return Container(
                  child: Card(
                    child: Stack(
                      children: [
                        ListTile(
                          title: Text(
                            news.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(news.source, overflow: TextOverflow.ellipsis),
                                ),
                                const Spacer(),
                                const Text("45 comments", overflow: TextOverflow.ellipsis),
                              ],
                            ),
                          ),
                          leading: Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: news.image.startsWith('data:image')
                                ? Image.memory(
                              base64Decode(news.image.split(',').last),
                              fit: BoxFit.cover,
                            )
                                : Image.network(
                              news.image,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, progress) {
                                if (progress == null) return child;
                                return const Center(child: CircularProgressIndicator());
                              },
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                            onPressed: () {Get.to(() => AddEditNewsScreen(id: news.id));},
                            icon: const Icon(Icons.edit),
                          ),
                        ),
                      ],
                    ),

                  ),
                );
              },
            );
          }
        }),
      ),
    );
  }
}