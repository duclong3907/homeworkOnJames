import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rwnews/view_models/news_view_model.dart';

class AddEditNewsScreen extends StatelessWidget {
  final int? id;
  final NewsViewModel _newsViewModel = Get.find<NewsViewModel>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController sourceController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final ValueNotifier<String> imagePath = ValueNotifier<String>('');

  AddEditNewsScreen({this.id}) {
    _init();
  }

  Future<void> _init() async {
    if (id != null) {
      await _newsViewModel.fetchNewsById(id!);
      final news = _newsViewModel.newsDetail.value;
      if (news != null) {
        titleController.text = news.title ?? '';
        sourceController.text = news.source ?? '';
        dateController.text = (news.date as DateTime).toIso8601String();
        imagePath.value = news.image ?? '';
        contentController.text = news.content ?? '';
        emailController.text = news.email ?? '';
      }
    }
  }

  void _addOrEditNews(context) async {
    final news = {
      "title": titleController.text,
      "source": sourceController.text,
      "content":  contentController.text,
      "date": dateController.text,
      "image": imagePath.value,
      "email": emailController.text
    };
    if (id == null) {
      var result = await _newsViewModel.addNews(news);
      if(result) Navigator.pop(context);
    } else {
      var result = await _newsViewModel.updateNews(id!, news);
      if(result) Navigator.pop(context);
    }
  }

  final ImagePicker _picker = ImagePicker();

  void selectImage() async {
    final XFile? img = await _picker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      final imageBytes = await img.readAsBytes();
      final encodedImage = base64Encode(imageBytes);
      imagePath.value = 'data:image/png;base64,$encodedImage';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(id == null ? 'Add News' : 'Edit Article'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  ValueListenableBuilder<String>(
                    valueListenable: imagePath,
                    builder: (context, imagePath, child) {
                      return Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: imagePath.isNotEmpty
                            ? (imagePath.startsWith('data:image')
                            ? Image.memory(
                          base64Decode(imagePath.split(',').last),
                          fit: BoxFit.cover,
                          width: 160,
                          height: 160,
                        )
                            : Image.network(
                          imagePath,
                          fit: BoxFit.cover,
                          width: 160,
                          height: 160,
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ))
                            : Image.asset(
                          'assets/images/news.png',
                          fit: BoxFit.cover,
                          width: 160,
                          height: 160,
                        ),
                      );
                    },
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: selectImage,
                      child: const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 20,
                        child: Icon(Icons.camera_alt),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.title),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: sourceController,
                decoration: const InputDecoration(
                  labelText: 'Source',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: dateController,
                decoration: const InputDecoration(
                  labelText: 'Date',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    dateController.text = "${pickedDate.toLocal()}".split(' ')[0];
                  }
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: contentController,
                decoration: const InputDecoration(
                  labelText: 'Comments',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: double.infinity,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(id == null ? Icons.add : Icons.save_outlined, color: Colors.white),
                        const SizedBox(width: 10),
                        Text(id == null ? 'Add' : 'Update', style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                ),
                onTap: () {
                  _addOrEditNews(context);
                },
              ),

            ],
          ),
        ),
      ),
    );
  }

}
