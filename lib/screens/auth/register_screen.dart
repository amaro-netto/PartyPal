// screens/auth/register_screen.dart

import 'package:festa_facil/services/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Controladores para ler o que o usuário digita
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  // Função para lidar com o toque no botão de cadastro
  void _signUp() async {
    // Pega o email e a senha dos controladores
    String email = _emailController.text;
    String password = _passwordController.text;

    // Usa o nosso serviço de autenticação para criar o usuário
    final user = await _authService.createUserWithEmailAndPassword(email, password);

    // Se o usuário for criado com sucesso, o AuthGate vai lidar com o redirecionamento.
    // Se não, podemos mostrar uma mensagem de erro (faremos isso depois).
    if (user != null) {
      print("Usuário criado com sucesso!");
      // O Navigator.pop() fecha a tela de cadastro e volta para a tela anterior
      // Como o AuthGate vai nos redirecionar, isso garante que não fiquemos na tela de login
      if (mounted) Navigator.pop(context);
    } else {
      print("Ocorreu um erro no cadastro.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cadastro - Organizador")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Crie sua conta de Organizador",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "E-mail"),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: "Senha"),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signUp, // Chama a função de cadastro
              child: const Text("Cadastrar"),
            ),
          ],
        ),
      ),
    );
  }
}