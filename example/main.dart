import 'package:flutter/material.dart';

import 'horizontal_bar.dart';
import 'vertical_bar.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _bottomBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Step Progress Bar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: _bottomBarIndex == 0 ? HorizontalBar() : VerticalBar(),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _bottomBarIndex,
            onTap: (index) => setState(() => _bottomBarIndex = index),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.more_horiz),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.more_vert),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
