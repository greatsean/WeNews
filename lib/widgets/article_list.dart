import 'package:flutter/material.dart';

import 'package:WeNews/screens/browser.dart';

class ArticleList extends StatefulWidget {
  final List list;
  final Function refreshCb;
  final Function loadmoreCb;

  ArticleList({Key key, this.list, this.refreshCb, this.loadmoreCb})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ArticelListState();
}

class _ArticelListState extends State<ArticleList> {
  final ScrollController mContronller = new ScrollController();

  @override
  void initState() {
    mContronller.addListener(() {
      if (mContronller.position.maxScrollExtent ==
          mContronller.position.pixels) {
        print('已经滑到底部');
        if (widget.loadmoreCb != null) widget.loadmoreCb();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    mContronller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    List<Widget> datas = widget.list
//        .map<Widget>((e) => ArticItem(
//              title: e['title'],
//              url: e['url'],
//              imgUrl: e['urlToImage'],
//              desc: e['description'],
//              date: e['publishedAt'],
//            ))
//        .toList();

//    List<Widget> datas = [];
//    this.list.forEach((e) {
//      datas.add(ArticItem(
//        title: e['title'],
//        url: e['url'],
//        imgUrl: e['urlToImage'],
//        desc: e['description'],
//        date: e['publishedAt'],
//      ));
//    });

    var datas = widget.list;
    return RefreshIndicator(
      child: ListView.separated(
        itemCount: datas.length,
        itemBuilder: (BuildContext context, int index) => ArticItem(
              title: datas[index]['title'],
              url: datas[index]['url'],
              imgUrl: datas[index]['urlToImage'],
              desc: datas[index]['description'],
              date: datas[index]['publishedAt'],
            ),
        separatorBuilder: (BuildContext context, int index) => Divider(),
        controller: mContronller,
      ),
      onRefresh: () async {
        return Future.sync(() async {
          print('下拉刷新---开始');
          await widget.refreshCb();
          print('下拉刷新---结束');
        });
      },
    );
  }
}

class ArticItem extends StatelessWidget {
  String title;
  String url;
  String imgUrl;
  String desc;
  String date;

  ArticItem({this.title, this.url, this.imgUrl, this.desc, this.date});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          margin: EdgeInsets.only(left: 15, right: 15, top: 10),
          child: Row(
            children: <Widget>[
              imgUrl != null
                  ? Image.network(imgUrl, width: 100, height: 100)
                  : SizedBox(
                      width: 100,
                      height: 100,
                      child: Container(
                        color: Colors.black12,
                      ),
                    ),
              Expanded(
                child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          this.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          softWrap: true,
                        ),
//              this.desc ?? Text(this.desc),
                        Text(this.date),
                      ],
                    )),
              )
            ],
          )),
      onTap: () {
        handItemClick(context);
      },
    );
  }

  handItemClick(BuildContext context) {
    print('点击了。。。${this.url}');
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Browser(
                title: this.title,
                url: this.url,
              ),
        ));
  }
}
