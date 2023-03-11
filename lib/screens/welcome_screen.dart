
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class  WelcomeScreen extends StatefulWidget{
   static String id='welcome_screen';
  _WelcomeScreenState createState() =>_WelcomeScreenState();
}
class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin
{
  late AnimationController controller;
  late Animation animation;

  void initState()
  {
    super.initState();
    controller=AnimationController(
        duration:Duration(seconds: 1),
        vsync: this,
        // upperBound: 100.0
    );
    // animation=CurvedAnimation(parent: controller, curve: Curves.decelerate);
    animation=ColorTween(begin: Colors.blueGrey,end:Colors.white).animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {

      });
      // print(animation.value);
    });
    void dispose()
    {
      controller.dispose();
      super.dispose();
    }
  }
  Widget build(BuildContext context)
  {
    return Scaffold(
      // backgroundColor: Color(0xFFBFE9FF),
      backgroundColor: animation.value,
      body:Padding(
        padding: EdgeInsets.symmetric(horizontal:24.0),
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:<Widget> [
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child:Image.asset('image/logo.png'),
                    height: 60.0,
                  ),
                ),
                TypewriterAnimatedTextKit(
                    text: ['Flash Chat'],
                    textStyle:  TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.black
                  ),
                )
              ],
            ),
            SizedBox(
              height:48.0,
            ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Material(
            elevation: 5.0,
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(30.0),
            child: MaterialButton(
              onPressed: ()
              {
                Navigator.pushNamed(context, LoginScreen.id);
              },
              minWidth: 200.0,
              height: 42.0,
              child: Text(
                'Log In',
                style:TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                elevation: 5.0,
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: ()
                  {
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Register',
                    style:TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      )
    );
  }
}

