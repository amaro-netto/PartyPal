import 'package:flutter/material.dart';
import 'package:myapp/admin_screen.dart'; // Importe a tela do administrador

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(), // Definindo a tela de login como a tela inicial
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controllers para os campos de texto
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // Dispose dos controllers quando o widget for descartado
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    // Credenciais temporárias de administrador
    const String adminUsername = 'admin';
    const String adminPassword = 'password123';

    String enteredUsername = _usernameController.text;
    String enteredPassword = _passwordController.text;

    if (enteredUsername == adminUsername && enteredPassword == adminPassword) {
      // Credenciais corretas, navegar para a tela do administrador
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AdminScreen()),
      );
    } else {
      // Credenciais incorretas, mostrar mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Usuário ou senha inválidos!'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: SingleChildScrollView( // Adicionado para evitar overflow no teclado
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Logo no topo (mantido do código anterior)
              // Certifique-se de que o caminho e o asset no pubspec.yaml estão corretos
              // Image.asset(
              //   'assets/images/logo_top.png', // <--- SUBSTITUA PELO CAMINHO DA SUA LOGO DO TOPO
              //   height: 100, // Ajuste a altura conforme necessário
              // ),
              // SizedBox(height: 40), // Espaço entre a logo e os campos de texto

              // Campos de texto
              TextField(
                controller: _usernameController, // Associado ao controller
                decoration: const InputDecoration(
                  labelText: 'Usuário', // Alterado para 'Usuário' ou manter 'Email'
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _passwordController, // Associado ao controller
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              // Botão de login
              ElevatedButton(
                onPressed: _login, // Chama o método _login
                child: const Text('Entrar'),
              ),

              // Parte inferior com logo e texto (mantido do código anterior)
              // Expanded(
              //   child: Align(
              //     alignment: Alignment.bottomCenter,
              //     child: Column(
              //       mainAxisSize: MainAxisSize.min,
              //       children: [
              //         // Image.asset(
              //         //   'assets/images/logo_bottom.png', // <--- SUBSTITUA PELO CAMINHO DA SUA LOGO DE BAIXO
              //         //   height: 50, // Ajuste a altura conforme necessário para uma logo menor
              //         // ),
              //         // SizedBox(height: 5),
              //         // Text(
              //         //   'desenvolvido por amaro netto soluções',
              //         //   style: TextStyle(fontSize: 12, color: Colors.grey),
              //         // ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
