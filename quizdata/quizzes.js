// Подключаем необходимые модули
const admin = require('firebase-admin');
const fs = require('fs-extra');
const yaml = require('yamljs');

// Инициализируем Firebase Admin SDK с учетными данными из файла credentials.json
admin.initializeApp({
    credential: admin.credential.cert(require('./credentials.json')),
});

// Создаем экземпляр Firestore
const db = admin.firestore();

// Массив с идентификаторами квизов, которые нужно обновить
const quizzes = [
//    'inventions_of_karelia_easy',
    'karelian_cuisine_easy',
    'landmarks_of_karelia_easy',
    'traditional_crafts_of_karelia_easy',
    'history_of_karelia_easy',
    'nature_of_karelia_easy',
    'culture_of_karelia_easy',
    'festivals_of_karelia_easy',
//    'tourism_in_karelia_easy',
    'music_and_dance_of_karelia_easy',
]

// Асинхронная функция для обновления квиза по его идентификатору
const update = async (quizId) => {
    // Загружаем данные квиза из YAML файла
    const json = yaml.load(`quizzes/${quizId}.yaml`);

    // Выводим загруженные данные в формате JSON в консоль
    console.log(JSON.stringify(json));

    // Получаем ссылку на документ в коллекции 'quizzes' с идентификатором quizId
    const ref = db.collection('quizzes').doc(quizId);

    // Обновляем документ данными из JSON, слияние с существующими данными
    await ref.set(json, { merge: true });

    // Выводим сообщение об успешном завершении обновления
    console.log('DONE');
}

// Проходим по всем квизам в массиве и вызываем функцию обновления для каждого
for (const quiz of quizzes) {
    update(quiz);
}
