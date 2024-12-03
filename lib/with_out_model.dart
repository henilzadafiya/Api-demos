import 'dart:convert';

import 'package:apitutatorial/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WithOutModel extends StatefulWidget {
  const WithOutModel({super.key});

  @override
  State<WithOutModel> createState() => _WithOutModelState();
}

class _WithOutModelState extends State<WithOutModel> {
  var data;

  Future<void> getApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Api without model')),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: getApi(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }else
              {
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ReusableRow(name: 'Name', value: data[index]['name'].toString()),
                        ReusableRow(name: 'Address', value: data[index]['address']['city'].toString()),
                        ReusableRow(name: 'Address', value: data[index]['address']['geo']['lat'].toString()),
                      ],
                    );
                  },
                );
              }
            },
          ))
        ],
      ),
    );
  }
}
