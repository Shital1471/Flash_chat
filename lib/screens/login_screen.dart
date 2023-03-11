import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget
{
  static const String id='login_screen';
  _LoginScreenState createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen>
{
  final _auth=FirebaseAuth.instance;
  bool showSpinner=false;
  late String email;
  late String password;

  Widget build(BuildContext context)
  {
    return Scaffold(
         backgroundColor: Colors.white,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      height: 200.0,
                      child: Image.asset('image/logo.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height:48.0,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value){
                        email=value;
                  },
                    decoration:kTextFieldDecoration.copyWith(
                      hintText: 'Enter your email....'
                    ),
                ),

                SizedBox(
                  height: 8.0,
                ),
                TextField(
                    textAlign: TextAlign.center,
                    obscureText: true,
                  onChanged: (value)
                  {
                     password=value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password...'
                  )
                ),
                SizedBox(
                  height: 24.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    elevation: 5.0,
                    child: MaterialButton(
                      onPressed: () async
                      {
                        setState(() {
                          showSpinner=true;
                        });
                           try
                               {
                                 final user=await _auth.signInWithEmailAndPassword(email: email, password: password);
                                 if(user!=null)
                                   {
                                     Navigator.pushNamed(context, ChatScreen.id);
                                   }
                                 setState(() {
                                   showSpinner=false;
                                 });
                               }

                               catch(e)
                                 {
                                   print(e);
                                 }
                       },
                      minWidth: 200.0,
                      height: 42.0,
                      child: Text(
                        'Log In',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
    );
  }
}