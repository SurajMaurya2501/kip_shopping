import 'package:flutter/material.dart';
import 'package:kip_shooping/view/first.dart';
import 'package:kip_shooping/view/home.dart';
import 'package:kip_shooping/view/login.dart';
import 'package:kip_shooping/view/screen5.dart';
import 'package:kip_shooping/view/sign_up.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // return const FirstPage();
    // return const SignUpScreen();
    // return const LoginScreen();
    return const CourseScreen();
  }
}
