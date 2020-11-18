import 'package:flutter/material.dart';
import 'package:hello_world/Screens/Settings.dart';
import 'package:hello_world/Screens/auth.dart';
import 'package:hello_world/Screens/brew.dart';
import 'package:hello_world/Screens/database.dart';
import 'package:provider/provider.dart';
import 'package:hello_world/Screens/brew_list.dart';
class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    void _showSettingPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child:SettingsFrom(),
        );
      });
    }
    return StreamProvider<List<Brew>>.value(
        value: Database().brews,
        child:Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text('Brew Crew'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
          actions:<Widget>[
            FlatButton.icon(
              label: Text('logout'),
              icon: Icon(Icons.person),
                onPressed:() async{
                await _auth.signOut();
              }
              ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('settings'),
              onPressed: () => _showSettingPanel(),
            )
          ],
      ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/coffee_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          child: BrewList(),

          )
        ),
    );
  }
}
