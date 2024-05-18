import 'package:ck/notifiers/quiz_notifier.dart';
import 'package:ck/quiz_page/quiz_answer_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import 'model/word.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizNotifier>(builder: (_, notifier, __) {
      return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: () {
            if ((notifier.currQuestionIdx) >= notifier.lstSelectedWord.length) {
              return Column(
                children: [
                  Expanded(
                      flex: 1,
                      child: Text("Correct " +
                          notifier.lstCorrectAnswer.length.toString() +
                          " in " +
                          notifier.lstSelectedWord.length.toString())),
                  Text("Correct words"),
                  Expanded(
                      flex: 4,
                      child: ListView.builder(
                          itemCount: notifier.lstCorrectAnswer.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: ListTile(
                                title: Text(notifier
                                    .lstCorrectAnswer[index].firstLanguage),
                              ),
                            );
                          })),
                  Text("Incorrect words"),
                  Expanded(
                      flex: 4,
                      child: ListView.builder(
                          itemCount: notifier.lstWrongAnswer.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: ListTile(
                                title: Text(notifier
                                    .lstWrongAnswer[index].firstLanguage),
                              ),
                            );
                          }))
                ],
              );
            } else {
              return Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  notifier.switchLearningMode();
                                },
                                child: Text("Switch")),
                            Text(
                              "Question " +
                                  (notifier.currQuestionIdx + 1).toString() +
                                  " in " +
                                  notifier.lstSelectedWord.length.toString(),
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                        Text(
                          notifier.learningMode ? notifier.word.firstLanguage : notifier.word.secondLanguage,
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 56),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        child: GridView.count(
                          shrinkWrap: true,
                          childAspectRatio: (.75 / 1),
                          crossAxisCount: 2,
                          children: notifier.lstAnswer.map((answer) {
                            return QuizAnswerCard(answer: answer);
                          }).toList(),
                        ),
                      ),
                    ),
                  )
                ],
              );
            }
          }(),
        ),
      );
    });
  }
}
