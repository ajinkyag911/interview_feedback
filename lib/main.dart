import 'package:flutter/material.dart';

import 'features/interviewers/presentation/pages/interviewer_list_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Register all dependencies
  await di.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Interview Feedback',
      theme:
          ThemeData(primaryColor: Colors.blue, accentColor: Colors.blueAccent),
      home: InterviewerListPage(),
    );
  }
}