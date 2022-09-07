import 'package:bloc_login_page/helper/app_preferences.dart';
import 'package:bloc_login_page/screen/login_page.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = '';
  String email = '';
  String profilePic =
      'https://pbs.twimg.com/profile_images/378800000394279731/bcbf68fb74c3df6a0c4e3d65b7fb19ad_400x400.jpeg';
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 1500), () async {
      AppPreference.getFacebookProfile().then((value) {
        print(value);
        if (value.isEmpty) {
          setState(() {
            name = "Null";
            email = "Null";
            profilePic =
                "https://pbs.twimg.com/profile_images/378800000394279731/bcbf68fb74c3df6a0c4e3d65b7fb19ad_400x400.jpeg";
          });
        } else {
          setState(() {
            name = value['name'] as String;
            email = value['email'] as String;
            profilePic = value['profilePic'] as String;
          });
        }
      });
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.network(
                profilePic,
                width: 100.0,
              ),
              SizedBox(
                height: 10,
              ),
              Text(name),
              Text(email),
              ElevatedButton(
                  onPressed: () {
                    AppPreference.logoutClearPreferences();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => const LoginPage(),
                        ));
                  },
                  child: Text("Logout")),
            ],
          ),
        ),
      ),
    );
  }
}
