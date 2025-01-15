import 'package:flutter/material.dart';
import 'UseresDetails/AddUsers.dart';
import 'UseresDetails/screen.dart';



void main() {
  runApp(userdetailss());
}

class userdetailss extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UserDetails',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => MainScreen(),
        '/addUser': (context) => UserForm(user: ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?),
      },
    );
  }
}
