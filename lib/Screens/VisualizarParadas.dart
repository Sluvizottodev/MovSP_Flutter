import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart'; // obter a localização do usuário
import 'package:http/http.dart' as http; // fazer requisições HTTP
import 'dart:convert';

import '../componentes/BottomAppBar.dart';
import '../componentes/CustomAppBar.dart'; // manipular JSON

class ParadasProximasScreen extends StatefulWidget {
  @override
  _ParadasProximasScreenState createState() => _ParadasProximasScreenState();
}

class _ParadasProximasScreenState extends State<ParadasProximasScreen> {
  List<dynamic> paradasProximas = [];

  @override
  void initState() {
    super.initState();
    _carregarParadasProximas();
  }

  Future<void> _carregarParadasProximas() async {
    // Obtém a localização atual do usuário
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    // Faz uma requisição à API Olho Vivo para obter paradas próximas
    final response = await http.get(Uri.parse(
        'http://api.olhovivo.sptrans.com.br/v2.1/Parada/BuscarParadasProximas/${position.latitude}/${position.longitude}'
    ));

    if (response.statusCode == 200) {
      setState(() {
        paradasProximas = jsonDecode(response.body);
      });
    } else {
      throw Exception('Falha ao carregar paradas próximas');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: ListView.builder(
        itemCount: paradasProximas.length,
        itemBuilder: (context, index) {
          final parada = paradasProximas[index];
          return ListTile(
            title: Text(parada['Nome']),
            subtitle: Text('Endereço: ${parada['Endereco']}'),
            onTap: () {

            },
          );
        },
      ),
      bottomNavigationBar: BottomAppBarComponent(),
    );
  }
}
