import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../widgets/login_button.dart';
import '../../widgets/login_datafield.dart';
import 'package:pizza_app/main.dart';
import '../../widgets/loading.dart';
import 'package:email_validator/email_validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future signIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => const LoadingWidget(),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Ошибка входа'),
          content: Text('$e'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                navigatorKey.currentState!
                    .popUntil(ModalRoute.withName('/start'));
              },
              child: const Text('OK'),
            )
          ],
        ),
      );
    }

    navigatorKey.currentState!.popUntil(ModalRoute.withName('/start'));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 100.0, horizontal: 100.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Добро пожаловать!',
                    style: TextStyle(
                      fontSize: 36.0,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  const Text(
                    'Добро пожаловать! Введите ваши данные для входа',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 100.0),
                  LoginDataField(
                    validator: (email) {
                      if (!(EmailValidator.validate(email)) &&
                          email.isNotEmpty) {
                        return "Enter a valid email address!";
                      }
                      return null;
                    },
                    controller: _emailController,
                    text: 'Email',
                    hinttext: 'Введите ваш адрес эл. почты',
                    obscureText: false,
                  ),
                  const SizedBox(height: 30.0),
                  LoginDataField(
                    validator: null,
                    controller: _passwordController,
                    text: 'Пароль',
                    hinttext: 'Введите ваш пароль',
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  LoginButton(
                      buttonColor: Colors.orangeAccent,
                      textColor: Colors.white,
                      text: 'Войти',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          signIn();
                        }
                      }),
                  const SizedBox(height: 10.0),
                  LoginButton(
                    buttonColor: Colors.white,
                    textColor: Colors.black,
                    text: 'Регистрация',
                    onPressed: () {
                      print('hello');
                    },
                  )
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.orange,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'images/pizza_logo.png',
                  height: 150.0,
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'Пиццерия',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36.0,
                    fontFamily: 'Lobster',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
