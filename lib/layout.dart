import 'package:flutter/material.dart';
import 'dart:developer' as developer;

void main() => runApp(const MyLoginPage());

class MyLoginPage extends StatelessWidget {
  const MyLoginPage({super.key});

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
              obscureText: true,
              decoration: const InputDecoration(hintText: '输入密码'),
              controller: pwdController,
            ),
            Padding(
                padding: const EdgeInsets.all(16),
                child: ConstrainedBox(
                    constraints: const BoxConstraints.expand(height: 55.0),
                    child: ElevatedButton(
                      onPressed: () {
                        developer.log(
                            '${userController.text}---${pwdController.text}登录');
                      },
                      child: const Text('登录'),
                    )))
          ],
        ));
  }
}
