import 'package:flutter/material.dart';

import 'package:shawn_app/screens/browser.dart';

class ArticleList extends StatelessWidget {
  final list;

  ArticleList({Key key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> datas = this
        .list
        .map<Widget>((e) => ArticItem(
              title: e['title'],
              url: e['url'],
              imgUrl: e['urlToImage'],
              desc: e['description'],
              date: e['publishedAt'],
            ))
        .toList();

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
    return ListView(
      children: datas,
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
