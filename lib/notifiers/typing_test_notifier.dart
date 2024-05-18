import 'package:ck/model/answer.dart';
import 'package:flutter/cupertino.dart';

import '../model/word.dart';

class TypingTestNotifier extends ChangeNotifier {
  TypingTestNotifier() {
    lstSelectedWord.shuffle();
    word = lstSelectedWord[0];
  }
  late Word word;
  List<Answer> lstCorrectAnswer = [];
  List<Answer> lstWrongAnswer = [];
  bool scaleAnimate = false;
  bool resetScaleAnimate = false;
  bool isCorrect = false;
  bool learningMode = false;

  List<Word> lstSelectedWord = [ Word(topic: "topic 1", firstLanguage: "dog", secondLanguage: "cho"),
    Word(topic: "topic 1", firstLanguage: "cat", secondLanguage: "meo"),
    Word(topic: "topic 1", firstLanguage: "chicken", secondLanguage: "ga"),
    Word(topic: "topic 1", firstLanguage: "dug", secondLanguage: "vit"),
  ];

  int currQuestionIdx = 0;
  String message = '';


  getNextQuestion() {
    currQuestionIdx += 1;
    if(currQuestionIdx < lstSelectedWord.length) {
      word = lstSelectedWord[currQuestionIdx];
    }

    notifyListeners();
  }

  answerQuestion({required String answer}) {
    String correctAnswer = learningMode ? word.firstLanguage.toLowerCase() : word.secondLanguage.toLowerCase();

    if (correctAnswer == answer.toLowerCase()) {
      lstCorrectAnswer.add(Answer(correctAnswer: correctAnswer, userAnswer: answer));
      isCorrect = true;
    } else {
      lstWrongAnswer.add(new Answer(correctAnswer: correctAnswer, userAnswer: answer));
      isCorrect = false;
    }
    notifyListeners();
  }

  runScaleAnimation(message) {
    scaleAnimate = true;
    this.message = message;
    notifyListeners();
  }

  resetAnimation() {
    resetScaleAnimate = true;
    scaleAnimate = false;
    notifyListeners();
  }

  switchLearningMode() {
    learningMode = !learningMode;
    currQuestionIdx = 0;
    word = lstSelectedWord[currQuestionIdx];
    notifyListeners();
  }

}