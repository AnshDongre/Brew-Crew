import 'package:firebase_auth/firebase_auth.dart';
import 'package:hello_world/Screens/database.dart';
import 'package:hello_world/Screens/user.dart';
class AuthService{

  //sign in with email and password


  final FirebaseAuth _auth=FirebaseAuth.instance;
  //create user object based on Firebase user
  User _userFromFireBaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid):null;
  }
  //auth change user stream
  Stream<User> get user{
    return _auth.onAuthStateChanged
        //.map((FirebaseUser)=>_userFromFireBaseUser(user))

        .map(_userFromFireBaseUser);
  }
  Future register(String email,String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      await Database(uid: user.uid).updateUserData('0', 'new crew member', 100);
      return _userFromFireBaseUser(user);
    }
    catch (e) {
      print(e.toString());
      return null;
    }
  }
  //Sign in ano
  Future signInAnon() async{
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFireBaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
// sign out
Future signOut() async {
  try {
    return await _auth.signOut();
  }
  catch (e) {
    print(e.toString());
    return null;
  }


}
  Future signIn(String email,String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFireBaseUser(user);
    }
    catch (e) {
      print(e.toString());
      return null;
    }
    //register with email id

  }
}

