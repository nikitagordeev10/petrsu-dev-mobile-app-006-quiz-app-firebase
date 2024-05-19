import 'package:flutter/material.dart';

// Создаем класс ErrorMessage, который наследуется от StatelessWidget
class ErrorMessage extends StatelessWidget {
  // Объявляем поле message, в котором будет храниться текст сообщения об ошибке
  final String message;

  // Создаем конструктор класса ErrorMessage, принимающий необязательный параметр message
  const ErrorMessage({super.key, this.message = 'it broke'});

  // Переопределяем метод build, который будет возвращать виджет с текстом сообщения
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message), // Выводим текст сообщения по центру экрана
    );
  }
}
