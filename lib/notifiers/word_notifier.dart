import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/WordModel.dart';

class WordNotifier extends ChangeNotifier {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  bool isInitFinish = false;
  String topicId = '';
  List<WordModel> lstWord = [];

  WordNotifier () {
    isInitFinish = false;
    lstWord = [];
  }

  init(topicId) async {
    topicId = topicId;
    CollectionReference collection =
        _db.collection('Topics').doc(topicId).collection('Words');

    QuerySnapshot snapshot = await collection.get();

    if (!isInitFinish) {
      snapshot.docs.forEach((doc) {
        lstWord.add(WordModel(
          wordId: doc.id,
            description: doc['description'],
            english: doc['english'],
            illustration: doc['illustration'],
            pronunciation: doc['pronunciation'],
            vietnamese: doc['vietnamese']));
      });
    }
    isInitFinish = true;
    notifyListeners();
  }

  deleteWord(wordId) async {
    DocumentReference documentReference = _db.collection('Topics').doc(topicId).collection('Words').doc(wordId);
    documentReference.delete();
    init(topicId);
  }
}
