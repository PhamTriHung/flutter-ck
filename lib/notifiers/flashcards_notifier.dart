import 'dart:async';
import 'dart:math';

import 'package:ck/enum/slide_direction.dart';
import 'package:flutter/material.dart';

import '../model/word.dart';

class FlashcardNotifier extends ChangeNotifier {
  String topic = "";
  bool flipCard1 = false, flipCard2 = false, swipeCard2 = false, slideCard1 = false;
  bool resetFlipCard1 = false, resetFlipCard2 = false, resetSwipeCard2 = false, resetSlideCard1 = false;
  bool ignoreTouches = true;
  bool isAuto = false;
  bool learningMode = false;
  SlideDirection swipeDirection = SlideDirection.none;
  SlideDirection slideDirection = SlideDirection.none;
  Word word1 = Word(topic: "topic 1", firstLanguage: "", secondLanguage: "");
  Word word2 = Word(topic: "topic 1", firstLanguage: "", secondLanguage: "");
  late Timer autoTimer;

  List<Word> lstSelectedWord = [
    Word(topic: "topic 1", firstLanguage: "dog", secondLanguage: "cho"),
    Word(topic: "topic 1", firstLanguage: "cat", secondLanguage: "meo"),
    Word(topic: "topic 1", firstLanguage: "chicken", secondLanguage: "ga"),
    Word(topic: "topic 1", firstLanguage: "dug", secondLanguage: "vit"),
  ];
  int intTotalListLength = 0;
  int currWordIdx = 0;

  FlashcardNotifier() {
    intTotalListLength = lstSelectedWord.length;
    word1 = lstSelectedWord[0];
    word2 = lstSelectedWord[0];
  }


  runSlideCard1({required SlideDirection direction}) {
    slideCard1 = true;
    slideDirection = direction;
    resetSlideCard1 = false;
    notifyListeners();
  }

  runFlipcard() {
    flipCard1 = true;
    resetFlipCard1 = false;
    notifyListeners();
  }

  runFlipcard2() {
    flipCard2 = true;
    resetFlipCard2 = false;
    notifyListeners();
  }

  runSwipeCard2({required SlideDirection direction}) {
    swipeDirection = direction;
    swipeCard2 = true;
    resetSwipeCard2 = false;
    notifyListeners();
  }

  resetCard1() {
    resetSlideCard1 = true;
    resetFlipCard1 = true;
    slideCard1 = false;
    flipCard1 = false;
    swipeDirection = SlideDirection.none;
  }

  resetCard2() {
    resetSwipeCard2 = true;
    resetFlipCard2 = true;
    flipCard2 = false;
    swipeCard2 = false;
    swipeDirection = SlideDirection.none;
  }

  setIgnoreTouch({required bool ignore}) {
    ignoreTouches = ignore;
    notifyListeners();
  }

  getNextWord() {
    if(currWordIdx < intTotalListLength) {
      currWordIdx += 1;
      word1 = lstSelectedWord[currWordIdx];
    } else {
      print("end of list");
    }

    Future.delayed(Duration(milliseconds: 1000), () {
      word2 = word1;
    });
  }

  getPrevWord() {
    if(currWordIdx > 0) {
      currWordIdx -= 1;
      word1 = lstSelectedWord[currWordIdx];
    } else {
      print("end of list");
    }

    Future.delayed(Duration(milliseconds: 1000), () {
      word2 = word1;
    });
  }

  auto() {
    autoTimer = Timer.periodic(Duration(milliseconds: 4000), (timer) {
      Future.delayed(Duration(milliseconds: 1000), () {
        runFlipcard();
        Future.delayed(Duration(milliseconds: 1000), () {
          runFlipcard2();
          resetCard1();
          Future.delayed(Duration(milliseconds: 2000), () {
            runSwipeCard2(direction: SlideDirection.rightAway);
            runSlideCard1(direction: SlideDirection.rightIn);
            getNextWord();
            Future.delayed(Duration(milliseconds: 1000), () {
              resetCard2();
            });
          });
        });
      });
    });
  }

  runAuto({required bool isAuto}) {
    this.isAuto = isAuto;

    if(this.isAuto) {
      auto();
    } else {
      autoTimer.cancel();
    }
  }

  shuffleLst() {
    lstSelectedWord.shuffle();
    currWordIdx = 0;
    word1 = lstSelectedWord[currWordIdx];
    notifyListeners();
  }

  switchLearningMode() {
    learningMode = !learningMode;
    notifyListeners();
  }
}
