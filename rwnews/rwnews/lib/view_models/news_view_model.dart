import 'package:get/get.dart';
import 'package:rwnews/models/news_model.dart';
import 'package:rwnews/repository/news_repos.dart';
import '../utils/alert_utils.dart';

class NewsViewModel extends GetxController {
  var newsList = [].obs;
  var newsDetail = Rxn<News>();
  var isLoading = false.obs;
  final NewsRepository _newsRepository = NewsRepository();

  @override
  void onInit() {
    fetchNews();
    super.onInit();
  }

  Future<void> fetchNews() async {
    isLoading.value = true;
    try {
      var result = await _newsRepository.getNews();
      newsList.value = result;
    } catch (e) {
      AlertUtils.showErrorSnackbar('$e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchNewsById(int id) async {
    try {
      newsDetail.value = await _newsRepository.getNewsById(id);
    } catch (e) {
      print(e);
      AlertUtils.showErrorSnackbar('$e');
    }
  }

  Future<bool> addNews(Map<String, dynamic> requestBody) async {
    try {
      var result = await _newsRepository.addNews(requestBody);
      if(result['status']){
        fetchNews();
        AlertUtils.showSuccessSnackbar(result['message']);
      }else{
        AlertUtils.showWarningSnackbar(result['message']);
      }
      return true;
    } catch (e) {
      AlertUtils.showErrorSnackbar('$e');
      return false;
    }
  }

  Future<bool> updateNews(int id, Map<String, dynamic> requestBody) async {
    try {
      var result = await _newsRepository.updateNews(id, requestBody);
      if(result['status']){
        fetchNews();
        AlertUtils.showSuccessSnackbar(result['message']);
      }else{
        AlertUtils.showWarningSnackbar(result['message']);
      }
      return true;
    } catch (e) {
      AlertUtils.showErrorSnackbar('$e');
      return false;
    }
  }

  Future<void> deleteNews(int id) async {
    try {
      var result = await _newsRepository.deleteNews(id);
      if(result['status']){
        fetchNews();
        AlertUtils.showSuccessSnackbar(result['message']);
      }else{
        AlertUtils.showWarningSnackbar(result['message']);
      }
    } catch (e) {
      AlertUtils.showErrorSnackbar('$e');
    }
  }

}