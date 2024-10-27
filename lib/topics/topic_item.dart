import 'package:flutter/material.dart';
import 'package:museumguide/services/models.dart';
import 'package:museumguide/shared/progress_bar.dart';
import 'package:museumguide/topics/topics_drawer.dart';

// Класс, представляющий элемент темы
class TopicItem extends StatelessWidget {
  // Поле для хранения информации о теме
  final Topic topic;
  const TopicItem({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return Hero(
      // Используем тег для анимации перехода
      tag: topic.img,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          // Обработка нажатия на элемент, эффект волны
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                // Переход на экран с подробной информацией о теме
                builder: (BuildContext context) => TopicScreen(topic: topic),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Изображение темы
              Flexible(
                flex: 3,
                child: SizedBox(
                  child: Image.asset(
                    'assets/covers/${topic.img}',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              // Заголовок темы
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    topic.title,
                    style: const TextStyle(
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.fade,
                    softWrap: false,
                  ),
                ),
              ),
              // Прогресс темы
              Flexible(child: TopicProgress(topic: topic)),
            ],
          ),
        ),
      ),
    );
  }
}

// Класс, представляющий экран с подробной информацией о теме
class TopicScreen extends StatelessWidget {
  // Поле для хранения информации о теме
  final Topic topic;

  const TopicScreen({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: ListView(children: [
        // Изображение с анимацией перехода
        Hero(
          tag: topic.img,
          child: Image.asset('assets/covers/${topic.img}',
              width: MediaQuery.of(context).size.width),
        ),
        // Заголовок темы
        Text(
          topic.title,
          textAlign: TextAlign.center,
          style: const TextStyle(
              height: 2, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        // Список викторин по теме
        QuizList(topic: topic)
      ]),
    );
  }
}
