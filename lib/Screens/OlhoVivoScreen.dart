import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OlhoVivoScreen extends StatefulWidget {
  @override
  _OlhoVivoScreenState createState() => _OlhoVivoScreenState();
}

class _OlhoVivoScreenState extends State<OlhoVivoScreen> {
  List<dynamic> _busLines = []; // Lista para armazenar as linhas de ônibus
  bool _isLoading = false; // Estado para controlar o carregamento

  @override
  void initState() {
    super.initState();
    _fetchBusLines(); // Inicia a busca das linhas de ônibus ao carregar a tela
  }

  Future<void> _fetchBusLines() async {
    setState(() {
      _isLoading = true; // Ativa o estado de carregamento
    });

    // URL da API Olho Vivo para buscar linhas de ônibus
    final url = Uri.parse('http://api.olhovivo.sptrans.com.br/v3.0/Linha/Buscar');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Cookie': 'AUTH=your_auth_token_here', // Substitua pelo seu token de autenticação
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        setState(() {
          _busLines = jsonData['linhas'] ?? []; // Armazena as linhas de ônibus recebidas
          _isLoading = false; // Desativa o estado de carregamento
        });
      } else {
        throw Exception('Falha ao carregar as linhas de ônibus');
      }
    } catch (error) {
      print('Erro na requisição: $error');
      setState(() {
        _isLoading = false; // Desativa o estado de carregamento em caso de erro
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rotas de Ônibus - Olho Vivo'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _busLines.length,
        itemBuilder: (context, index) {
          final busLine = _busLines[index];
          return ListTile(
            title: Text(
              'Linha: ${busLine['codigoLinha']} - ${busLine['denominacaoTPTS']}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Sentido: ${busLine['sentido']}'),
            onTap: () {
              _showBusLineDetails(busLine['codigoLinha']);
            },
          );
        },
      ),
    );
  }

  Future<void> _showBusLineDetails(String busLineCode) async {
    // URL da API Olho Vivo para detalhes de uma linha de ônibus
    final url = Uri.parse(
        'http://api.olhovivo.sptrans.com.br/v3.0/Linha/BuscarDetalhes?codigoLinha=$busLineCode');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Cookie': 'AUTH=your_auth_token_here', // Substitua pelo seu token de autenticação
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        // Exemplo de como exibir os detalhes da linha de ônibus (pode ser adaptado conforme necessário)
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Detalhes da Linha'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Código: $busLineCode'),
                  SizedBox(height: 10),
                  Text('Denominação: ${jsonData['nome']}'),
                  SizedBox(height: 10),
                  Text('Tipo: ${jsonData['tipo']}'),
                  SizedBox(height: 10),
                  Text('Operação: ${jsonData['operacao']}'),
                  SizedBox(height: 10),
                  Text('Sentido: ${jsonData['sentido']}'),
                  SizedBox(height: 10),
                  Text('Lotação: ${jsonData['lotacao']}'),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Fechar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        throw Exception('Falha ao carregar os detalhes da linha de ônibus');
      }
    } catch (error) {
      print('Erro na requisição: $error');
    }
  }
}
