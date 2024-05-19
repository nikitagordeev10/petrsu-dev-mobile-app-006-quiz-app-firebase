import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:museumguide/services/models.dart';

class AnimatedProgressbar extends StatelessWidget {
  final double value; // Значение прогресса, от 0 до 1
  final double height; // Высота полосы прогресса

  // Конструктор класса
  const AnimatedProgressbar({Key? key, required this.value, this.height = 12});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints box) {
        return Container(
          padding: const EdgeInsets.all(10),
          width: box.maxWidth,
          child: Stack(
            children: [
              // Фоновая полоса прогресса
              Container(
                height: height,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(height),
                  ),
                ),
              ),
              // Анимированная полоса прогресса
              AnimatedContainer(
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutCubic,
                height: height,
                width: box.maxWidth * _floor(value),
                decoration: BoxDecoration(
                  color: _colorGen(value),
                  borderRadius: BorderRadius.all(
                    Radius.circular(height),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Функция для округления значения до минимального значения, если оно отрицательное или NaN
  _floor(double value, [min = 0.0]) {
    return value.sign <= min ? min : value;
  }

  // Генерация цвета в зависимости от значения прогресса
  _colorGen(double value) {
    int rbg = (value * 255).toInt();
    return Colors.deepOrange.withGreen(rbg).withRed(255 - rbg);
  }
}

class TopicProgress extends StatelessWidget {
  const TopicProgress({Key? key, required this.topic});

  final Topic topic;

  @override
  Widget build(BuildContext context) {
    Report report = Provider.of<Report>(context);
    return Row(
      children: [
        // Отображение количества завершенных тестов из общего числа тестов
        _progressCount(report, topic),
        Expanded(
          child: AnimatedProgressbar(
              value: _calculateProgress(topic, report), height: 8),
        ),
      ],
    );
  }

  // Виджет для отображения количества завершенных тестов
  Widget _progressCount(Report report, Topic topic) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Text(
        '${report.topics[topic.id]?.length ?? 0} / ${topic.quizzes.length}',
        style: const TextStyle(fontSize: 10, color: Colors.grey),
      ),
    );
  }

  // Расчет прогресса для темы
  double _calculateProgress(Topic topic, Report report) {
    try {
      int totalQuizzes = topic.quizzes.length;
      int completedQuizzes = report.topics[topic.id].length;
      return completedQuizzes / totalQuizzes;
    } catch (err) {
      return 0.0; // В случае ошибки возвращается нулевое значение прогресса
    }
  }
}
