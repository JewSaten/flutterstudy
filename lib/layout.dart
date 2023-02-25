import 'package:flutter/material.dart';
import 'dart:developer' as developer;

import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MyLoginPage());

class MyLoginPage extends StatelessWidget {
  const MyLoginPage

  ({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: LoginPage());
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  TextEditingController userController = TextEditingController();
  TextEditingController pwdController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _readAccount();
  }

  Future<void> _readAccount() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userController.text = prefs.getString('user') ?? '';
      pwdController.text = prefs.getString('pwd') ?? '';
    });
  }

  Future<void> _saveAccount() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user', userController.text);
    prefs.setString('pwd', pwdController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('login page'),
        ),
      ),
      body: _buildLoginView(),
    );
  }

  Widget _buildLoginView() {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Image.asset(
              'images/bg.jpg',
              width: 600,
              height: 240,
              fit: BoxFit.cover,
            ),

            TextField(
              decoration: const InputDecoration(hintText: '输入账号'),
              controller: userController,
            ),
            TextField(
              decoration: const InputDecoration(hintText: '输入密码'),
              controller: pwdController,
            ),
            Padding(
                padding: const EdgeInsets.all(16),
                child: ConstrainedBox(
                    constraints: const BoxConstraints.expand(height: 55.0),
                    child: ElevatedButton(
                      onPressed: _saveAccount,
                      child: const Text('登录'),
                    )))
          ],
        ));
  }
}
