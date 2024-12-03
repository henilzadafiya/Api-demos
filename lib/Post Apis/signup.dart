import 'dart:io';

import 'package:apitutatorial/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String message = '';

  Future<String> login(String email, String password) async {
    try {
      var url = Uri.parse('https://reqres.in/api/register');
      final response =
          await http.post(url, body: {'email': email, 'password': password});
      if (response.statusCode == 200) {
        // print("Register");
        message = 'success';
        return message;
      } else {
        // print("Failed");
        message = 'failed';
        return message;
      }
    } on SocketException {
      // print("socket error");
      message = 'socket error';
      return message;
    } catch (e) {
      print(e.toString());
    }
    return message;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up Api"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              decoration: const InputDecoration(hintText: 'Enter Email'),
              controller: emailController,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Enter Password'),
              controller: passwordController,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  String msg = await login(
                      emailController.text, passwordController.text);
                  print(msg);
                  if (message == 'success') {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const ProductScreen();
                      },
                    ));
                  } else {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(const SnackBar(
                          content: Text("incorrect credential")));
                  }
                },
                child: const Text("Login"))
          ],
        ),
      ),
    );
  }
}
