import 'package:apitutatorial/photos_Screen.dart';
import 'package:apitutatorial/product_screen.dart';
import 'package:apitutatorial/user_screen.dart';
import 'package:apitutatorial/with_out_model.dart';
import 'package:flutter/material.dart';

import 'Post Apis/signup.dart';
import 'Post Apis/upload_image.dart';
import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const UploadImage(),
    );
  }
}
