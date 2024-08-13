import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterService {

  final String apiUrl = 'http://192.168.100.5:8000/api/register';

  Future<Map<String, dynamic>> register(String identification, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'identification': identification, 'email': email, 'password': password, 'password_confirmation': password}),
      );
      print(response);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to register');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
