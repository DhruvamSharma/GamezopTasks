import 'package:flutter/material.dart';
import 'package:gamez_taskop/src/model/user.dart';
import 'package:gamez_taskop/src/resources/user_api_provider.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LoginScreen.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
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
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
      ),
      body: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot1) {
          if (snapshot1.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot1.hasData) {
            String userName = snapshot1.data.get('user_name' ?? 'Dhruvam');
            return FutureBuilder<User>(
              future: userApiProvider.getUser(userName),
              builder: (context, snapshot2) {
                if (snapshot2.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot2.hasData) {
                  userNameController.text = snapshot2.data.userName;
                  return Column(
                    children: <Widget>[
                      Center(
                        child: Stack(children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.indigo,
                            radius: 100,
                            backgroundImage: snapshot2.data.userImagePath.isEmpty
                                ? NetworkImage(
                                    'https://lh3.googleusercontent.com/MmO7RTHiY8R8oK6fs10WKpueb8QaGI1ztvAjHwPMNMNn1VceUZykULl056c5dvZY-VQ')
                                : FileImage(File.fromUri(
                                    Uri(path: snapshot2.data.userImagePath))),
                          ),
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: TextField(
                          enabled: false,
                          controller: userNameController,
                          decoration: InputDecoration(labelText: 'User Name'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: MaterialButton(
                            child: Text('Sign out', style: TextStyle(color: Colors.white),),
                            color: Colors.indigo,
                            onPressed: () async {
                              await snapshot1.data.remove('user_name');
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                return LoginScreen();
                              }));
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
