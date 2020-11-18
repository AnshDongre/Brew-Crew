import 'package:flutter/material.dart';
import 'package:hello_world/Screens/authenticate.dart';
import 'package:hello_world/Screens/home.dart';
import 'package:hello_world/Screens/user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
   if(user==null)
     {
       return Authenticate();
     }
   else{
     return Home();
   }
  }
}
