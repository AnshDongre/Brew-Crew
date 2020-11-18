import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hello_world/Screens/auth.dart';
import 'package:hello_world/Screens/loading.dart';
class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading=false;

  String Error='';
  String email= '';
  String password= '';
  @override
  Widget build(BuildContext context) {
    return loading? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: Text('Sign in to brew crew'),
        actions: <Widget>[
          FlatButton.icon(onPressed: () {
          widget.toggleView();
          } , icon: Icon(Icons.person), label:Text('Register'))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
          child: Form(
            key:_formKey,
            child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Email',
                      fillColor: Colors.white,
                      filled:true,
                      enabledBorder: OutlineInputBorder(
                          borderSide:BorderSide(color: Colors.white,width: 2.0)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color:Colors.pink,width:2.0)
                      )
                  ),
                  validator: (val) =>val.isEmpty ?'Enter an email':null,
                onChanged: (val){
                      setState(()=>email = val);
                      print(email);
                }
              ),
          SizedBox(height: 20.0),
          TextFormField(
          obscureText: true,
              decoration: InputDecoration(
                  hintText: 'Password',
                  fillColor: Colors.white,
                  filled:true,
                  enabledBorder: OutlineInputBorder(
                      borderSide:BorderSide(color: Colors.white,width: 2.0)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color:Colors.pink,width:2.0)
                  )
              ),
              validator: (val) =>val.length<6 ?'Enter an password of atleast length 6':null,
            onChanged: (val){
              setState(()=>password = val);
              print(password);
            }
          ),
              RaisedButton(
                  color: Colors.pink[400],
                  child:Text(
                    'Sign-in',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      setState(()=>loading=true);
                          dynamic result = await _auth.signIn(email, password);
                      if(result == null)
                      {
                        setState(()=>Error='Provide correct credentials');
                        loading=false;
                      }
                    }
          }),
              SizedBox(height: 12.0),
              Text(
                Error,
                style: TextStyle(color:Colors.red,fontSize: 14.0),
              )
            ]
          ),
      ),
    )
    );
  }
}
