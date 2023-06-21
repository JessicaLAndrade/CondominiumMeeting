import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Criar Google Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CreateFormPage(),
    );
  }
}

class CreateFormPage extends StatefulWidget {
  const CreateFormPage({Key? key}) : super(key: key);

  @override
  _CreateFormPageState createState() => _CreateFormPageState();
}

class _CreateFormPageState extends State<CreateFormPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _questionController = TextEditingController();

  String _message = '';

  Future<void> createForm() async {
    const url = 'https://forms.googleapis.com/forms/v1/forms';
    const apiKey = 'AIzaSyA9HkozS8vUzrJTCt-ME5_JMCBVbrg3j8k';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: json.encode({
        'title': _titleController.text,
        'questions': [
          {
            'question': {
              'title': _questionController.text,
              'required': true,
            },
            'index': 0,
          },
        ],
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final formId = responseData['formId'];

      setState(() {
        _message = 'Formulário criado com sucesso! ID do formulário: $formId';
      });
    } else {
      setState(() {
        _message =
            'Erro ao criar o formulário. Código de status: ${response.statusCode}';
      });
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Status do Formulário'),
          content: Text(_message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Google Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration:
                  const InputDecoration(labelText: 'Título do Formulário'),
            ),
            TextField(
              controller: _questionController,
              decoration: const InputDecoration(labelText: 'Pergunta'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                createForm();
              },
              child: const Text('Criar Formulário'),
            ),
          ],
        ),
      ),
    );
  }
}
