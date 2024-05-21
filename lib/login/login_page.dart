import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:museumguide/services/auth_service.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Color(0xFF1AACBC),
        title: Text(
          "Вход",
          textAlign: TextAlign.center, // Выравнивание текста по центру внутри AppBar
        ),
        centerTitle: true, // Устанавливаем центрирование заголовка
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/icon/icon_square.png',
              width: 150,
              height: 150,
            ),
            Text(
              'Узнай Карелию',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Flexible(
              child: LoginButton(
                icon: FontAwesomeIcons.userNinja,
                text: "Продолжить как гость",
                loginMethod: AuthService().anonLogin,
              ),
            ),
            Flexible(
              child: LoginButton(
                icon: FontAwesomeIcons.google,
                text: "Продолжить с Google",
                loginMethod: AuthService().googleLogin,
              ),
            ),
            Flexible(
              child: LoginButton(
                icon: FontAwesomeIcons.apple,
                text: "Продолжить с Apple",
                loginMethod: AuthService().signInWithApple,
              ),
            )
          ],
        ),
      ),
    );
  }
}


class LoginButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function loginMethod;

  const LoginButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.loginMethod,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: ElevatedButton.icon(
        onPressed: () => loginMethod(),
        icon: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(10),
          backgroundColor: Color(0xFF1AACBC),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          minimumSize: Size(double.infinity, 60), // Устанавливаем высоту кнопки
        ),
        label: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
