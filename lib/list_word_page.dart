import 'package:ck/ScreenArgument.dart';
import 'package:ck/notifiers/word_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListWordPage extends StatefulWidget {
  const ListWordPage({super.key});

  @override
  State<ListWordPage> createState() => _ListWordPageState();
}

class _ListWordPageState extends State<ListWordPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<WordNotifier>(builder: (_, notifider, __) {
      final ScreenArgument screenArgument =
          ModalRoute.of(context)!.settings.arguments as ScreenArgument;
      notifider.init(screenArgument.topicId);
      notifider.topicId = screenArgument.topicId;
      return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Column(
              children: [
                SingleChildScrollView(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(notifider.lstWord[index].english),
                          subtitle: Text(notifider.lstWord[index].vietnamese),
                          trailing: IconButton(icon: Icon(Icons.delete), onPressed: () {
                            notifider.deleteWord(notifider.lstWord[index].wordId);
                            notifider.isInitFinish = false;
                            notifider.lstWord = [];
                          },),
                        ),
                      );
                    },
                    itemCount: notifider.lstWord.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
