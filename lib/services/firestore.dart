import 'package:cloud_firestore/cloud_firestore.dart';  // Импорт библиотеки Cloud Firestore для взаимодействия с базой данных Firestore.
import 'package:museumguide/services/auth_service.dart';  // Импорт собственного сервиса аутентификации.
import 'package:museumguide/services/models.dart';  // Импорт моделей данных.
import 'package:rxdart/rxdart.dart';  // Импорт библиотеки для работы с реактивными расширениями.

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;  // Создание экземпляра базы данных Firestore.

  // Метод для получения списка тем.
  Future<List<Topic>> getTopics() async {
    var ref = _db.collection('topics');  // Ссылка на коллекцию 'topics' в базе данных.
    var snapshot = await ref.get();  // Получение снимка данных из коллекции.
    var data = snapshot.docs.map((element) => element.data());  // Преобразование документов в данные.
    var topics = data.map((topic) => Topic.fromJson(topic));  // Преобразование данных в объекты Topic.
    return topics.toList();  // Возвращение списка объектов Topic.
  }

  // Метод для получения конкретного квиза по его идентификатору.
  Future<Quiz> getQuiz(String quizId) async {
    var ref = _db.collection('quizzes').doc(quizId);  // Ссылка на документ с идентификатором quizId в коллекции 'quizzes'.
    var snapshot = await ref.get();  // Получение снимка данных документа.
    return Quiz.fromJson(snapshot.data() ?? {});  // Преобразование данных в объект Quiz и возврат его.
  }

  // Метод для получения потока отчетов для текущего пользователя.
  Stream<Report> streamReport() {
    return AuthService().userStream.switchMap((user) {  // Переключение на новый поток при изменении пользователя.
      if (user != null) {
        var ref = _db.collection('reports').doc(user.uid);  // Ссылка на документ отчета текущего пользователя.
        return ref.snapshots().map((doc) => Report.fromJson(doc.data()!));  // Преобразование данных в объект Report и возврат потока.
      } else {
        return Stream.fromIterable([Report()]);  // Возврат пустого отчета, если пользователь не авторизован.
      }
    });
  }

  // Метод для обновления отчета пользователя после прохождения квиза.
  Future<void> updateUserReport(Quiz quiz) async {
    var user = AuthService().user!;  // Получение текущего пользователя.
    var ref = _db.collection('reports').doc(user.uid);  // Ссылка на документ отчета текущего пользователя.
    var data = {
      'total': FieldValue.increment(1),  // Инкремент общего количества прохождений квизов.
      'topics': {
        quiz.topic: FieldValue.arrayUnion([quiz.id])  // Добавление идентификатора квиза в список пройденных квизов по теме.
      }
    };
    ref.set(data, SetOptions(merge: true));  // Обновление данных документа с возможностью слияния.
  }
}
