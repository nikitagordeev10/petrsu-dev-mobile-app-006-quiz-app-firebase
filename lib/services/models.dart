import "package:json_annotation/json_annotation.dart";
part 'models.g.dart';

// Аннотация, указывающая, что этот класс может быть сериализован/десериализован в/из JSON.
@JsonSerializable()
class Topic {
  final String id;
  final String title;
  final String description;
  final String img;
  final List<Quiz> quizzes;

  Topic({
    this.id = '',
    this.title = '',
    this.description = '',
    this.img = 'default.png',
    this.quizzes = const [],
  });

  // Фабричный метод для создания экземпляра класса из JSON.
  factory Topic.fromJson(Map<String, dynamic> json) => _$TopicFromJson(json);

  // Метод для преобразования объекта класса в JSON.
  Map<String, dynamic> toJson() => _$TopicToJson(this);
}

@JsonSerializable()
class Quiz {
  String id;
  String title;
  String description;
  String video;
  String topic;
  List<Question> questions;

  Quiz({
    this.id = '',
    this.title = '',
    this.description = '',
    this.topic = '',
    this.video = '',
    this.questions = const [],
  });

  factory Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);
  Map<String, dynamic> toJson() => _$QuizToJson(this);

  // Переопределение метода toString для вывода объекта в виде строки JSON.
  @override
  String toString() {
    return toJson().toString();
  }
}

@JsonSerializable()
class Report {
  String uid;
  int total;
  Map topics;

  Report({this.uid = '', this.total = 0, this.topics = const {}});

  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);
  Map<String, dynamic> toJson() => _$ReportToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

@JsonSerializable()
class Question {
  String text;
  List<Option> options;
  Question({this.options = const [], this.text = ''});

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}

@JsonSerializable()
class Option {
  String value;
  String detail;
  bool correct;
  Option({this.value = '', this.detail = '', this.correct = false});

  factory Option.fromJson(Map<String, dynamic> json) => _$OptionFromJson(json);
  Map<String, dynamic> toJson() => _$OptionToJson(this);
}
