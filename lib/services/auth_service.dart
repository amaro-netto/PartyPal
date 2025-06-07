// services/auth_service.dart

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // Pega a instância do Firebase Auth para podermos usá-la
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // GETTER para saber o estado do login em tempo real
  // Stream é como um "rio" de dados. Sempre que o estado de login muda,
  // ele nos avisa.
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Função para FAZER LOGIN
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      // Se der erro (ex: senha errada), imprime o erro e retorna nulo
      print(e.toString());
      return null;
    }
  }

  // Função para CRIAR UMA CONTA
  Future<User?> createUserWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Função para FAZER LOGOUT
  Future<void> signOut() async {
    await _auth.signOut();
  }
}