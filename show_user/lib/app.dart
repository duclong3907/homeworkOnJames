import 'package:flutter/material.dart';
import 'package:show_user/view/user_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('User'),
        ),
        body: Center(
          child: UserList(),
        )
      ),
    );
  }
}

