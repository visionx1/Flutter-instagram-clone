import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:instagramClone/Login.dart';
import 'package:instagramClone/Services/ImageServices.dart';

import 'Feed.dart';

class Home extends StatefulWidget {
  static const routeName = "/homepage";
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ImageServices imageServices = ImageServices();
  var _pages = [
    Feed(),
    Feed(),
    Feed(),
    Feed(),
    Feed(),
  ];

  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFEEEEEE),
        brightness: Brightness.light,
        centerTitle: true,
        title: Text(
          "Instagram",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            imageServices.uploadImage(context);
          },
          icon: Icon(
            Feather.camera,
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut().whenComplete(() {
                Navigator.of(context).pushNamed(Login.routeName);
              });
            },
            icon: Icon(
              Feather.tv,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              FontAwesome.send_o,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: _pages[currentPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        onTap: (i) {
          setState(() {
            currentPage = i;
          });
        },
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Foundation.home),
            label: "Feed",
          ),
          BottomNavigationBarItem(
            icon: Icon(Feather.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              child: Icon(Feather.plus_square),
              onTap: () {
                imageServices.uploadImage(context);
              },
            ),
            label: "Upload",
          ),
          BottomNavigationBarItem(
            icon: Icon(Feather.heart),
            label: "Likes",
          ),
          BottomNavigationBarItem(
            icon: Icon(Feather.user),
            label: "Account",
          ),
        ],
      ),
    );
  }
}
