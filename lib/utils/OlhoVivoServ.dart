import 'dart:convert';
import 'package:http/http.dart' as http;

class OlhoVivoService {
  static final String _apiKey = 'a83f6e12d25b9935516dd137f57876e526e976db72d0f4595969fd1feb5cb73c';
  static String _cookie = '';

  static Future<String> authenticate() async {
    final response = await http.post(
      Uri.parse('http://api.olhovivo.sptrans.com.br/v2.1/Login/Autenticar'),
      body: {'token': _apiKey},
    );

    if (response.statusCode == 200 && response.body == 'true') {
      // Extraímos o cookie da resposta
      _cookie = response.headers['set-cookie']!;
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
