import 'package:get/get.dart';
import 'package:rwnews/view_models/news_view_model.dart';

class DetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NewsViewModel());
  }
}