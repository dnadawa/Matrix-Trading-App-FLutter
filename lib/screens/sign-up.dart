import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:matrix_trading/widgets/label.dart';
import 'package:matrix_trading/widgets/text-box.dart';
import 'package:matrix_trading/widgets/toast.dart';

class SignUp extends StatelessWidget {

  TextEditingController uname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  CollectionReference collectionReference = Firestore.instance.collection('users');

  signUp() async {
    if(email.text!='' && password.text!='' && uname.text!=''){
      try{
        AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
            email: email.text, password: password.text);
        FirebaseUser user = result.user;
        print(user.uid);

        await collectionReference.document(user.uid).setData({
          'name': uname.text,
          'email': email.text,

        });

        uname.clear();
        email.clear();
        password.clear();

        ToastBar(color: Colors.green,text: 'Signed Up Successfully!').show();


      }
      catch(E){
        ToastBar(color: Colors.red,text: 'Something Went Wrong!').show();
        print(E);
      }
    }else{
      ToastBar(color: Colors.red,text: 'Please Fill all the Fields!').show();
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe5e5e5),
      appBar: AppBar(
        centerTitle: true,
        title: Lable(text: 'Sign Up',color: Colors.white,size: 20,),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(30,10,30,0),
              child: TextBox(hint: 'Username',controller: uname,),
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
              child: RaisedButton(onPressed: ()=>signUp(),
              color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35),
                ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Lable(text: 'Sign Up',color: Colors.white,size: 20,),
              ),

              ),
            )
          ],
        ),
      ),
    );
  }
}
