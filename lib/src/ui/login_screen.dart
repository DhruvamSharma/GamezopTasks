import 'package:flutter/material.dart';
import 'package:gamez_taskop/src/model/user.dart';
import 'package:gamez_taskop/src/resources/user_api_provider.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';

// This widgets makes up the login screen that
// appears only when there is no user signed up.
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  File _profileImage;
  TextEditingController userNameController = TextEditingController();

  Future getImage(bool isCamera) async {
    File image;
    if (isCamera) {
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    } else {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    }

    setState(() {
      _profileImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Stack(children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.indigo,
                radius: 100,
                backgroundImage: _profileImage == null
                    ? NetworkImage(
                        'https://lh3.googleusercontent.com/MmO7RTHiY8R8oK6fs10WKpueb8QaGI1ztvAjHwPMNMNn1VceUZykULl056c5dvZY-VQ')
                    : FileImage(_profileImage),
              ),
              Positioned(
                bottom: 5,
                right: 20,
                child: GestureDetector(
                  onTap: () {
                    getImage(true);
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.camera_alt),
                  ),
                ),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: TextField(
              controller: userNameController,
              decoration: InputDecoration(labelText: 'User Name'),
            ),
          ),
          // This widget signs up the user and add the user name in the shared preferences.
          // This makes sure that every time user opens up app, user does not have to sign in again!
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                MaterialButton(
                    color: Colors.indigo,
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (userNameController.text.isEmpty) {
                        // TODO give humane feedback
                      } else {
                        await userApiProvider.createUser(User.fromUser(
                          userNameController.text,
                          _profileImage == null ? '' : _profileImage.path,
                          true,
                        ));

                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        preferences.setString(
                            'user_name', userNameController.text);

                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return HomeScreen();
                        }));
                      }
                    })
              ],
            ),
          ),

          Align(
            alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text('* Beware of the UI of this particular app'),
              )),
        ],
      ),
    );
  }
}
