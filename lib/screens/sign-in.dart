import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrix_trading/screens/admin-home.dart';
import 'package:matrix_trading/screens/sign-up.dart';
import 'package:matrix_trading/screens/user-home.dart';
import 'package:matrix_trading/widgets/label.dart';
import 'package:matrix_trading/widgets/text-box.dart';
import 'package:matrix_trading/widgets/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {



  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {


  String selectedRadio;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  CollectionReference collectionReference = Firestore.instance.collection('users');
  setSelectedRadio(String val) {
    setState(() {
      selectedRadio = val;
      //print(selectedRadio);
    });
  }

   signInUser() async {
    try{
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      FirebaseUser user = result.user;
      print(user.uid);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', user.email);
      
      
      var sub = await Firestore.instance.collection('users').where('email',isEqualTo: email.text).getDocuments();
      var logged = sub.documents;
      
      
      prefs.setString('email', user.email);
      prefs.setString('username', logged[0].data['name']);
      
      
      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context){
        return UserHome();}));
    }
    catch(E){
      ToastBar(color: Colors.red,text: 'Something went Wrong').show();
    }
  }


  signInAdmin() async {
    var sub = await Firestore.instance.collection('admin').where('email', isEqualTo: email.text).getDocuments();
    var user = sub.documents;
    if(user.isNotEmpty){
      if(user[0].data['password']==password.text){

print('admin logged in');



        Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context){
          return AdminHome();}));
      }
      else{
        ToastBar(text: 'Email or password is incorrect!',color: Colors.red).show();
      }
    }
    else{
      ToastBar(text: 'Admin Doesn\' exists!',color: Colors.red).show();
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedRadio = 'user';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe5e5e5),
      appBar: AppBar(
        centerTitle: true,
        title: Lable(text: 'Sign In',color: Colors.white,size: 20,),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Radio(value: 'user', groupValue: selectedRadio, onChanged: (value){
                  setSelectedRadio(value);
                  email.clear();
                  password.clear();
                }),
                Text('User',style: TextStyle(fontWeight: FontWeight.w900),),
                SizedBox(width: 50,),
                Radio(value: 'admin', groupValue: selectedRadio, onChanged: (value){
                  setSelectedRadio(value);
                  email.clear();
                  password.clear();
                }),
                Text('Admin',style: TextStyle(fontWeight: FontWeight.w900),)
              ],
            ),


            Padding(
              padding: const EdgeInsets.fromLTRB(30,10,30,0),
              child: TextBox(hint: 'Email',controller: email,type: TextInputType.emailAddress,),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(30,10,30,0),
              child: TextBox(hint: 'Password',controller: password,isPassword: true,),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: RaisedButton(onPressed: ()=>selectedRadio=='user'?signInUser():signInAdmin(),
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Lable(text: 'Sign In',color: Colors.white,size: 20,),
                ),

              ),
            ),

            GestureDetector(
                onTap: (){
                  Navigator.push(context, CupertinoPageRoute(builder: (context){
                    return SignUp();}));
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Lable(text: 'Create an Account',size: 20,),
                ))

          ],
        ),
      ),
    );
  }
}
