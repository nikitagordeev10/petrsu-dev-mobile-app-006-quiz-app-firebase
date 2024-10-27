import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService {
  // Поток, который уведомляет об изменениях состояния аутентификации.
  final userStream = FirebaseAuth.instance.authStateChanges();
  // Текущий аутентифицированный пользователь.
  final user = FirebaseAuth.instance.currentUser;

  // Генерация nonce (одноразового номера) заданной длины для защиты от атак повторного воспроизведения.
  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  // Вычисление SHA-256 хеша для строки.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input); // Кодирование строки в байты.
    final digest = sha256.convert(bytes); // Вычисление хеша.
    return digest.toString(); // Преобразование хеша в строку.
  }

  // Вход с помощью Apple ID.
  Future<UserCredential> signInWithApple() async {
    // Генерация одноразового номера для предотвращения атак повторного воспроизведения.
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    // Запрос учетных данных Apple ID с указанными полномочиями.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    // Создание учетных данных для Firebase на основе полученных от Apple.
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    // Вход в Firebase с использованием учетных данных Apple.
    return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  }

  // Анонимный вход в систему.
  Future<void> anonLogin() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      // Обработка ошибок входа.
    }
  }

  // Вход с помощью Google.
  Future<void> googleLogin() async {
    print("Пробую войти");

    try {
      // Запуск процесса аутентификации Google.
      final googleUser = await GoogleSignIn().signIn();

      // Если пользователь отменил вход, выходим из функции.
      if (googleUser == null) return;

      // Получение токенов аутентификации Google.
      final gogoleAuth = await googleUser.authentication;
      final authCredential = GoogleAuthProvider.credential(
        accessToken: gogoleAuth.accessToken,
        idToken: gogoleAuth.idToken,
      );

      // Вход в Firebase с использованием учетных данных Google.
      await FirebaseAuth.instance.signInWithCredential(authCredential);
    } on Exception catch (e) {
      // Обработка ошибок.
      print(e);
    }
  }

  // Выход из системы.
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
