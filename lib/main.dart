import 'package:flutter/material.dart';
import 'package:shawn_app/screens/tab_home.dart';

import 'package:shawn_app/screens/tab_top_headlines.dart';
import 'package:shawn_app/screens/tab_settings.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: buildTitle(),
//      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(title: Text('首页'), icon: Icon(Icons.home)),
          BottomNavigationBarItem(title: Text('热点'), icon: Icon(Icons.ac_unit)),
          BottomNavigationBarItem(
              title: Text('设置'), icon: Icon(Icons.settings)),
        ],
        onTap: (i) {
          setState(() {
            _selectedIndex = i;
          });
        },
        currentIndex: _selectedIndex,
      ),

      body:
          buildList(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  static const List<Widget> _tabContents = <Widget>[
    TabHome(
      title: 'We来新闻',
    ),
    TabHeadlines(
      title: '热点头条',
    ),
    TabSettings(
      title: '设置',
    ),
  ];

  static const List<Widget> _titles = <Widget>[
    Text('未来新闻'),
    Text('热点头条'),
  ];

  buildList() {
    return _tabContents[_selectedIndex];
  }

  buildTitle() {
    return _titles[_selectedIndex];
  }
}
