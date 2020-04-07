import 'package:flutter/material.dart';

class BottomBarWidget extends StatefulWidget {
  BottomBarWidget({Key key, @required this.onChanged}) : super(key: key);

  final ValueChanged<int> onChanged;

  @override
  _BottomBarWidgetState createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    widget.onChanged(index);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onTabTapped,
      currentIndex: _currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: new Icon(Icons.dashboard),
          title: new Text('Dashboard'),
        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.date_range),
          title: new Text('Data'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.show_chart),
          title: Text('Charts'),
        )
      ],
    );
  }
}
