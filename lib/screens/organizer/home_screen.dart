// screens/organizer/home_screen.dart

import 'package:festa_facil/screens/organizer/create_event_screen.dart'; // Importa a nova tela
import 'package:flutter/material.dart';
import 'package:festa_facil/services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus Eventos"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _authService.signOut();
            },
          ),
        ],
      ),
      body: const Center(
        child: Text("Bem-vindo, Organizador!"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // AÇÃO ADICIONADA AQUI!
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateEventScreen()),
          );
        },
        child: const Icon(Icons.add),
        tooltip: 'Criar Novo Evento',
      ),
    );
  }
}