import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quizapp/services/auth_service.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("L O G I N"),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FlutterLogo(
              size: 150,
            ),
            Flexible(
              child: LoginButton(
                color: Colors.deepPurpleAccent,
                icon: FontAwesomeIcons.userNinja,
                text: "Continuar como guest",
                loginMethod: AuthService().anonLogin,
              ),
            ),
            Flexible(
              child: LoginButton(
                color: Colors.deepPurpleAccent,
                icon: FontAwesomeIcons.google,
                text: "Continuar com Google",
                loginMethod: AuthService().googleLogin,
              ),
            ),
            Flexible(
              child: LoginButton(
                color: Colors.deepPurpleAccent,
                icon: FontAwesomeIcons.apple,
                text: "Continuar com Apple",
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
  final Color color;
  final IconData icon;
  final String text;
  final Function loginMethod;

  const LoginButton({
    super.key,
    required this.color,
    required this.icon,
    required this.text,
    required this.loginMethod,
  });

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
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(24),
          backgroundColor: color,
        ),
        label: Text(text),
      ),
    );
  }
}
