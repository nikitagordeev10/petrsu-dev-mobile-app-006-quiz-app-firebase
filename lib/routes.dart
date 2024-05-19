import 'package:museumguide/about/about_page.dart';
import 'package:museumguide/home/home_page.dart';
import 'package:museumguide/login/login_page.dart';
import 'package:museumguide/topics/topics_page.dart';
import 'package:museumguide/profile/profile_page.dart';

var appRoutes = {
  '/': (context) => const HomePage(),
  '/login': (context) => const LoginPage(),
  '/topics': (context) => const TopicsPage(),
  '/profile': (context) => const ProfilePage(),
  '/about': (context) => const AboutPage(),
};
