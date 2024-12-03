import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart' as http;

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? image;
  final picker = ImagePicker();
  bool loading = false;

  Future getImage() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 80);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {});
    } else {
      print("no select image");
    }
  }

  Future<void> uploadImage() async {
    setState(() {
      loading = true;
    });
    try {
      var stream = new http.ByteStream(image!.openRead());
      stream.cast();
      var length = await image!.length();
      var url = Uri.parse('https://fakestoreapi.com/products');
      var request = new http.MultipartRequest('POST', url);
      request.fields['title'] = 'Static title';

      var multiport = new http.MultipartFile('image', stream, length);
      request.files.add(multiport);
      var response = await request.send();

      if(response.statusCode == 200){
        print("Image Uploaded");
      } else {
        print("Image not Uploaded");

      }
    } catch (e) {
      print(e.toString());

    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: loading,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Upload Image"),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: image == null
                  ? Center(
                      child: ElevatedButton(onPressed: () {
                        getImage();
                      },
                      child: Text("Pick Image")),
                    )
                  : Container(
                      child: Center(
                        child: Image.file(
                          File(image!.path).absolute,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
            ),
            SizedBox(height: 125,),
            ElevatedButton.icon(onPressed: () {
              uploadImage();
            }, icon: Icon(Icons.add_a_photo), label: Text("click"),)
          ],
        ),
      ),
    );
  }
}
