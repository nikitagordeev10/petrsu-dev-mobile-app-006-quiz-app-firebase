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

// Асинхронная функция для сохранения данных документа в файл
const toFile = async (id) => {
    // Получаем ссылку на документ в коллекции 'topics' с идентификатором id
    const ref = db.collection('topics').doc(id);
    // Если нужно работать с квизами, используйте следующую строку вместо предыдущей:
    // const ref = db.collection('quizzes').doc(id);

    // Получаем данные документа
    const data = await ref.get().then(v => v.data());

    // Преобразуем данные в YAML строку с отступом в 8 пробелов
    const str = yaml.stringify(data, 8);

    // Записываем YAML строку в файл в директорию 'topics'
    await fs.outputFile(`topics/${id}.yaml`, str);
    // Если нужно сохранять в директорию 'quizzes', используйте следующую строку вместо предыдущей:
    // await fs.outputFile(`quizzes/${id}.yaml`, str);

    // Выводим сообщение об успешном завершении записи
    console.log('DONE');
}

// Массив с идентификаторами тем, которые нужно сохранить в файлы
const topics = [
//    'inventions_of_karelia',
    'karelian_cuisine',
    'landmarks_of_karelia',
    'traditional_crafts_of_karelia',
    'history_of_karelia',
    'nature_of_karelia',
    'culture_of_karelia',
    'festivals_of_karelia',
//    'tourism_in_karelia',
    'music_and_dance_of_karelia',
]

// Проходим по всем темам в массиве и вызываем функцию сохранения для каждой
for (const x of topics) {
    toFile(x);
}
