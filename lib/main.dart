import 'dart:core';

import 'package:THS/components/bottom_bar.dart';
import 'package:THS/components/data_table.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Humidity Station',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Temperature Humidity Station'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _active = 0;
  final List<Widget> _children = [
    Text("Messages"),
    DataTableWidget(),
    Text("Profile")
  ];

  void _handleBottomBarChanged(int newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(child: _children[_active]),
      bottomNavigationBar: BottomBarWidget(
        onChanged: _handleBottomBarChanged,
      ),
    );
  }
}
