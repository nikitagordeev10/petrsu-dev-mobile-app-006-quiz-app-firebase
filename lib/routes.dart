import 'package:quizapp/about/about_page.dart';
import 'package:quizapp/home/home_page.dart';
import 'package:quizapp/login/login_page.dart';
import 'package:quizapp/topics/topics_page.dart';
import 'package:quizapp/profile/profile_page.dart';

var appRoutes = {
  '/': (context) => const HomePage(),
  '/login': (context) => const LoginPage(),
  '/topics': (context) => const TopicsPage(),
  '/profile': (context) => const ProfilePage(),
  '/about': (context) => const AboutPage(),
};
