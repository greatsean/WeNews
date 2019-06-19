import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:shawn_app/widgets/article_list.dart';
import 'package:shawn_app/data/preferences.dart';

class TabHome extends StatefulWidget {
  final String title;

  const TabHome({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TabHomeState();
  }
}

class _TabHomeState extends State<TabHome> {
  var list = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ArticleList(
          list: this
              .list), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void loadData() async {
    CircularProgressIndicator d=CircularProgressIndicator(value: null,semanticsLabel: 'ddddd',);
    var keyword =
        await PreferencesUtil.getString(PreferencesConstants.NEWS_KEYWORD) ??
            "china";
    var pageSize =
        await PreferencesUtil.getInt(PreferencesConstants.NEWS_PAGESIZE) ??
            20.toString();
    var language =
        await PreferencesUtil.getString(PreferencesConstants.NEWS_LAN) ?? "";
//    https://newsapi.org/v2/everything?q=India&apiKey=53ea041b1e1c4c659b41767532da63f2
    var url = Uri.https('newsapi.org', '/v2/everything', {
      'q': keyword,
      'apiKey': '53ea041b1e1c4c659b41767532da63f2',
      'pageSize': pageSize.toString(),
      'language': language
    });
    print(url);
    var req = await HttpClient().getUrl(url);
    var resp = await req.close();
    var body = await resp.transform(utf8.decoder).join();
    var json = jsonDecode(body);
    this.setState(() {
      list = json['articles'];
    });
  }
}
