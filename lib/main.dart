import 'package:flutter/material.dart';
import 'package:github_api_demo/pages/following_page.dart';
import 'package:github_api_demo/pages/home_page.dart';
import 'package:github_api_demo/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}
