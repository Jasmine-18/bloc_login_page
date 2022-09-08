import 'package:bloc_login_page/bloc/login/login_bloc.dart';
import 'package:bloc_login_page/component/app_style.dart';
import 'package:bloc_login_page/screen/forget_password.dart';
import 'package:bloc_login_page/screen/register_page.dart';
import 'package:bloc_login_page/screen/home_page.dart';
import 'package:bloc_login_page/widgets/progress_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isPasswordVisible = false;
  String input_username = "";
  String input_password = "";
  String response_value = "";
  bool login = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        print(state.status);
        if (state.status == 'success') {
          ProgressLoader.cancelLoader(context);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => HomePage()),
            ModalRoute.withName('/homepage'),
          );
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (BuildContext context) => const HomePage(),
          //   ),
          // );
        } else if (state.status == 'pending') {
          ProgressLoader.showLoadingDialog(context);
        } else if (state.status == 'failed') {
          ProgressLoader.cancelLoader(context);
          _showErrorDialog("Invalid username or password");
        }
      },
      builder: (context, state) {
        return Scaffold(
            body: login
                ? Container(
                    child: const Text("Login"),
                  )
                : SingleChildScrollView(
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
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Log-in",
                                style: AppStyle.titleStyle,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                child: Column(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Username",
                                          style: AppStyle.headingStyle1,
                                        ),
                                        BlocBuilder<LoginBloc, LoginState>(
                                          builder: (context, state) {
                                            return TextField(
                                              decoration: const InputDecoration(
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: AppStyle.grey600),
                                                ),
                                                hintText: "Your username",
                                              ),
                                              onChanged: (value) => context
                                                  .read<LoginBloc>()
                                                  .add(LoginUsernameChanged(
                                                      value)),
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Password",
                                          style: AppStyle.headingStyle1,
                                        ),
                                        TextField(
                                          decoration: InputDecoration(
                                              enabledBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: AppStyle.grey600),
                                              ),
                                              hintText: "Password",
                                              suffixIcon: IconButton(
                                                icon: isPasswordVisible
                                                    ? const Icon(
                                                        Icons.visibility_off)
                                                    : const Icon(
                                                        Icons.visibility),
                                                onPressed: () => setState(
                                                  () {
                                                    isPasswordVisible =
                                                        !isPasswordVisible;
                                                  },
                                                ),
                                              )),
                                          onChanged: (value) => context
                                              .read<LoginBloc>()
                                              .add(LoginPasswordChanged(value)),
                                          obscureText: isPasswordVisible,
                                          textInputAction: TextInputAction.done,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute<void>(
                                                  builder: (BuildContext
                                                          context) =>
                                                      const ForgetPasswordPage(),
                                                ));
                                          },
                                          child: Text(
                                            "Forget password?",
                                            style: TextStyle(
                                                color: Colors.grey.shade600),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    // Container(
                                    //   width: MediaQuery.of(context).size.width,
                                    //   height: 60,
                                    //   decoration: BoxDecoration(
                                    //       color: Colors.black,
                                    //       borderRadius: BorderRadius.circular(30)),
                                    // child: GestureDetector(
                                    //     child: Row(
                                    //       mainAxisAlignment: MainAxisAlignment.center,
                                    //       children: [
                                    //         Text("Login",
                                    //             style: TextStyle(
                                    //                 fontSize: 28,
                                    //                 color: Colors.white,
                                    //                 fontWeight: FontWeight.bold)),
                                    //       ],
                                    //     ),
                                    //     onTap: () {}),
                                    // ),
                                    Container(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        child: const Text(
                                          "Login",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        style: ButtonStyle(
                                          padding: MaterialStateProperty.all(
                                              const EdgeInsets.symmetric(
                                                  vertical: 10)),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.black),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          // Changes for api calling
                                          context
                                              .read<LoginBloc>()
                                              .add(const LoginSubmitted());
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //     builder: (context) => HomePage(),
                                          //   ),
                                          // );
                                        },
                                      ),
                                    ),

                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Dont have an account ? ",
                                            style: TextStyle(
                                              color: Colors.grey.shade600,
                                            )),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        const RegisterPage(),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            "Sign-up",
                                            style: TextStyle(
                                                color: Colors.grey.shade600,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    // or login with divider
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            padding:
                                                const EdgeInsets.only(right: 5),
                                            child: const Divider(
                                                color: AppStyle.grey600),
                                          ),
                                        ),
                                        const Text("Or login with",
                                            style: TextStyle(
                                              color: AppStyle.grey600,
                                            )),
                                        Expanded(
                                          child: Container(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: const Divider(
                                                color: AppStyle.grey600),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // Gmail button
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.shade300,
                                                  offset: const Offset(0, 5),
                                                  blurRadius: 5,
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          child: IconButton(
                                            tooltip: "Login with GMail",
                                            hoverColor: Colors.red,
                                            onPressed: () {
                                              context.read<LoginBloc>().add(
                                                  const GoogleLoginSubmitted());
                                            },
                                            icon: Image.asset(
                                                "assets/images/gmail.png"),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 30,
                                        ),
                                        // Facebook button
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.shade300,
                                                  offset: const Offset(0, 5),
                                                  blurRadius: 5,
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          child: IconButton(
                                            onPressed: () {
                                              context.read<LoginBloc>().add(
                                                  const FacebookLoginSubmitted());
                                            },
                                            icon: Image.asset(
                                                "assets/images/facebook.png"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ));
      },
    ));
  }

  Future<void> _showErrorDialog(String errorMsg) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Login Unsuccesful'),
          content: SingleChildScrollView(child: Text(errorMsg)),
          actions: <Widget>[
            TextButton(
              child: const Text("Done"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
