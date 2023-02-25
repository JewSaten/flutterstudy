import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(MaterialApp(
      title: 'File Read / Write',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const FileDemo(),
    ));

class FileDemo extends StatefulWidget {
  const FileDemo({super.key});

  @override
  createState() => FileDemoState();
}

class FileDemoState extends State<FileDemo> {
  final textEditController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _readContent();
  }

  Future<File> _getLocalFile() async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    return File('$dir/content.txt');
  }

  Future<void> _readContent() async {
    File file = await _getLocalFile();
    String content = await file.readAsString();
    setState(() {
      textEditController.text = content;
    });
  }

  Future<void> _writeContent() async {
    await (await _getLocalFile()).writeAsString(textEditController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('文件')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
                controller: textEditController,
                decoration: InputDecoration(hintText: '输入内容'),
                maxLines: 5),
            ElevatedButton(onPressed: _writeContent, child: Text('保存内容')),
          ],
        ),
      ),
    );
  }
}
