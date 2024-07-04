import 'package:flutter/material.dart';
import '../componentes/BottomAppBar.dart';
import '../componentes/CustomAppBar.dart';
import '../utils/OlhoVivoServ.dart';


class ConsultarLinhasScreen extends StatefulWidget {
  @override
  _ConsultarLinhasScreenState createState() => _ConsultarLinhasScreenState();
}

class _ConsultarLinhasScreenState extends State<ConsultarLinhasScreen> {
  List<dynamic> _busLines = [];

  @override
  void initState() {
    super.initState();
    _fetchBusLines();
  }

  Future<void> _fetchBusLines() async {
    try {
      List<dynamic> busLines = await OlhoVivoService.fetchBusLines();
      setState(() {
        _busLines = busLines;
      });
    } catch (e) {
      print('Erro ao carregar linhas de ônibus: $e');
      // Tratamento de erro
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: _busLines.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _busLines.length,
        itemBuilder: (context, index) {
          final busLine = _busLines[index];
          return ListTile(
            title: Text(
              'Linha: ${busLine['Letreiro']}-${busLine['Sentido'] == 1 ? 'Ida' : 'Volta'}',
              style: TextStyle(color: Colors.black),
            ),
            subtitle: Text(
              'Código: ${busLine['CodigoLinha']}',
              style: TextStyle(color: Colors.grey),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBarComponent(),
    );
  }
}
