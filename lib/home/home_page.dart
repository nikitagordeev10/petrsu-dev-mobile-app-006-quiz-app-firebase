import 'package:flutter/material.dart';
import 'package:museumguide/login/login_page.dart';
import 'package:museumguide/services/auth_service.dart';
import 'package:museumguide/topics/topics_page.dart';

// Класс для домашней страницы, который является StatefulWidget
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  // Создаем состояние для домашней страницы
  @override
  State<HomePage> createState() => _HomePageState();
}

// Состояние для домашней страницы
class _HomePageState extends State<HomePage> {
  // Создаем поток для пользователя
  var userStream = AuthService().userStream;

  @override
  void dispose() {
    // Очистка ресурсов при удалении состояния
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Возвращаем виджет, зависящий от потока пользователя
    return StreamBuilder(
      stream: userStream,
      builder: (context, snapshot) {
        // Если соединение ожидается, показываем индикатор загрузки
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        // Если есть данные, переходим на страницу тем
        if (snapshot.hasData) {
          return TopicsPage();
        }

        // Если произошла ошибка, выбрасываем исключение
        if (snapshot.hasError) {
          throw Exception();
        }

        // Возвращаем страницу входа, если нет данных пользователя
        return LoginPage();
      },
    );
  }
}
