import 'package:flutter/material.dart';
import 'package:flutter_application_1/extensions/AppLocaleX.dart';
import 'dart:developer' as developer;
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MyLoginPage());

class MyLoginPage extends StatelessWidget {
  const MyLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: LoginPage(),
    );
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
    final l10n = context.l10n;
    return Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(child: Column( //  Pixels Overflow Error while Launching Keyboard
          children: <Widget>[
            Text(l10n!.hello('param with Placeholders')),
            const SizedBox(height: 10),
            Image.asset(
              'images/bg.jpg',
              width: 600,
              height: 240,
              fit: BoxFit.cover,
            ),
            TextField(
              decoration:  InputDecoration(hintText: l10n?.user_input_hint_text),
              controller: userController,
            ),
            TextField(
              decoration: InputDecoration(hintText: l10n?.pwd_input_hint_text),
              controller: pwdController,
            ),
            Padding(
                padding: const EdgeInsets.all(16),
                child: ConstrainedBox(
                    constraints: const BoxConstraints.expand(height: 55.0),
                    child: ElevatedButton(
                      onPressed: _saveAccount,
                      child: Text(l10n!.login_btn_text),
                    )))
          ],
        )));
  }
}
