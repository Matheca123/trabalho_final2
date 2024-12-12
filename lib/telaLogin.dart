import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Telalogin extends StatefulWidget {
  const Telalogin({super.key});

  @override
  _TelaloginState createState() => _TelaloginState();
}

class _TelaloginState extends State<Telalogin> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  String errorMessage = '';

  Future<void> login() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: senhaController.text,
      );
      // Aqui você pode redirecionar para qualquer outra tela que queira
      // Vou redirecionar para a tela inicial apenas como exemplo
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Scaffold(body: Center(child: Text('Bem-vindo ao PocketCash!')))), 
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message ?? "Erro desconhecido.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      appBar: AppBar(
        title: const Text(
          "Tela de Login",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple[600],
        elevation: 5,
        leading: const Icon(Icons.menu),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context); // Volta para a tela inicial
            },
            icon: const Icon(Icons.logout),
            color: Colors.black,
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildCustomTextField("Email", emailController, Colors.deepPurple[500]!),
              const SizedBox(height: 20),
              _buildCustomTextField("Senha", senhaController, Colors.deepPurple[500]!, obscureText: true),
              const SizedBox(height: 20),
              if (errorMessage.isNotEmpty)
                Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: login,
                child: const Text("Login"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomTextField(String label, TextEditingController controller, Color color, {bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: color),
        border: OutlineInputBorder(),
      ),
    );
  }
}
