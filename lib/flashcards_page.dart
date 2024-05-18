import 'dart:async';

import 'package:ck/animations/half_flip_animation.dart';
import 'package:ck/enum/slide_direction.dart';
import 'package:ck/flashcards_page/card1.dart';
import 'package:ck/flashcards_page/card2.dart';
import 'package:ck/notifiers/flashcards_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlashcardPages extends StatefulWidget {
  const FlashcardPages({super.key});

  @override
  State<FlashcardPages> createState() => _FlashcardPagesState();
}

class _FlashcardPagesState extends State<FlashcardPages> {
  @override
  void initState() {
    // TODO: implement initState
    late final FlashcardNotifier flashcardsNotifier;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      flashcardsNotifier =
          Provider.of<FlashcardNotifier>(context, listen: false);
      flashcardsNotifier.runSlideCard1(direction: SlideDirection.rightIn);
      if(flashcardsNotifier.isAuto) {
        flashcardsNotifier.auto();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Consumer<FlashcardNotifier>(builder: (_, notifier, __) {
      return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.all(18),
          child: Center(
            child: IgnorePointer(
              ignoring: notifier.ignoreTouches,
              child: () {
                if(notifier.currWordIdx >= notifier.lstSelectedWord.length) {
                  return Text("No more word", style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 56
                  ),);
                }
                return Column(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(

                        ),
                        height: 100,
                        child: Text("viewing word: " + (notifier.currWordIdx + 1).toString() + "/" + notifier.lstSelectedWord.length.toString()),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      flex: 8,
                      child: Stack(
                        children: [Card1(size: size), Card2(size: size)],
                      ),
                    ),

                    Row(
                      children: [
                        Expanded(
                            child: ElevatedButton(child: Text("test"), onPressed: () {
                              notifier.runAuto(isAuto: !notifier.isAuto);
                            },)
                        ),
                        Expanded(
                            child: ElevatedButton(child: Text("Shuffle"), onPressed: () {
                              notifier.shuffleLst();
                            },)
                        ),
                        Expanded(
                            child: ElevatedButton(child: Text("Switch"), onPressed: () {
                              notifier.switchLearningMode();
                            },)
                        ),

                      ],
                    )
                  ],
                );
              } (),
            ),
          ),
        ),
      );
    });
  }
}
