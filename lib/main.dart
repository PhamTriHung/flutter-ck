import 'package:ck/Login.dart';
import 'package:ck/quiz_page.dart';
import 'package:ck/register.dart';
import 'package:ck/forgot.dart';
import 'package:ck/firebase_options.dart';
import 'package:ck/notifiers/quiz_notifier.dart';
import 'package:ck/notifiers/typing_test_notifier.dart';
import 'package:ck/typing_test_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'flashcards_page.dart';
import 'folder/app_home_screen.dart';
import 'list_word_page.dart';
import 'notifiers/flashcards_notifier.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

import 'notifiers/topic_notifier.dart';
import 'notifiers/word_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) {
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FlashcardNotifier()),
        ChangeNotifierProvider(create: (_) => QuizNotifier()),
        ChangeNotifierProvider(create: (_) => TypingTestNotifier()),
        ChangeNotifierProvider(create: (_) => TopicNotifier()),
        ChangeNotifierProvider(create: (_) => WordNotifier())
      ],
      child: const MyApp(),
    ));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/forgot': (context) => const ForgotScreen(),
        '/quiz': (context) => const QuizPage(),
        '/flashcard': (context) => const FlashcardPages(),
        '/typing_test': (context) => const TypingPage(),
        '/home': (context) => const HomeScreen(),
        '/list_word': (context) => const ListWordPage(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
