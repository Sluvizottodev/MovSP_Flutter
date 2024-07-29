import 'dart:convert';
import 'package:http/http.dart' as http;

class OlhoVivoService {
  static final String _apiKey = 'b1936ff2cf2a7bc847630a80b6aa28c4f4a38cda3abb8d557e8730d745642bbb'; // Use a chave correta
  static String _cookie = '';

  static Future<String> authenticate() async {
    final response = await http.post(
      Uri.parse('http://api.olhovivo.sptrans.com.br/v2.1/Login/Autenticar'),
      body: {'token': _apiKey},
    );

    if (response.statusCode == 200 && response.body == 'true') {
      _cookie = response.headers['set-cookie'] ?? '';
      return 'Autenticado';
    } else {
      return 'Falha na autenticação';
    }
  }

  static Future<List<dynamic>> fetchBusLines() async {
    final response = await http.get(
      Uri.parse('http://api.olhovivo.sptrans.com.br/v2.1/Linha/Buscar?termosBusca=8000'),
      headers: {'Cookie': _cookie},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Falha ao carregar as linhas: ${response.body}');
    }
  }
}
