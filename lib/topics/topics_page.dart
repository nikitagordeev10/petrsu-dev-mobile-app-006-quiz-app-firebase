import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:museumguide/services/firestore.dart';
import 'package:museumguide/services/models.dart';
import 'package:museumguide/shared/bottom_navigation_bar.dart';
import 'package:museumguide/shared/error.dart';
import 'package:museumguide/shared/loading.dart';
import 'package:museumguide/topics/topic_item.dart';
import 'package:museumguide/topics/topics_drawer.dart';

// Страница со списком тем
class TopicsPage extends StatelessWidget {
  const TopicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Возвращаем будущий построитель с данными о темах
    return FutureBuilder<List<Topic>>(
      future: FirestoreService().getTopics(), // Получаем данные о темах из Firestore
      builder: (context, snapshot) {
        // Если данные загружаются, показываем экран загрузки
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        }
        // Если данные доступны
        else if (snapshot.hasData) {
          var topics = snapshot.data!; // Получаем список тем
          return Scaffold(
            appBar: AppBar(
              // backgroundColor: Color(0xFF1AACBC),
              title: Text(
                "Викторина",
                textAlign: TextAlign.center, // Выравнивание текста по центру внутри AppBar
              ),
              centerTitle: true, // Устанавливаем центрирование заголовка
            ),

            bottomNavigationBar: BottomNavBar(), // Добавляем нижнюю навигационную панель
            body: GridView.count(
              // Создаем сетку с темами
              primary: false,
              padding: const EdgeInsets.all(20.0),
              crossAxisSpacing: 10.0,
              crossAxisCount: 2,
              children: topics.map((topic) => TopicItem(topic: topic)).toList(), // Создаем список виджетов для каждой темы
            ),
          );
        }
        // Если произошла ошибка
        else if (snapshot.hasError) {
          return ErrorMessage(
            // Показываем сообщение об ошибке
            message: snapshot.error.toString(),
          );
        }
        // Если данные не были найдены
        return Text(
            "Данных не обнаружено. Пожалуйста, проверьте базу данных.");
      },
    );
  }
}
