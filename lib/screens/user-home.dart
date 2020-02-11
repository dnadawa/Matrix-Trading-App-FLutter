import 'package:flutter/material.dart';
import 'package:matrix_trading/screens/contact.dart';
import 'package:matrix_trading/screens/user-message.dart';
import 'package:matrix_trading/widgets/label.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserHome extends StatelessWidget {



var uname,email;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('images/logo.jpg'),
                    )),

              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('images/back.png'),fit: BoxFit.fitHeight)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Lable(color: Colors.white,text: 'WELCOME',size: 20,),
                    Lable(color: Colors.white,text: 'MATRIX TRADING GROUP',size: 35,align: TextAlign.center,),
                    Lable(color: Colors.white,text: 'WHERE WEALTH IS CREATED',size: 25,align: TextAlign.center,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          onPressed: () async {

                            SharedPreferences prefs = await SharedPreferences.getInstance();
                             uname = prefs.getString('username');
                             email = prefs.getString('email');

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => UserMessage(
                                email: email,
                                uname: uname,
                              )),
                            );
                          },
                          padding: EdgeInsets.all(15),
                          color: Theme.of(context).primaryColor,
                          child: Lable(text: 'Signals Room',color: Colors.white,),
                        ),
                        SizedBox(width: 30,),
                        RaisedButton(
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Contact()),
                            );
                          },
                          splashColor: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(0.0),
                              side: BorderSide(color: Colors.white,width: 3)
                          ),
                          padding: EdgeInsets.all(15),
                          color: Colors.transparent,
                          child: Lable(text: 'Contact Us',color: Colors.white,),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
