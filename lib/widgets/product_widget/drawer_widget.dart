// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:missan_app/miscellaneous/theme.dart';

Widget drawerWidget(BuildContext context, String userName) {
  return Drawer(
    child: SingleChildScrollView(
      child: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          SizedBox(height: 40),
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey,
            backgroundImage: AssetImage('assets/avatar.jpeg'),
          ),
          SizedBox(height: 10),
          Text(userName),
          SizedBox(height: 30),
          Divider(thickness: 2, color: Colors.grey),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Profile"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
            onTap: () {},
          ),
          Divider(thickness: 2, color: Colors.grey),
          SizedBox(height: 40),
          ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(appbar_font_color)),
              child: Text("Log Out"))
        ],
      ),
    ),
  );
}
