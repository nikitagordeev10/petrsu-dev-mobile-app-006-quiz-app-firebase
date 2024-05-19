import 'package:flutter/material.dart';
import 'package:quizapp/login/login_page.dart';
import 'package:quizapp/services/auth_service.dart';
import 'package:quizapp/topics/topics_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userStream = AuthService().userStream;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasData) {
          return TopicsPage();
        }

        if (snapshot.hasError) {
          throw Exception();
        }

        return LoginPage();
      },
    );
  }
}
