import 'dart:convert';
import 'package:http/http.dart' as http;

class RequestService {

  final String apiUrl = 'http://192.168.100.5:8000/api/register';

  Future<Map<String, dynamic>> register(String identification, int amount, int quotas, int total) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'identification': identification, 'amount': amount, 'quotas': quotas, 'total': total, }),
      );

      print(response);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 400) {
          throw Exception('Bad request, 400');
      } else {
        throw Exception('Failed to register');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
