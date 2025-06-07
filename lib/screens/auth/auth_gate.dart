// screens/auth/auth_gate.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:festa_facil/screens/auth/login_screen.dart'; // Vamos criar já já
import 'package:festa_facil/screens/organizer/home_screen.dart'; // Vamos criar depois

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      // Ouve o "rio" de dados do nosso AuthService
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Se não tem usuário (snapshot não tem dados), mostra a tela de login
        if (!snapshot.hasData) {
          return LoginScreen(); // Vamos criar esta tela agora
        }

        // Se tem usuário, mostra a tela principal do organizador
        // Por enquanto, vamos usar um placeholder simples
        return HomeScreen(); 
      },
    );
  }
}