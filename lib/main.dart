import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() async
{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FlashChat());
}
class FlashChat extends StatelessWidget{

  Widget build(BuildContext context)
  {
    return MaterialApp(
      // theme: ThemeData.dark().copyWith(
      //   textTheme: TextTheme(
      //     bodyText1:TextStyle(color:Colors.black54),
      //   ),
      // ),
      // home: WelcomeScreen(),
      initialRoute: WelcomeScreen.id,
      routes: {
        // 'welcome_screen': (context) =>WelcomeScreen(),
        WelcomeScreen.id:(context) => WelcomeScreen(),
        LoginScreen.id:(context) =>LoginScreen(),
        RegistrationScreen.id:(context) => RegistrationScreen(),
        ChatScreen.id:(context) =>ChatScreen(),
      },
    );
  }
}


// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//
//       ),
//
//     );
//   }
// }
