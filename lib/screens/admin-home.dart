import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:matrix_trading/screens/admin-message.dart';
import 'package:matrix_trading/widgets/label.dart';

class AdminHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Lable(text: 'Chat',color: Colors.white,size: 20,),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('users').snapshots(),
        builder: (context,snap){
          if(!snap.hasData){
            return Center(child: CircularProgressIndicator());
          }
          var x = snap.data.documents;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: x.length,
            itemBuilder: (context,i){
              return Column(
                children: <Widget>[
                  ListTile(
                    title: Lable(text: x[i].data['name'],size: 18,),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AdminMessage(name: x[i].data['name'],email: x[i].data['email'],)),
                      );
                    },
                  ),
                  Divider(thickness: 1,)
                ],
              );
            },
          );
        },
      ),
    );
  }
}
