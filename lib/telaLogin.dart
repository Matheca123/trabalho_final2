import 'package:flutter/material.dart';

class Telalogin extends StatefulWidget {
  const Telalogin({super.key});

  @override
  _TelaloginState createState() => _TelaloginState();
}

class _TelaloginState extends State<Telalogin> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  String senhaError = '';

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
              Navigator.pop(context);
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
              _buildCustomTextField("Nome Completo", nomeController, Colors.deepPurple[500]!),
              const SizedBox(height: 20),
              _buildCustomTextField("Email", emailController, Colors.deepPurple[500]!),
              const SizedBox(height: 20),
              _buildCustomTextField("Senha", senhaController, Colors.deepPurple[500]!),
              const SizedBox(height: 20),
              if (senhaError.isNotEmpty)
                Text(
                  senhaError,
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomTextField(String label, TextEditingController controller, Color color) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: color),
        border: OutlineInputBorder(),
      ),
    );
  }
}
