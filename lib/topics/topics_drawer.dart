import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:museumguide/quiz/quiz_page.dart';
import 'package:museumguide/services/models.dart';

// Виджет TopicDrawer представляет собой боковую панель (drawer),
// которая отображает список тем с их соответствующими викторинами.
class TopicDrawer extends StatelessWidget {
  final List<Topic> topics;
  const TopicDrawer({super.key, required this.topics});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.separated(
          shrinkWrap: true,
          itemCount: topics.length,
          itemBuilder: (BuildContext context, int idx) {
            Topic topic = topics[idx];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                    topic.title,
                    // Заголовок темы
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70,
                    ),
                  ),
                ),
                QuizList(topic: topic) // Список викторин для данной темы
              ],
            );
          },
          separatorBuilder: (BuildContext context, int idx) => const Divider()), // Разделитель между темами
    );
  }
}

// Виджет QuizList представляет собой список карточек викторин для данной темы.
class QuizList extends StatelessWidget {
  final Topic topic;
  const QuizList({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: topic.quizzes.map(
            (quiz) {
          return Card(
            shape:
            const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            elevation: 4,
            margin: const EdgeInsets.all(4),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => QuizPage(
                      quizId: quiz.id, // Переход на страницу викторины при нажатии
                    ),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(
                    quiz.title, // Заголовок викторины
                  ),
                  subtitle: Text(
                    quiz.description, // Описание викторины
                    overflow: TextOverflow.fade,
                  ),
                  leading: QuizBadge(topic: topic, quizId: quiz.id), // Значок статуса викторины
                ),
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}

// Виджет QuizBadge отображает значок статуса викторины (выполнена или нет).
class QuizBadge extends StatelessWidget {
  final String quizId;
  final Topic topic;

  const QuizBadge({super.key, required this.quizId, required this.topic});

  @override
  Widget build(BuildContext context) {
    Report report = Provider.of<Report>(context);
    List completed = report.topics[topic.id] ?? [];
    if (completed.contains(quizId)) {
      return const Icon(FontAwesomeIcons.check, color: Colors.green); // Викторина выполнена
    } else {
      return const Icon(FontAwesomeIcons.solidCircle, color: Colors.grey); // Викторина не выполнена
    }
  }
}
