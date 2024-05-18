import 'package:ck/animations/scale_animation.dart';
import 'package:ck/notifiers/typing_test_notifier.dart';
import 'package:ck/result_bottom_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TypingPage extends StatefulWidget {
  const TypingPage({super.key});

  @override
  State<TypingPage> createState() => _TypingPageState();
}

class _TypingPageState extends State<TypingPage> {
  TextEditingController answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<TypingTestNotifier>(builder: (_, notifier, __) {
      return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: () {
            if (notifier.currQuestionIdx >= notifier.lstSelectedWord.length) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                title: Row(
                                  children: [
                                    Text(notifier
                                        .lstCorrectAnswer[index].correctAnswer),
                                  ],
                                ),
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
                                title: Row(
                                  children: [
                                    Text("Correct answer: " + notifier
                                        .lstWrongAnswer[index].correctAnswer),
                                    Text("Your answer: " + notifier
                                        .lstWrongAnswer[index].userAnswer)
                                  ],
                                ),
                              ),
                            );
                          }))
                ],
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            notifier.switchLearningMode();
                          },
                          child: Text("Switch")),
                      Text("Question " +
                          (notifier.currQuestionIdx + 1).toString() +
                          "/" +
                          notifier.lstSelectedWord.length.toString()),
                      const Text(
                        "What is the meaning of this word?",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        notifier.learningMode
                            ? notifier.word.secondLanguage
                            : notifier.word.firstLanguage,
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 56,
                        ),
                      ),
                      TextFormField(
                        controller: answerController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter your answer here'),
                      ),
                    ],
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      onPressed: () {
                        notifier.answerQuestion(answer: answerController.text);
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return ResultBottomModal(
                                  onNextQuestionClick: () {
                                    notifier.getNextQuestion();
                                    Navigator.pop(context);
                                  },
                                  isCorrect: notifier.isCorrect);
                            });
                        answerController.text = '';
                      },
                      child: const Text("Submit")),
                ],
              );
            }
          }(),
        ),
      );
    });
  }
}
