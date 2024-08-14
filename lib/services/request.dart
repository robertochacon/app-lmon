import 'dart:convert';
import 'package:http/http.dart' as http;

class RequestService {

  final String apiUrl = 'http://192.168.100.5:8000/api/';

  Future<Map<String, dynamic>> register(String identification, String amount, String quotas, String total) async {
    
    try {

      final response = await http.post(
        Uri.parse('${apiUrl}requests'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'identification': identification, 'amount': amount, 'quotas': quotas, 'total': total, }),
      );

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

  Future getRequests() async {
    var response = await http.get(Uri.parse('${apiUrl}requests'));
    var data = jsonDecode(response.body);
    return data;

  }

}
