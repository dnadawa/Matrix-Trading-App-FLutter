import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:matrix_trading/widgets/label.dart';

class UserMessage extends StatelessWidget {
  final String uname;
  final String email;

  const UserMessage({Key key, this.uname, this.email}) : super(key: key);
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Lable(color: Colors.white,text: uname,size: 20,),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          StreamBuilder(
            stream: Firestore.instance.collection('messages').document(email).collection('messages').orderBy('date',descending: true).snapshots(),
            builder: (context,snapshot){
              var x;

              if (!snapshot.hasData || snapshot.data == null) {
                return Center(
                  child: Center(child: CircularProgressIndicator(),),
                );
              }else{
                x = snapshot.data.documents;
              }

              return Expanded(
                child: snapshot!=null?ListView.builder(
                  shrinkWrap: true,
                  reverse: true,

                  itemCount:x.length,
                  itemBuilder: (context,i){

                    var img = x[i].data['image'];

                    return Container(
                      alignment:  Alignment.centerLeft,
                      margin: EdgeInsets.all(5),
                      child: Container(
                        constraints: BoxConstraints(maxWidth:MediaQuery.of(context).size.width*3/4 ),
                        padding: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(color: Theme.of(context).primaryColor,borderRadius: BorderRadius.circular(25.0),),
                        child: Column(
                          children: <Widget>[
                            Lable(text:x[i].data['message']!=null?x[i].data['message']:'',color: Colors.white,),
                            img!=null?Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(img),
                            ):Container(width: 0,height: 0,),
                          ],
                        )
                      ),
                    );

                  },

                ):Container(),
              );




            },
          ),

        ],
      ),
    );
  }
}
