import 'package:flutter/material.dart';

import 'dart:io';
import 'dart:convert';
import 'package:shawn_app/widgets/article_list.dart';
import 'package:shawn_app/data/preferences.dart';

class HeadlinesSiglePage extends StatefulWidget {
  final String category;

  const HeadlinesSiglePage({Key key, this.category}) : super(key: key);

  @override
  _HeadlinesSiglePageState createState() => _HeadlinesSiglePageState();
}

class _HeadlinesSiglePageState extends State<HeadlinesSiglePage> {
  @override
  Widget build(BuildContext context) {
    return ArticleList(
      list: this.list,
      refreshCb: loadData,
    );
  }

  var list = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    var pageSize =
        await PreferencesUtil.getInt(PreferencesConstants.NEWS_PAGESIZE) ??
            20.toString();
    var url = Uri.https('newsapi.org', '/v2/top-headlines', {
      'country': 'cn',
      'apiKey': '53ea041b1e1c4c659b41767532da63f2',
      'category': widget.category,
      'pageSize': pageSize.toString(),
    });
    print(url);
    var req = await HttpClient().getUrl(url);
    var resp = await req.close();
    var body = await resp.transform(utf8.decoder).join();
    var json = jsonDecode(body);
    this.setState(() {
      list = json['articles'];
//      print(list);
    });
  }
}
