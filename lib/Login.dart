import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:instagramClone/Home.dart';

class Login extends StatefulWidget {
  static const routeName = "/login";
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _userController = TextEditingController();
  FocusNode _userFocus = new FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _userFocus = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _userFocus.dispose();
    _userController.dispose();
    super.dispose();
  }

  Future<void> _signInAnonymously() async {
    final isValid = _formKey.currentState.validate();
    if (isValid) {
      try {
        await FirebaseAuth.instance.signInAnonymously().whenComplete(() {
          final userId = FirebaseAuth.instance.currentUser.uid;
          FirebaseFirestore.instance.collection("Users").doc(userId).set({
            "userId": userId,
            "CreatedDate": DateTime.now(),
            "name": _userController.text,
            "profileImage":
                "https://scontent.fktm12-1.fna.fbcdn.net/v/t1.0-9/65054143_447907485995580_1591014207522865152_o.jpg?_nc_cat=104&ccb=2&_nc_sid=09cbfe&_nc_ohc=siTRagKc8ycAX879zwL&_nc_ht=scontent.fktm12-1.fna&oh=d251d6cb4891dc7d9494ee7307b1fa83&oe=5FBE98E1" // TODO Just For the dummy
          }).whenComplete(() {
            Navigator.of(context).pushNamed(Home.routeName);
          });
        });
      } catch (error) {
        Flushbar(
          message: "Something Went Wrong, Check Internet connection.",
          duration: Duration(seconds: 3),
        )..show(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: _signInAnonymously,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("UserName: "),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: _userController,
                          decoration: InputDecoration(
                            hintText: "e.g. Manish",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            fillColor: Color(0xfff3f3f4),
                            filled: true,
                          ),
                          cursorHeight: 20.0,
                          focusNode: _userFocus,
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Cannot be empty";
                            }
                            if (value.length < 3) {
                              return 'At least 3 characters long';
                            }
                            return null;
                          },
                          cursorColor: Colors.black,
                          obscureText: false,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25.0,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 10.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF9B2282),
                        Color(0xFFEEA863),
                      ],
                    ),
                  ),
                  child: Text(
                    "Get Started",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
