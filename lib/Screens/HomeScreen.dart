import 'package:flutter/material.dart';

class TelaHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Move SP'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Implementação para navegar para a tela de configurações
              // Substitua pelo código de navegação desejado
              print('Configurações');
            },
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Background Image
          Image.asset(
            'lib/assets/logoVermelhaNome.png',
            fit: BoxFit.cover,
          ),
          // Overlay with color
          Container(
            color: Colors.black.withOpacity(0.4), // Dark overlay color
          ),
          // Content Centered
          Center(
            child: Text(
              'Bem-vindo ao Move SP!',
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
