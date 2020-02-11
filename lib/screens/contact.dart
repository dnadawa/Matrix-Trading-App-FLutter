import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:matrix_trading/widgets/label.dart';
import 'package:matrix_trading/widgets/text-box.dart';
import 'package:matrix_trading/widgets/toast.dart';


class Contact extends StatelessWidget {

TextEditingController name = TextEditingController();
TextEditingController email = TextEditingController();


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
                    image: DecorationImage(image: AssetImage('images/back2.png'),fit: BoxFit.fitHeight)
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 30,),
                      Lable(text: 'ABOUT US',size: 30,color: Colors.white,),
                      Divider(color: Colors.white,thickness: 5,indent: 100,endIndent: 100,),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Lable(text: 'Matrix Trading Group was started by a group of college friends who were thinking about their financial future. After many months of research they discovered forex, cryptocurrencies and indices. The group of friends started teaching other students on campus how to trade the forex markets. Within the next few months Matrix Trading Group was birthed and now reaches individuals all across the world.\n\n'
                          'Our company provides signals, training, and support to traders through various training programs and membership services. We believe through webinars, training and 1 on 1 assistance anyone can become a successful trader. Our goal is to educate millennials and assist them on their journey to becoming financially secure and debt-free!',color: Colors.white,align: TextAlign.justify,size: 15,),
                      ),
                      Lable(text: 'STAY IN TOUCH',size: 20,color: Colors.white,),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30,10,30,0),
                        child: TextBox(hint: 'Name',controller: name,),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30,10,30,0),
                        child: TextBox(hint: 'Email',controller: email,),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: RaisedButton(
                          onPressed: () async {
                            CollectionReference _collection = Firestore.instance.collection('contact');
                            try{
                              await _collection.add({
                                'email': email.text,
                                'name': name.text
                              });

                              email.clear();
                              name.clear();

                              ToastBar(color: Colors.green,text: 'Successful!').show();
                            }
                            catch(E){
                              ToastBar(color: Colors.red,text: 'Something went wrong').show();
                            }


                          },
                          padding: EdgeInsets.all(15),
                          color: Theme.of(context).primaryColor,
                          child: Lable(text: 'Submit',color: Colors.white,),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
