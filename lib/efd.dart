import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.deepPurple[600],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.deepPurple[600],
        ),
      ),
      home: const LoginScreen(),
    );
  }
}

String? storedEmail;
String? storedPassword;

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela de Login'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  String loginError = '';

  void _attemptLogin() {
    if (storedEmail == null || storedPassword == null) {
      setState(() {
        loginError = 'Cadastre-se primeiro para fazer login.';
      });
      return;
    }

    if (emailController.text == storedEmail && senhaController.text == storedPassword) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MenuPage()),
      );
    } else {
      setState(() {
        loginError = 'Email ou senha inválidos.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: emailController,
          decoration: const InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: senhaController,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'Senha',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        if (loginError.isNotEmpty)
          Text(
            loginError,
            style: const TextStyle(color: Colors.red),
          ),
        ElevatedButton(
          onPressed: _attemptLogin,
          child: const Text('Login'),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RegisterScreen()),
            );
          },
          child: const Text('Cadastre-se'),
        ),
      ],
    );
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController confirmSenhaController = TextEditingController();
  String registerError = '';

  void _register() {
    if (senhaController.text != confirmSenhaController.text) {
      setState(() {
        registerError = 'Senhas não coincidem.';
      });
      return;
    }

    setState(() {
      storedEmail = emailController.text;
      storedPassword = senhaController.text;
      registerError = 'Cadastro concluído com sucesso!';
    });

    emailController.clear();
    senhaController.clear();
    confirmSenhaController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela de Cadastro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: senhaController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: confirmSenhaController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirme a Senha',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            if (registerError.isNotEmpty)
              Text(
                registerError,
                style: const TextStyle(color: Colors.red),
              ),
            ElevatedButton(
              onPressed: _register,
              child: const Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu Principal"),
      ),
      body: const Center(
        child: Text(
          'Bem-vindo ao Menu!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
