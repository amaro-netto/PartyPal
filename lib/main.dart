// lib/main.dart

import 'package:festa_facil/firebase_options.dart';
import 'package:festa_facil/screens/auth/auth_gate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// A função principal que inicia tudo
void main() async {
  // Garante que todos os plugins foram inicializados antes de rodar o app
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o Firebase usando as chaves do arquivo firebase_options.dart
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Roda o nosso aplicativo
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Festa Fácil',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // A tela inicial do nosso app agora é o AuthGate!
      home: const AuthGate(),
    );
  }
}