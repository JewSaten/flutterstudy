import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


void main()=>runApp(const MaterialApp(title: '',home: HttpDemo()));

class HttpDemo extends StatefulWidget{
  const HttpDemo({super.key});
  @override
  createState()=>HttpDemoState();
}

class HttpDemoState extends State<HttpDemo>{

  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  Future<Album> fetchAlbum() async{
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
    if(response.statusCode == 200){
      return Album.fromJson(jsonDecode(response.body));
    }else {
      throw Exception('request failed!');
    }
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(appBar: AppBar(title: Text('http: fetch album')),body:
          FutureBuilder<Album>(future:futureAlbum,builder: (context,result){
            if(result.hasData){
              return Padding(padding: EdgeInsets.all(16),child: Column(children: [
                Row(children: [Text('userId'),SizedBox(width: 10),Text('id'),SizedBox(width: 10),Text('title')]),
                Row(children: [Text('${result.data!.userId}'),SizedBox(width: 10),Text('${result.data!.id}'),SizedBox(width: 10),Text(result.data!.title)])
              ]));
            }else if(result.hasError){
              return Text('error ${result.error}');
            }
            return const CircularProgressIndicator();
          })
      );
  }
}


class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}