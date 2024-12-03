import 'dart:convert';

import 'package:apitutatorial/Models/PhotosModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PhotosScreen extends StatefulWidget {
  const PhotosScreen({super.key});

  @override
  State<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  List<PhotosModel> photosList = [];

  Future<List<PhotosModel>> getPhotosApi() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (Map i in data) {
        PhotosModel photosModel = PhotosModel(
            title: i['title'], url: i['url'], thumbnailUrl: i['thumbnailUrl'], id: i['id']);
        photosList.add(photosModel);
      }
      return photosList;
    } else {
      return photosList;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPhotosApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Photos Api"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPhotosApi(),
              builder: (context, AsyncSnapshot<List<PhotosModel>> snapshot) {
                return ListView.builder(
                  itemCount: photosList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data![index].title),
                      subtitle: Text('Nodes Id '+snapshot.data![index].id.toString()),
                      leading: CircleAvatar(backgroundImage: NetworkImage(snapshot.data![index].url),),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
