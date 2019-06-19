import 'package:flutter/material.dart';
import 'package:shawn_app/widgets/headlines_single_page.dart';

class TabHeadlines extends StatefulWidget {
  final String title;

  const TabHeadlines({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TabHeadlinesState();
  }
}

class _TabHeadlinesState extends State<TabHeadlines> {
  static const catgoryTitles = [
    "business",
    "entertainment",
    "general",
    "health",
    "science",
    "sports",
    "technology"
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: catgoryTitles.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            bottom: TabBar(
                isScrollable: true,
                tabs: catgoryTitles
                    .map<Widget>((e) => Tab(
                          text: e,
                        ))
                    .toList()),
          ),
          body: TabBarView(
              children: catgoryTitles
                  .map<Widget>((e) => HeadlinesSiglePage(
                        category: e,
                      ))
                  .toList()), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
