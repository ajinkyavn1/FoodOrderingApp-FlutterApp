
import 'dart:async';
import 'dart:async';
import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fooddelivery/Model/UserData.dart';

class AuthMethods{
  //code is Used to initialized Database
  final FirebaseAuth _auth=FirebaseAuth.instance;
  static final FirebaseDatabase _database=FirebaseDatabase.instance;
  static final DatabaseReference _userRefrence=_database.reference().child("Users");
  //code use for get currunt user
  Future<User> getCurruntUser()async{
    User user;
    user=await _auth.currentUser;
    return user;
  }
  //signin user
Future<User> SignIn(String email, String password )async{
    final User user=(await _auth.signInWithEmailAndPassword(email: email, password: password)) as User;
      assert(user!=null);
      assert(await user.getIdToken()!=null);
      User curruntuser=await _auth.currentUser;
      assert(user.uid==curruntuser.uid);
      print("Sign in Successfully done $user");
      return user;
}
Future<User> SignUp(String email,String password,String mobile)async{
    final User user=await _auth.createUserWithEmailAndPassword(email: email, password: password) as User;
    assert(user!=null);
    assert(await user.getIdToken()!=null);
    await addDataDb(user,email,password,mobile);
    return user;
    
    return user;
}
Future<Void> addDataDb(User user,String email,String password,String mobile){
    Users users=Users(user.uid,user.email, mobile,password);
    _userRefrence.child(user.uid).set(users.toMap(users));
}
}