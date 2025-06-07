// screens/organizer/home_screen.dart

import 'package:flutter/material.dart';
import 'package:festa_facil/services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus Eventos"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await _authService.signOut();
            },
          ),
        ],
      ),
      body: Center(
        child: Text("Bem-vindo, Organizador!"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navegar para a tela de criar evento
        },
        child: Icon(Icons.add),
        tooltip: 'Criar Novo Evento',
      ),
    );
  }
}