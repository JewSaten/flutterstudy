import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(title: 'dio', home: DioPageRoute()));

class DioPageRoute extends StatefulWidget {
  const DioPageRoute({super.key});

  @override
  createState() => DioPageState();
}

class DioPageState extends State<DioPageRoute> {
  final Dio _dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Dio Demo')),
        body: Container(
            alignment: Alignment.center,
            child: FutureBuilder(
                future:
                    _dio.get("https://api.github.com/orgs/flutterchina/repos"),
                builder: (context, result) {
                  if (result.hasData) {
                    return ListView(
                        children: result!.data!.data
                            .map<Widget>(
                                (e) => ListTile(title: Text(e['full_name'])))
                            .toList());
                  } else if (result.hasError) {
                    return Text('has error ${result.error}');
                  }
                  return const CircularProgressIndicator();
                })));
  }
}
