import 'package:flutter/material.dart';
import '../utils/OlhoVivoServ.dart';
import '../componentes/CustomAppBar.dart';
import '../componentes/BottomAppBar.dart';

class TelaHome extends StatefulWidget {
  @override
  _TelaHomeState createState() => _TelaHomeState();
}

class _TelaHomeState extends State<TelaHome> {
  String _authToken = '';
  List<dynamic> _busLines = [];

  @override
  void initState() {
    super.initState();
    _authenticate();
  }

  Future<void> _authenticate() async {
    String authToken = await OlhoVivoService.authenticate();
    setState(() {
      _authToken = authToken;
    });
    if (_authToken == 'Autenticado') {
      _fetchBusLines();
    }
  }

  Future<void> _fetchBusLines() async {
    List<dynamic> busLines = await OlhoVivoService.fetchBusLines();
    setState(() {
      _busLines = busLines;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            'lib/png/logoVermelhaNome.png',
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.4),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Bem-vindo ao Mov SP!',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  'Status de Autenticação: $_authToken',
                  style: TextStyle(color: Colors.white),
                ),
                if (_busLines.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      itemCount: _busLines.length,
                      itemBuilder: (context, index) {
                        final busLine = _busLines[index];
                        return ListTile(
                          title: Text(
                            'Linha: ${busLine['Letreiro']}-${busLine['Sentido'] == 1 ? 'Ida' : 'Volta'}',
                            style: TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            'Código: ${busLine['CodigoLinha']}',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBarComponent(),
    );
  }
}
