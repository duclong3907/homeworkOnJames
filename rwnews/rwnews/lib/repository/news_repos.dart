import 'dart:convert';
import 'dart:io';
import '../config/config_http.dart';
import 'package:http/http.dart' as http;
import '../models/news_model.dart';

class NewsRepository {
  final String baseUrl = '$baseUrlApi/News';

  NewsRepository() {
    HttpOverrides.global = MyHttpOverrides();
  }

  Future<List<News>> getNews() async {
    try {
      var url = Uri.parse(baseUrl);
      final response = await http.get(url, headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        List<dynamic> jsonList = jsonResponse['news'] as List<dynamic>;
        return jsonList.map((json) => News.fromJson(json)).toList();
      } else {
        final Map<String, dynamic> errorResponse = json.decode(response.body);
        throw Exception(errorResponse["message"]);
      }
    } catch (e) {
      throw Exception('$e');
    }
  }

  Future<News> getNewsById(int id) async {
    try{
      var url = Uri.parse('$baseUrl/$id');
      final response = await http.get(url, headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        print(response.body);
        return News.fromJson(json.decode(response.body));
      } else {
        final Map<String, dynamic> errorResponse = json.decode(response.body);
        throw Exception(errorResponse["message"]);
      }
    }catch(e){
      print(e);
      throw Exception('$e');
    }
  }


  Future<Map<String, dynamic>> addNews(Map<String, dynamic> requestBody) async {
    try {
      var url = Uri.parse(baseUrl);
      final body = json.encode(requestBody);
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      if (response.statusCode == 200) {
        print(json.decode(response.body));
        return {'status': true, 'message': json.decode(response.body)['message']};
      } else {
        return {'status': false, 'message': json.decode(response.body)['message']};
      }
    } catch (e) {
      throw Exception('$e');
    }
  }

  Future<Map<String, dynamic>> updateNews(int id, Map<String, dynamic> requestBody) async {
    try {
      var url = Uri.parse('$baseUrl/$id');
      final body = json.encode(requestBody);
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      if (response.statusCode == 200) {
        print(json.decode(response.body)['message']);
        return {'status': true, 'message': json.decode(response.body)['message']};
      } else {
        return {'status': false, 'message': json.decode(response.body)['message']};
      }
    } catch (e) {
      throw Exception('$e');
    }
  }

  Future<Map<String, dynamic>> deleteNews(int id) async {
    try {
      var url = Uri.parse('$baseUrl/$id');
      final response = await http.delete(url, headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        return {'status': true, 'message': json.decode(response.body)['message']};
      } else {
        return {'status': false, 'message': json.decode(response.body)['message']};
      }
    } catch (e) {
      throw Exception('$e');
    }
  }

}