import 'package:bloc_login_page/component/app_style.dart';
import 'package:bloc_login_page/screen/login_page.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bloc_login_page/bloc/login/login_bloc.dart';
import 'package:bloc_login_page/component/app_style.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isPasswordVisible = false;
  String input_name = "";
  String input_email = "";
  String input_contact = "";
  String input_password = "";
  String input_confirm_password = "";

  @override
  Widget build(BuildContext context) {
    // return Container();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Sign-up",
                    style: AppStyle.titleStyle,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.grey[200],
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.photo_camera),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Name",
                              style: AppStyle.headingStyle1,
                            ),
                            TextField(
                              decoration: const InputDecoration(
                                hintText: "Your name",
                                hintStyle: AppStyle.hintStyle,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppStyle.grey600),
                                ),
                              ),
                              onChanged: (String value) => setState(() {
                                input_name = value;
                              }),
                              keyboardType: TextInputType.emailAddress,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Email",
                              style: AppStyle.headingStyle1,
                            ),
                            TextField(
                              decoration: InputDecoration(
                                hintText: "Your email id",
                                hintStyle: AppStyle.hintStyle,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppStyle.grey600),
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Contact no.",
                              style: AppStyle.headingStyle1,
                            ),
                            TextField(
                              decoration: const InputDecoration(
                                hintText: "Your contact number",
                                hintStyle: AppStyle.hintStyle,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppStyle.grey600),
                                ),
                              ),
                              onChanged: (String value) => setState(() {
                                input_contact = value;
                              }),
                              keyboardType: TextInputType.emailAddress,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Password",
                              style: AppStyle.headingStyle1,
                            ),
                            TextField(
                              decoration: InputDecoration(
                                hintText: "Password",
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppStyle.grey600),
                                ),
                                suffixIcon: IconButton(
                                  icon: isPasswordVisible
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility),
                                  onPressed: () => setState(
                                    () {
                                      isPasswordVisible = !isPasswordVisible;
                                    },
                                  ),
                                ),
                              ),
                              obscureText: isPasswordVisible,
                              onChanged: (String value) =>
                                  input_password = value,
                              textInputAction: TextInputAction.done,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Confirm Password",
                              style: AppStyle.headingStyle1,
                            ),
                            TextField(
                              decoration: InputDecoration(
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppStyle.grey600),
                                ),
                                hintText: "Confirm Password",
                                suffixIcon: IconButton(
                                  icon: isPasswordVisible
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility),
                                  onPressed: () => setState(
                                    () {
                                      isPasswordVisible = !isPasswordVisible;
                                    },
                                  ),
                                ),
                              ),
                              onChanged: (String value) =>
                                  input_confirm_password = value,
                              obscureText: isPasswordVisible,
                              textInputAction: TextInputAction.done,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            child: const Text(
                              "Register",
                              style: AppStyle.headingStyle1,
                            ),
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(vertical: 10)),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context, true);
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Have an account ? ",
                                style: AppStyle.hintStyle),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        const LoginPage(),
                                  ),
                                );
                              },
                              child: Text(
                                "Log-in",
                                style: AppStyle.hintStyle.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
