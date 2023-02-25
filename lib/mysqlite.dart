import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() => runApp(MaterialApp(
      title: 'database',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SqlPageApp(),
    ));

class SqlPageApp extends StatefulWidget {
  const SqlPageApp({super.key});

  @override
  createState() => SqlPageState();
}

class SqlPageState extends State<SqlPageApp> {
  late Database db;

  @override
  void initState() {
    super.initState();
    openDb();
  }

  @override
  void dispose() {
    closeDb();
    super.dispose();
  }

  Future openDb() async {
    db = await openDatabase(join(await getDatabasesPath(), 'test.db'),
        version: 1, onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE User(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)');
    });
  }

  Future closeDb() async => db.close();

  Future<void> _insertUser(User user) async {
    await db.insert('User', user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> _deleteUser(int id) async {
    await db.delete('User', where: 'id = ?', whereArgs: [id]);
  }

  Future _printDataSets() async {
    print(await _query());
  }

  Future<void> _updateUser(User user) async {
    await db
        .update('User', user.toMap(), where: 'id = ?', whereArgs: [user.id]);
  }

  Future<List<User>> _query() async {
    final List<Map<String, dynamic>> result = await db.query('User');

    return List.generate(
        result.length,
        (index) => User(
            id: result[index]['id'],
            name: result[index]['name'],
            age: result[index]['age']));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('database'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    _insertUser(const User(id: 1, name: 'zhangsan', age: 20));
                  },
                  child: const Text('插入')),
              ElevatedButton(
                  onPressed: () {
                    var user = const User(id: 1, name: 'lisi', age: 100);
                    _updateUser(user);
                  },
                  child: const Text('修改')),
              ElevatedButton(
                  onPressed: _printDataSets, child: const Text('查询')),
              ElevatedButton(
                  onPressed: () {
                    _deleteUser(1);
                  },
                  child: const Text('删除')),
            ],
          )),
    );
  }
}

class User {
  final int id;
  final String name;
  final int age;

  const User({required this.id, required this.name, required this.age});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, age: $age}';
  }
}
