const admin = require('firebase-admin');
const fs = require('fs-extra');
const yaml = require('yamljs');

admin.initializeApp({
    credential: admin.credential.cert(require('./credentials.json')),
});
const db = admin.firestore();

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


const update = async(id) => {

    const json = yaml.load(`topics/${id}.yaml`);

    console.log(JSON.stringify(json));

    const ref = db.collection('topics').doc(id);

    await ref.set(json, { merge: true });

    console.log('DONE');

}

for (const topic of topics) {
    update(topic);
}



