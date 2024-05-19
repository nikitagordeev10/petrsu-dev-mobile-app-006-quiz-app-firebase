import 'package:flutter/material.dart';
import 'package:quizapp/services/models.dart';

class QuizController with ChangeNotifier {
  double _progress = 0.0;
  Option? _selected;

  double get progress => _progress;
  Option? get selected => _selected;

  final PageController controller = PageController();

  set progress(double newValue) {
    _progress = newValue;
    notifyListeners();
  }

  set selected(Option? newValue) {
    _selected = newValue;
    notifyListeners();
  }

  void nextPage() async {
    await controller.nextPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }
}
