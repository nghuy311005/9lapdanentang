// lib/services/networking.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper {
  final String url;

  NetworkHelper(this.url);

  Future<dynamic> getData() async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('❌ Failed to load data. Status code: ${response.statusCode}');
        print('🔎 Response body: ${response.body}');
        return null;
      }
    } catch (e) {
      print('❌ Exception when calling API: $e');
      return null;
    }
  }
}
