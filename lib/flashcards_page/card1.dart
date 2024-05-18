import 'dart:math';

import 'package:ck/animations/half_flip_animation.dart';
import 'package:ck/animations/slide_animation.dart';
import 'package:ck/enum/slide_direction.dart';
import 'package:ck/notifiers/flashcards_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Card1 extends StatelessWidget {
  const Card1({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Consumer<FlashcardNotifier>(builder: (_, notifier, __) {
      return GestureDetector(
        onDoubleTap: () {
          notifier.runFlipcard();
          notifier.setIgnoreTouch(ignore: true);
        },
        child: HalfFlipAnimation(
          animate: notifier.flipCard1,
          animationCompleted: () {
            notifier.resetCard1();
            notifier.runFlipcard2();
          },
          reset: notifier.resetFlipCard1,
          flipFromHalfWay: false,
          child: SlideAnimation(
            animationCompleted: () {
              notifier.setIgnoreTouch(ignore: false);
            },
            reset: notifier.resetSlideCard1,
            direction: notifier.slideDirection,
            animate: notifier.slideCard1,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  border: Border.all(width: 5, color: Colors.blue),
                ),
                height: size.height * 0.6,
                width: size.width * 0.8,
                child: Center(
                  child: Text(
                    notifier.learningMode
                        ? notifier.word1.firstLanguage
                        : notifier.word1.secondLanguage,
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
