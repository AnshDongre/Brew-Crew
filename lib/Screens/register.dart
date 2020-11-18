import 'package:flutter/material.dart';
import 'package:hello_world/Screens/auth.dart';
import 'package:hello_world/Screens/loading.dart';
class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String email= '';
  String password= '';
  String Error='';
  @override
  Widget build(BuildContext context) {
  return loading ? Loading () :Scaffold(
    backgroundColor: Colors.brown[100],
      appBar: AppBar(
      backgroundColor: Colors.brown[400],
      title: Text('Sign up to brew crew'),
        actions: <Widget>[
          FlatButton.icon(onPressed: () {
            widget.toggleView();
          } , icon: Icon(Icons.person), label:Text('sign in'))
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
      validator: (val) =>val.length<6 ?'Enter an password of atleast length 6':null,
  onChanged: (val){
  setState(()=>password = val);
  print(password);
  }
  ),
  RaisedButton(
  color: Colors.pink[400],
  child:Text(
  'Register',
  style: TextStyle(color: Colors.white),
  ),
  onPressed: () async {
    if(_formKey.currentState.validate()){
      {setState(()=>loading=true);
   dynamic result = await _auth.register(email, password);
   if(result == null)
      loading=false;
       setState(()=>Error='Provide correct credentials');
     }
    }
  }),
    SizedBox(height: 12.0),
    Text(
      Error,
      style: TextStyle(color:Colors.red,fontSize: 14.0),
    )
  ],
  ),
  ),
  ),
  );
  }

  }
