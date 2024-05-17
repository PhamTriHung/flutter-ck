import 'dart:math';

import 'package:ck/model/answer.dart';
import 'package:flutter/material.dart';

import '../model/word.dart';

class QuizNotifier extends ChangeNotifier {
  bool isCorrect = false;
  QuizNotifier() {
    randomAnswer();
    lstSelectedWord.shuffle();
  }
  List<Word> lstSelectedWord = [ Word(topic: "topic 1", firstLanguage: "dog", secondLanguage: "cho"),
    Word(topic: "topic 1", firstLanguage: "cat", secondLanguage: "meo"),
    Word(topic: "topic 1", firstLanguage: "chicken", secondLanguage: "ga"),
    Word(topic: "topic 1", firstLanguage: "dug", secondLanguage: "vit"),
  ];
  int currQuestionIdx = 0;
  bool learningMode = false;
  late Word word = lstSelectedWord[0];
  late List<String> lstAnswer;
  List<Answer> lstCorrectAnswer = [];
  List<Answer> lstWrongAnswer = [];

  randomAnswer() {
    Random random = Random();
    lstAnswer = [];

    lstAnswer.add(learningMode ? lstSelectedWord[currQuestionIdx].secondLanguage : lstSelectedWord[currQuestionIdx].firstLanguage);

    while(lstAnswer.length < 4) {
      var idx = random.nextInt(lstSelectedWord.length);
      var value = lstSelectedWord[idx];
    if(!lstAnswer.contains(learningMode ? value.secondLanguage : value.firstLanguage)) {
        lstAnswer.add(learningMode ? value.secondLanguage : value.firstLanguage);
      }
    }

    lstAnswer.shuffle();
  }

  handleAnswer(answer) {
    var correctAnswer = learningMode ? word.secondLanguage : word.firstLanguage;
    if(correctAnswer == answer) {
      lstCorrectAnswer.add(Answer(correctAnswer: correctAnswer, userAnswer: answer));
      isCorrect = true;
    } else {
      lstWrongAnswer.add(Answer(correctAnswer: correctAnswer, userAnswer: answer));
      isCorrect = false;
    }
  }

  getNextQuestion() {
    currQuestionIdx += 1;
    if(currQuestionIdx < lstSelectedWord.length) {
      word = lstSelectedWord[currQuestionIdx];
    }
    notifyListeners();
  }

  switchLearningMode() {
    learningMode = !learningMode;
    currQuestionIdx = 0;
    word = lstSelectedWord[currQuestionIdx];
    lstCorrectAnswer = [];
    lstWrongAnswer = [];
    randomAnswer();
    notifyListeners();
  }

  shuffleQuestion() {
    currQuestionIdx = 0;
    lstSelectedWord.shuffle();
    word = lstSelectedWord[currQuestionIdx];
    randomAnswer();
    notifyListeners();
  }

}