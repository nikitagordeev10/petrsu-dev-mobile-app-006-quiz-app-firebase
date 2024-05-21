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
        // backgroundColor: Color(0xFF1AACBC),
        title: Text(
          "Профиль",
          textAlign: TextAlign.center, // Выравнивание текста по центру внутри AppBar
        ),
        centerTitle: true, // Устанавливаем центрирование заголовка
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(
                'assets/avatars/user.png',
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
                Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1AACBC), // Цвет фона кнопки
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Закругление углов радиусом 10
                ),
              ),
              child: Text(
                "Выход",
                style: TextStyle(color: Colors.white), // Цвет текста кнопки
              ),
            ),

          ],
        ),
      ),
    );
  }
}
