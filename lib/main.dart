import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './screens/personal_details_screen.dart';
import './screens/logScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Health App',
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, userSnapshot) {
          if (userSnapshot.hasData) {
            return PersonalDetailsScreen();
          }
          return LogScreen();
        },
      ),
      routes: {
        PersonalDetailsScreen.routeName: (ctx) => PersonalDetailsScreen(),
        LogScreen.routeName: (ctx) => LogScreen(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('hogaya');
        Navigator.of(context).pushReplacementNamed(LogScreen.routeName);
      },
      child: Scaffold(
        backgroundColor: Color.fromRGBO(129, 135, 248, 1),
        body: GestureDetector(
          onTap: () {
            print('Hogaya 2');
            Navigator.of(context).pushReplacementNamed(LogScreen.routeName);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 80,
              ),
              Container(
                height: 100,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.medical_services_outlined,
                      color: Colors.white,
                    ),
                    Text(
                      ' healthypet',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        shadows: [
                          Shadow(
                            color: Colors
                                .black38, // Choose the color of the shadow
                            blurRadius:
                                10.0, // Adjust the blur radius for the shadow effect
                            offset: Offset(0,
                                5.0), // Set the horizontal and vertical offset for the shadow
                          ),
                        ],
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 300,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 35.0,
                      color: Color.fromARGB(222, 255, 255, 255),
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Helping you to keep ',
                          style: TextStyle(color: Colors.white54)),
                      TextSpan(
                        text: 'your bestie',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: ' stay healthy!',
                        style: TextStyle(color: Colors.white54),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 80,
              ),
              Expanded(
                child: Container(
                  height: 200,
                  width: double.infinity,
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(14),
                        topRight: Radius.circular(14),
                        bottomLeft: Radius.circular(2),
                        bottomRight: Radius.circular(2),
                      ),
                      child: Image.network(
                        'https://www.patriciamcconnell.com/theotherendoftheleash/wp-content/uploads/2022/03/bigstock-A-Female-Veterinarian-Is-Holdi-445307414.jpg',
                        fit: BoxFit.cover,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
