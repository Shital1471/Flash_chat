import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget{
  static const String id='chat_screen';
  _ChatScreenState createState() => _ChatScreenState();
}
class _ChatScreenState extends State<ChatScreen>
{
  final _firestore=FirebaseFirestore.instance;
  //clear the text message in the textfield.
  final messageTextController=TextEditingController();
  final _auth=FirebaseAuth.instance;
  late User loggedInUser;
  late String messageText;
  void initState()
  {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      // print("completed");
      setState(() {});
    });
    getCurrentUser();
  }

  void getCurrentUser() async
  {
    try
        {
          final user= await _auth.currentUser!;
          if(user!=null)
          {
            loggedInUser=user;
            // print(loggedInUser.email);
          }
        }
        catch(e)
    {
      print(e);
    }
  }
  void messageStream() async
  {
    await for(var snapshot in _firestore.collection('messages').snapshots())
      {
        for(var message in snapshot.docs)
          {
            print(message.data());
          }
      }
  }
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              onPressed: (){
                   _auth.signOut();
                   Navigator.pop(context);
                // messageStream();
              },
              icon:Icon(Icons.close),
          ),
        ],
        title: Text('⚡ Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder(
              stream: _firestore.collection('messages').snapshots(),
              //.doc(loggedInUser.uid).collection('messages').orderBy("data",descending: true)
              builder: (context, snapshot) {
                if(!snapshot.hasData)
                  {
                    return Center(
                      child:CircularProgressIndicator(),
                    );
                  }
                final messages=snapshot.data!.docs.reversed;

                List<MessageBubble>messageWidgets=[];
                for(var message in messages)
                  {
                    final messageText=message['text'];
                    final messageSender=message['sender'];
                    final currentUser=loggedInUser.email;
                    final messageBubble=MessageBubble(sender: messageSender,
                        text: messageText,
                        isMe: currentUser==messageSender,);
                    messageWidgets.add(messageBubble);
                  }
                return Expanded(child: ListView(
                  reverse: true,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
                  children: messageWidgets,
                ),
                );
                // return Expanded(
                //     child: ListView.builder(
                //       padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
                //       itemCount: snapshot.data?.docs.length,
                //       reverse: true,
                //       physics: BouncingScrollPhysics(),
                //
                //       itemBuilder: (context,index)
                //       {
                //         bool messageMe=snapshot.data.docs[index]['senderId']==loggedInUser.uid;
                //         final messageSender=snapshot.data?.docs[index]['sender'];
                //         final messageText=snapshot.data?.docs[index]['text'];
                //         return  MessageBubble(sender: messageSender,text:messageText,isMe:messageMe );
                //       },
                //       // children: messageWidgets,
                //     ),
                // );
              }

            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.lightBlueAccent,width: 2.0),
                )
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: TextField(
                        controller: messageTextController,
                    onChanged: (value){
                           messageText=value;
                    },
                        decoration: kMessageTextFieldDecoration,
                    )
                  ),
                  ElevatedButton(
                      onPressed: (){
                        messageTextController.clear();
                          _firestore.collection('messages').add({
                            'text':messageText,
                            'sender':loggedInUser.email,
                          });
                      },
                      child: Text(
                        'Send',
                        style: kSendButtonTextStyle,
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
class MessageBubble extends StatelessWidget {
    MessageBubble({
      required this.sender,
      required this.text,
      required this.isMe,
    });
  late final String text;
  late final String sender;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:isMe? CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: <Widget>[
          Text(
              sender,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
           Material(
             borderRadius: isMe ? BorderRadius.only(
               topLeft: Radius.circular(30.0),
               bottomRight: Radius.circular(30.0),
               bottomLeft: Radius.circular(30.0)
             ):
             BorderRadius.only(
               topRight: Radius.circular(30.0),
               bottomRight: Radius.circular(30.0),
               bottomLeft: Radius.circular(30.0)
               ),
          elevation: 5.0,
          color: isMe?Colors.lightBlueAccent:Colors.red,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
            child: Text(
              text,
              style: TextStyle(
                color: isMe?Colors.black54:Colors.black,
                fontSize: 20.0,
              ),
            ),
          ),
        ),],

      ),
    );
  }
}
