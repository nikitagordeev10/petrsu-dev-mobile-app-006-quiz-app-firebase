import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/services/auth_service.dart';
import 'package:quizapp/services/models.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    var reports = Provider.of<Report>(context);
    var user = AuthService().user;
    print(user.toString());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("P R O F I L E"),
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
              user?.displayName ?? "Guest",
              style: TextStyle(fontSize: 20.0),
            ),
            Text(user?.email ?? "none provided"),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () async {
                await AuthService().signOut();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/', (route) => false);
              },
              child: Text("Signout"),
            ),
          ],
        ),
      ),
    );
  }
}
