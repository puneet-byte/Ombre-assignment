import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Create a empty list to store event Data from the Backend
  List<Widget> items = [];

// Main UI OF the APP
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D111A),
      /* 
      Stream Builder Function used for creating
      the list of fetch Data from the Firebase
      */
      body: StreamBuilder<List<User>>(
        stream: readUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went Wrong !');
          } else if (snapshot.hasData) {
            final users = snapshot.data!;

            return Container(
              padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20),
              child: SafeArea(
                child: Column(
                  children: [
                    TextField(
                      cursorColor: Color(0xFF0D111A),
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 20),
                          filled: true,
                          fillColor: Color(0xFF263240),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100.0),
                            borderSide: BorderSide.none,
                          ),
                          hintText: "  eg: Sunburn",
                          suffixIcon: Icon(
                            Icons.search,
                            size: 30,
                            color: Colors.white,
                          ),
                          suffixIconColor: Colors.white),
                      onChanged: (value) {
                        items = [];
                        for (var i in users) {
                          if (i.event.toLowerCase().contains(value)) {
                            items.add(buildUser(i));
                          }
                        }
                        setState(() {});
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    // List Tile Function call 'buildUsers'
                    Container(
                      child: Expanded(
                        child: ListView(
                          children: items,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),

      /*
      Bottom Navigation Bar UI part
      flutter pakage use named as 'curved_navigation_bar: ^1.0.3'
      To DO : link the pages
       */
      bottomNavigationBar: CurvedNavigationBar(
        height: 50.0,
        items: <Widget>[
          Icon(Icons.list, color: Colors.white, size: 25),
          Icon(Icons.add, color: Colors.white, size: 25),
          Icon(Icons.event_seat, color: Colors.white, size: 25),
          Icon(Icons.search, color: Colors.white, size: 25),
        ],
        color: Color(0xFF263240),
        buttonBackgroundColor: Color(0xFFFB4F78),
        backgroundColor: Color(0xFF0D111A),
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 250),
      ),
    );
  }

/*
List Tiles Where all The information of fetched data Shown to User
 */
  Widget buildUser(User user) => ListTile(
        minVerticalPadding: 10.0,
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          // margin: EdgeInsets.only(right: 5.0, left: 5.0),
          child: Image.network(
            user.image,
            width: 80,
            // height: 60,
          ),
        ),
        title: Text(
          user.event,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
          // softWrap: false,
          // overflow: TextOverflow.fade,
        ),
      );

/* 
 Creating Instance For Firebase
 and store the Fetch data in readUsers Variable
*/
  Stream<List<User>> readUsers() => FirebaseFirestore.instance
      .collection('Events')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());
}

/* 
Model class for fetched Data from Firebase
*/
class User {
  String event;
  String image;

  User({
    required this.event,
    required this.image,
  });

  Map<String, dynamic> toJson() => {
        'event ': event,
        'image': image,
      };

  static User fromJson(Map<String, dynamic> json) => User(
        event: json['event'],
        image: json['image'],
      );
}
