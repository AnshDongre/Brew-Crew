import 'package:flutter/material.dart';
import 'package:hello_world/Screens/database.dart';
import 'package:hello_world/Screens/loading.dart';
import 'package:hello_world/Screens/user.dart';
import 'package:provider/provider.dart';
class SettingsFrom extends StatefulWidget {
  @override
  _SettingsFromState createState() => _SettingsFromState();
}

class _SettingsFromState extends State<SettingsFrom> {
 final _formKey = GlobalKey<FormState>();
final List<String> sugars =['0','1','2','3','4'];
String _currentName;
String _currentSugars;
int _currentStrength;



  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return  StreamBuilder<UserData>(
        stream: Database(uid: user.uid).userData,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            UserData userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update your brew settings.',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: InputDecoration(
                        hintText: 'password',
                        fillColor: Colors.white,
                        filled:true,
                        enabledBorder: OutlineInputBorder(
                            borderSide:BorderSide(color: Colors.white,width: 2.0)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color:Colors.pink,width:2.0)
                        )
                    ),
                    validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(height: 10.0),
                  DropdownButtonFormField(
                    value: _currentSugars ?? userData.sugars,
                    decoration: InputDecoration(
                        hintText: 'password',
                        fillColor: Colors.white,
                        filled:true,
                        enabledBorder: OutlineInputBorder(
                            borderSide:BorderSide(color: Colors.white,width: 2.0)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color:Colors.pink,width:2.0)
                        )
                    ),
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugars'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentSugars = val ),
                  ),
                  SizedBox(height: 10.0),
                  Slider(
                    value: (_currentStrength ?? userData.strength).toDouble(),
                    activeColor: Colors.brown[_currentStrength ?? userData.strength],
                    inactiveColor: Colors.brown[_currentStrength ?? userData.strength],
                    min: 100.0,
                    max: 900.0,
                    divisions: 8,
                    onChanged: (val) => setState(() => _currentStrength = val.round()),
                  ),
                  RaisedButton(
                      color: Colors.pink[400],
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await Database(uid: user.uid).updateUserData(
                              _currentSugars ?? userData.sugars,
                              _currentName ?? userData.name,
                              _currentStrength ?? userData.strength);

                          Navigator.pop(context);
                        }
                      }
                      ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        }
    );
  }
}