import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_todo/pages/addPlan.dart';
import 'package:project_todo/pages/home_page.dart';
import 'package:project_todo/widgets/task_widget.dart';

import 'data/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
