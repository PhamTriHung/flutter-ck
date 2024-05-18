import 'package:ck/ScreenArgument.dart';
import 'package:ck/notifiers/topic_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopicsTabScreen extends StatefulWidget {
  const TopicsTabScreen({super.key});

  @override
  State<TopicsTabScreen> createState() => _TopicsTabScreenState();
}

class _TopicsTabScreenState extends State<TopicsTabScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TopicNotifier>(builder: (_, notifier, __) {
      return StreamBuilder<List<Map<String, dynamic>>>(
          stream: notifier.fetchCoursesStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final courselist = snapshot.data;
              return ListView.builder(
                itemCount: courselist!.length,
                itemBuilder: (context, index) {
                  final course = courselist[index];
                  return Card(
                    child: ListTile(
                      title: Text(course['courseName']),
                      trailing: PopupMenuButton<int>(
                        itemBuilder: (BuildContext context) {
                          return <PopupMenuEntry<int>>[
                            PopupMenuItem<int>(
                              child: Text("Flash card"),
                              value: 0,
                            ),
                            PopupMenuItem<int>(
                              child: Text("Quiz"),
                              value: 1,
                            ),
                            PopupMenuItem<int>(
                              child: Text("Typing test"),
                              value: 2,
                            ),
                            PopupMenuItem<int>(
                              child: Text("View words"),
                              value: 3,
                            ),
                            PopupMenuItem<int>(
                              child: Text("Add word"),
                              value: 4,
                            )
                          ];
                        },
                        onSelected: (value) {
                          switch (value) {
                            case 0:
                              Navigator.pushNamed(context, '/flashcard', arguments: ScreenArgument(course['courseId']));
                              break;
                            case 1:
                              Navigator.pushNamed(context, '/quiz', arguments: ScreenArgument(course['courseId']));
                              break;
                            case 2:
                              Navigator.pushNamed(context, '/typing_test', arguments: ScreenArgument(course['courseId']));
                              break;
                            case 3:
                              Navigator.pushNamed(context, '/list_word', arguments: ScreenArgument(course['courseId']));
                              break;
                            case 4:
                              Navigator.pushNamed(context, '/add_word', arguments: ScreenArgument(course['courseId']));
                              break;
                          }
                        },
                      ),
                    ),
                  );
                },
              );
            } else {
              return Placeholder();
            }
          });
    });
  }
}
