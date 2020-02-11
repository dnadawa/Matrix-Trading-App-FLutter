import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matrix_trading/widgets/label.dart';
import 'package:matrix_trading/widgets/toast.dart';
import 'package:path/path.dart';


class AdminMessage extends StatefulWidget {

  final String email;
  final String name;

  const AdminMessage({Key key, this.email, this.name}) : super(key: key);

  @override
  _AdminMessageState createState() => _AdminMessageState();
}

class _AdminMessageState extends State<AdminMessage> {
  bool uploadComplete;
  TextEditingController editingController = TextEditingController();
  File image;
  String imgurl;




  send() async {
    final CollectionReference collectionReference = Firestore.instance.collection("messages").document(widget.email).collection('messages');
    Map data =<String, dynamic> {
      'message': editingController.text,
      'date': DateTime.now(),
      'image': imgurl

    };
    print(editingController.text);
    if(editingController.text!=''){
      await collectionReference.add(data);
      setState(() {});
    }else{
      ToastBar(color: Colors.green,text: 'Please type the messsage').show();
    }
    editingController.clear();
  }



  Future setImage() async {
    setState(() {
      uploadComplete = false;
    });
    image = await ImagePicker.pickImage(source: ImageSource.gallery);
    try{
      StorageReference ref = FirebaseStorage.instance.ref().child("/messages/${widget.email}/${basename(image.path)}");
      StorageUploadTask uploadTask = ref.putFile(image);
      final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
      imgurl = (await downloadUrl.ref.getDownloadURL());
      print(imgurl);
      setState(() {
        uploadComplete = true;
      });

    }
    catch(e){
      print(e);
    }


  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      uploadComplete=true;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Lable(color: Colors.white,text: widget.name,size: 20,),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          StreamBuilder(
            stream: Firestore.instance.collection('messages').document(widget.email).collection('messages').orderBy('date',descending: true).snapshots(),
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
                      key: UniqueKey(),
                      alignment:  Alignment.centerRight,
                      margin: EdgeInsets.all(5),
                      child: Container(
                          constraints: BoxConstraints(maxWidth:MediaQuery.of(context).size.width*3/4 ),
                          padding: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(color: Theme.of(context).primaryColor,borderRadius: BorderRadius.circular(25.0),),
                          child: Column(
                            children: <Widget>[
                              Lable(text: x[i].data['message'],color: Colors.white,),
                              img!=null?Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(img,key: UniqueKey(),),
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


          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 8.0),
                  decoration: BoxDecoration(color: Theme.of(context).primaryColor.withOpacity(0.06),borderRadius: BorderRadius.circular(32.0),),
                  margin: EdgeInsets.all(12.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(child: TextField(

                        decoration: InputDecoration(
                          border:InputBorder.none,
                          hintText: "Message...",
                          suffixIcon: IconButton(icon: Icon(Icons.attach_file),onPressed: ()=>setImage(),)
                        ),

                        textInputAction: TextInputAction.send,
                        controller: editingController,
                        onSubmitted: (x)=>uploadComplete?send():null,


                      )),
                      IconButton(icon: Icon(Icons.send), onPressed: ()=>uploadComplete?send():null,color: Theme.of(context).primaryColor),
                    ],
                  ),
                ),
              ),

            ],
          )

        ],
      ),
    );
  }
}
