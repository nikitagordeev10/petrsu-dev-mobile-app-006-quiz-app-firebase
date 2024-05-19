import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          label: "Topics",
          icon: Icon(
            FontAwesomeIcons.graduationCap,
            size: 20,
          ),
        ),
        BottomNavigationBarItem(
          label: "About",
          icon: Icon(
            FontAwesomeIcons.bolt,
            size: 20,
          ),
        ),
        BottomNavigationBarItem(
          label: "Profile",
          icon: Icon(
            FontAwesomeIcons.circleUser,
            size: 20,
          ),
        ),
      ],
      fixedColor: Colors.deepPurple[200],
      onTap: (value) {
        switch (value) {
          case 0:
            break;
          case 1:
            Navigator.pushNamed(context, '/about');
            break;
          case 2:
            Navigator.pushNamed(context, '/profile');
            break;
        }
      },
    );
  }
}
