import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hero_animation_page_material_rout/Utils/Utils.dart';
import 'package:hero_animation_page_material_rout/home_page.dart';
import 'package:hero_animation_page_material_rout/sign_up_activity.dart';

extension validDigit on String? {
  bool isValidDigitSignIn() {
    var length = this?.length;
    if (length != 0) {
      for (var i = 0; i < length!; i++) {
        var code = (this?.codeUnits[i]) ?? 0;
        if (!(code >= 48 && code <= 57)) {
          return false;
        }
      }
      return true;
    }
    return false;
  }

  bool issValidFormetEmailSignIn() {
    String length = this.toString();
    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(length)) {
      return true;
    }
    return false;
  }
}

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  FocusNode focusNodeEmail = FocusNode();
  FocusNode focusNodePassWord = FocusNode();

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  void signin() {
    _auth
        .signInWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString())
        .then((value) {
      Utils().toastMessage(value.user!.email.toString());
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const MyHomePage()));
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
    });
  }

  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final clientHieght = size.height;
    // final clientHieght = height - kToolbarHeight;
    final mini = min(clientHieght, width);
    // var orientation = MediaQuery.of(context).orientation;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            width: width,
            height: clientHieght,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomRight,
                    colors: [Color(0xff695c53), Color(0xff2e231f)])),
            child: Column(children: [
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    SizedBox(
                      height: clientHieght * 0.2,
                    ),
                    SizedBox(
                      height: clientHieght * 0.08,
                      width: width * 0.7,
                      child: FittedBox(
                        child: AnimatedTextKit(
                          animatedTexts: [
                            WavyAnimatedText('Mehar Kitchan',
                                speed: const Duration(milliseconds: 200),
                                textStyle: const TextStyle(

                                    // fontSize: mini * 0.13,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xffab8b2b),
                                    fontFamily: 'fonts'))
                          ],
                          // isRepeatingAnimation: true,
                          repeatForever: true,
                          displayFullTextOnTap: true,
                          totalRepeatCount: 3,
                          pause: const Duration(milliseconds: 100),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // const Padding(
              //   padding: EdgeInsets.only(left: 52, top: 140),
              //   child:
              //   // Text(
              //   //   'Mehar Kitchan',
              //   //   style: TextStyle(
              //   //       fontSize: 40,
              //   //       fontWeight: FontWeight.w900,
              //   //       color: Color(0xffab8b2b),
              //   //       fontFamily: 'fonts'),
              //   // ),
              // ),
              Expanded(
                  flex: 7,
                  child: Form(
                    key: globalKey,
                    child: Column(children: [
                      SizedBox(
                        height: clientHieght * 0.07,
                      ),
                      SizedBox(
                        width: width * 0.95,
                        height: clientHieght * 0.1,
                        child: TextFormField(
                          controller: emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email Should Not Empty';
                            } else if (value.issValidFormetEmailSignIn()) {
                              return 'Email format not correct';
                            }
                            return null;
                            // if (value!.isEmpty) {
                            //   return 'Email Should Not Empty';
                            // } else if (!RegExp(
                            //         "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                            //     .hasMatch(value)) {
                            //   return 'Email format not correct';
                            // }
                            // return null;
                          },
                          autofocus: true,
                          focusNode: focusNodeEmail,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.white,
                            ),
                            border: OutlineInputBorder(),
                            hintText: 'Email',
                            hintStyle: TextStyle(
                                color: Colors.white,

                                // fontSize: mini * 0.05,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: clientHieght * 0.02,
                      ),
                      SizedBox(
                        width: width * 0.95,
                        height: clientHieght * 0.1,
                        child: TextFormField(
                          obscureText: passwordVisible,
                          controller: passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password should not empty';
                            } else if (!(value.isValidDigitSignIn())) {
                              return 'password shoul digits';
                            } else if (value.length < 6) {
                              return 'password should be atleast 6 digits';
                            }
                            return null;
                          },
                          focusNode: focusNodePassWord,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.white,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  passwordVisible = !passwordVisible;
                                });
                              },
                            ),
                            border: const OutlineInputBorder(),
                            hintText: 'Password',
                            hintStyle: const TextStyle(
                                color: Colors.white,

                                // fontSize: mini * 0.05,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: clientHieght * 0.04,
                      ),
                      Container(
                        width: width * 0.5,
                        height: clientHieght * 0.07,
                        decoration: const BoxDecoration(
                            color: Color(0xffcaa21e),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Center(
                          child: InkWell(
                            onTap: (() {
                              if (globalKey.currentState!.validate()) {
                                signin();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('field should not empty')));
                              }

                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             const SignUpPage()));
                            }),
                            child: SizedBox(
                              width: width * 0.2,
                              height: clientHieght * 0.05,
                              child: const FittedBox(
                                child: Text(
                                  'SIGN IN',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: clientHieght * 0.03,
                      ),
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: width * 0.2,
                              height: clientHieght * 0.003,
                              color: Colors.grey,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.03),
                              child: SizedBox(
                                width: width * 0.05,
                                height: clientHieght * 0.03,
                                child: const FittedBox(
                                  child: Text(
                                    'Or',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: width * 0.2,
                              height: clientHieght * 0.003,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: clientHieght * 0.01,
                      ),
                      InkWell(
                        onTap: () async {
                          await signInWithGoogle(context);
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Successfully login')));
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MyHomePage(),
                              ));
                        },
                        child: CircleAvatar(
                          radius: mini * 0.03,
                          backgroundColor: const Color(0xffab8b2b),
                          child: Center(
                            child: SizedBox(
                              width: width * 0.05,
                              height: clientHieght * 0.07,
                              child: const FittedBox(
                                child: Text(
                                  'G',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: clientHieght * 0.1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            // color: Colors.pink,
                            width: width * 0.4,
                            height: clientHieght * 0.04,
                            child: FittedBox(
                              child: Text(
                                'Donot have an acount?',
                                style: TextStyle(
                                    // fontSize: mini * 0.045,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white.withOpacity(0.5)),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (() {
                              Navigator.of(context).push(createCustomeRoute());

                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             const SignUpPage()));
                            }),
                            child: SizedBox(
                              // color: Colors.green,
                              width: width * 0.2,
                              height: clientHieght * 0.05,
                              child: const FittedBox(
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      // fontSize: mini * 0.05,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]),
                  )),
            ])));
  }
}

Route createCustomeRoute() {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 1000),
    reverseTransitionDuration: const Duration(milliseconds: 1000),
    pageBuilder: (context, animation, secondaryAnimation) => const SignUpPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var tween = Tween(begin: const Offset(-1, -1), end: Offset.zero)
          .chain(CurveTween(curve: Curves.ease));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Future<UserCredential> signInWithGoogle(BuildContext context) async {
  // Trigger the authentication flow
  var credential;
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
  } catch (e) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(e.toString())));
  }
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
