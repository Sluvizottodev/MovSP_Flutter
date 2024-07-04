import 'package:flutter/material.dart';
import '../Screens/Configs.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function()? onSettings;

  CustomAppBar({
    this.onSettings,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false, // Remove o botão de retorno (seta)
      title: Image.asset('lib/png/logo.png', width: 350), // Logo centralizada
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TelaConfiguracoes()), // Substitua pelo nome correto da tela de configurações
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
