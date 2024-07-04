import 'package:flutter/material.dart';
import '../Screens/HomeScreen.dart';
import '../Screens/OlhoVivoScreen.dart';
import '../Screens/VisualizarParadas.dart'; // Importe a tela de paradas próximas aqui
import '../Screens/ConsultarLinhasScreen.dart'; // Importe a tela de consulta de linhas aqui

class BottomAppBarComponent extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 6.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => TelaHome()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.directions_bus),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OlhoVivoScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ParadasProximasScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.search), // Ícone para consultar linhas
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ConsultarLinhasScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
