// import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hero_animation_page_material_rout/Utils/Utils.dart';
import 'package:hero_animation_page_material_rout/sign_in_activity.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  FocusNode focusNodeFirstName = FocusNode();
  FocusNode focusNodeSecondName = FocusNode();
  FocusNode focusNodeEmail = FocusNode();
  FocusNode focusNodePassWord = FocusNode();
  final _auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance.collection('Authentication');

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void signup() {
    _auth
        .sendSignInLinkToEmail(
          email: emailController.text.toString(),
          actionCodeSettings: ActionCodeSettings(
            url: 'https://flutterauth.page.link/',
            handleCodeInApp: true,
            iOSBundleId: 'com.techease.dumy',
            androidPackageName: 'com.techease.dumy',
            androidMinimumVersion: "1",
          ),
        )
        .then((value) {})
        .onError((error, stackTrace) {
      Utils().toastMessage(Error().toString());
    });
    _auth
        .createUserWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString())
        .then((value) {
      firestore
          .doc(value.user?.uid)
          .set({
            'firstName': firstNameController.text.toString(),
            'lastName': lastNameController.text.toString(),
            'email': emailController.text.toString(),
            'password': passwordController.text.toString(),
            'id': value.user?.uid
          })
          .then((value) {})
          .onError((error, stackTrace) {
            Utils().toastMessage(error.toString());
          });
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
    });
  }

  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final clientHieght = height - kToolbarHeight;
    // final mini = min(height, width);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: const Color(0xff695c53),
          elevation: 0,
          leading: InkWell(
              onTap: (() {
                Navigator.pop(context);
              }),
              child: const Icon(Icons.arrow_back_ios)),
        ),
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: clientHieght * 0.08,
                      width: width * 0.7,
                      child: FittedBox(
                        child: AnimatedTextKit(
                          animatedTexts: [
                            TyperAnimatedText('Mehar Kitchan',
                                speed: const Duration(milliseconds: 500),
                                curve: Curves.bounceInOut,
                                textStyle: const TextStyle(
                                    fontSize: 40,
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
              //   padding: EdgeInsets.only(left: 52, top: 80),
              //   child:
              //    Text(
              //     'Mehar Kitchan',
              //     style: TextStyle(
              //         fontSize: 40,
              //         fontWeight: FontWeight.w900,
              //         color: Color(0xffab8b2b),
              //         fontFamily: 'fonts'),
              //   ),
              // ),
              Expanded(
                  flex: 7,
                  child: Form(
                    key: globalKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: width * 0.95,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: width * 0.47,
                                height: clientHieght * 0.1,
                                child: TextFormField(
                                  controller: firstNameController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'LastName Should not Empty';
                                    } else if (!(value.isValidName())) {
                                      return 'Name Format should be in alphabets only';
                                    } else if (value.length < 3) {
                                      return 'Name hould be atleast 3 alphabeta';
                                    }
                                    return null;
                                  },
                                  autofocus: true,
                                  focusNode: focusNodeFirstName,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'First Name',
                                    hintStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.47,
                                height: clientHieght * 0.1,
                                child: TextFormField(
                                  controller: lastNameController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'LastName Should not Empty';
                                    } else if (!(value.isValidName())) {
                                      return 'Name Format should be in alphabets only';
                                    } else if (value.length < 3) {
                                      return 'Name hould be atleast 3 alphabeta';
                                    }
                                    return null;
                                  },
                                  focusNode: focusNodeSecondName,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Last Name',
                                    hintStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: width * 0.95,
                          height: clientHieght * 0.1,
                          child: TextFormField(
                            controller: emailController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email Should Not Empty';
                              } else if (value.isValidFormetEmail()) {
                                return 'Email format not correct';
                              }
                              return null;
                            },
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
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.95,
                          height: clientHieght * 0.1,
                          child: TextFormField(
                            obscureText: passwordVisible,
                            controller: passwordController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password Should not empty';
                              } else if (!(value.isValidDigit())) {
                                return 'Password should be digits';
                              } else if (value.length < 6) {
                                return 'Password atLeast 6 digits';
                              } else {
                                return null;
                              }
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
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (globalKey.currentState!.validate()) {
                              signup();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignInPage()));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                      content: Text(
                                'Feild Not to be empty',
                                style: TextStyle(color: Colors.amber),
                              )));
                            }
                          },
                          child: Container(
                            width: width * 0.6,
                            height: clientHieght * 0.07,
                            decoration: const BoxDecoration(
                                color: Color(0xffcaa21e),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Center(
                              child: SizedBox(
                                  width: width * 0.3,
                                  height: clientHieght * 0.04,
                                  child: const FittedBox(
                                    child: Text(
                                      'SIGN UP',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                  )),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: clientHieght * 0.25,
                        )
                      ],
                    ),
                  )),
            ])));
  }
}

extension ValidDigit on String? {
  bool isValidDigit() {
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

  bool isValidFormetEmail() {
    String length = toString();
    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(length)) {
      return true;
    }
    return false;
  }

  bool isValidName() {
    var length = this?.length;
    if (length != 0) {
      for (var i = 0; i < length!; i++) {
        var code = (this?.codeUnits[i]) ?? 0;
        if (!(code >= 65 && code <= 90 || code >= 97 && code <= 122)) {
          return false;
        }
      }
      return true;
    }
    return false;
  }
}
