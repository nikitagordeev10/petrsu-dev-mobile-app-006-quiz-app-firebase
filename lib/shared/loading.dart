import 'package:flutter/material.dart';

// Класс Loader - виджет для отображения индикатора загрузки
class Loader extends StatelessWidget {
  const Loader({super.key}); // Конструктор класса Loader

  @override
  Widget build(BuildContext context) {
    // Метод build для построения виджета Loader
    return const SizedBox(
      width: 250,
      height: 250,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      ), // Индикатор загрузки внутри контейнера
    );
  }
}

// Класс LoadingScreen - виджет для отображения экрана загрузки
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key}); // Конструктор класса LoadingScreen

  @override
  Widget build(BuildContext context) {
    // Метод build для построения виджета LoadingScreen
    return const Scaffold(
      body: Center(
        child: Loader(), // Отображение индикатора загрузки по центру экрана
      ),
    );
  }
}
