import 'package:flutter/material.dart';
import 'package:gamez_taskop/src/resources/user_api_provider.dart';
import 'package:gamez_taskop/src/ui/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gamez_taskop/src/ui/home_screen.dart';

// Start of the application
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.indigo,
        brightness: Brightness.light,
      ),
      // This widget checks if any user is present in the shared preferences.
      home: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(body: Center(child: Container()));
          } else if (snapshot.hasData) {
            String userName = snapshot.data.get('user_name') ?? '';
            if (userName.isNotEmpty) {
              return HomeScreen();
            } else {
              return LoginScreen();
            }
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
