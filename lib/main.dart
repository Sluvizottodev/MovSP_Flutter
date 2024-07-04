import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Screens/HomeScreen.dart';
import 'utils/ThemeProvider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: MoveSPApp(),
    ),
  );
}

class MoveSPApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mov SP',
      theme: context.watch<ThemeProvider>().getTheme(),
      home: TelaHome(),
    );
  }
}
//está dando erro na integração da API, não vou conseguir concluir, ainda assim, agradeço a oportunidade!
///Obrigada!