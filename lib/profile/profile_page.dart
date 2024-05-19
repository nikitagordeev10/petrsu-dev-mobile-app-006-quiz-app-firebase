import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:museumguide/services/auth_service.dart';
import 'package:museumguide/services/models.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    var reports = Provider.of<Report>(context);
    var user = AuthService().user;
    print(user.toString());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1AACBC),
        title: Text("Профиль"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                user?.photoURL ?? "https://placeholder.com/50/50",
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              user?.displayName ?? "Гость",
              style: TextStyle(fontSize: 20.0),
            ),
            Text(user?.email ?? "Адрес электронной почты не указан"),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () async {
                await AuthService().signOut();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/', (route) => false);
              },
              child: Text("Выход"),
            ),
          ],
        ),
      ),
    );
  }
}
