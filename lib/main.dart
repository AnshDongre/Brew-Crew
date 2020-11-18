import 'package:flutter/material.dart';
import 'package:hello_world/Screens/auth.dart';
import 'package:hello_world/Screens/user.dart';
import 'package:hello_world/Screens/wrapper.dart';
import 'package:provider/provider.dart';

void main()=> runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value:AuthService().user,
      child:MaterialApp(
      home: Wrapper(),
      ),
    );
  }
}









