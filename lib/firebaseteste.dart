import 'package:conexao_firebase/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _nameController = TextEditingController();

  Future<void> addUser() async {
    final String name = _nameController.text;

    if (name.isEmpty) {
      print("Nome não pode estar vazio!");
      return;
    }

    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users.add({
      'full_name': name,
      'age': 25, 
    }).then((value) {
      print("User Added");
      _nameController.clear();
    }).catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Adicionar Usuário'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "Nome Completo",
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    addUser();  
                  },
                  child: Text("Adicionar Usuário"),
                ),
                SizedBox(height: 20),
                Text('Check console for CRUD operations'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
