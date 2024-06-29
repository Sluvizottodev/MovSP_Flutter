import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/ThemeProvider.dart';

class TelaConfiguracoes extends StatelessWidget {
  const TelaConfiguracoes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      children: [
        SwitchListTile(
          title: const Text('Modo Escuro'),
          value: context.watch<ThemeProvider>().isDarkMode,
          onChanged: (value) {
            context.read<ThemeProvider>().toggleTheme();
          },
        ),
        ListTile(
          title: const Text('Notificações'),
          onTap: () {
            // Implementar a navegação para a tela de configuração de notificações
            // Navigator.push(context, MaterialPageRoute(builder: (context) => TelaConfiguracaoNotificacoes()));
          },
        ),
        // Outras opções de configuração podem ser adicionadas aqui
      ],
    );
  }
}
