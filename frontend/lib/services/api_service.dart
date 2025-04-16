import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static Future<String> performCipher({
    required String cipher,
    required String operation,
    required String text,
    String? key,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/cipher/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'cipher': cipher,
          'operation': operation.toLowerCase(),
          'text': text,
          'key': key,
        }),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body)['result'];
      } else {
        throw Exception(json.decode(response.body)['detail'] ?? 'API Error');
      }
    } catch (e) {
      throw Exception('Failed to connect: $e');
    }
  }
}
