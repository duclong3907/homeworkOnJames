import 'dart:io';

const String baseUrlApi = '$baseUrl/api';
const String baseUrl = 'https://192.168.1.6:5001';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}