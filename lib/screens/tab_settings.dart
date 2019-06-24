import 'package:flutter/material.dart';
import 'package:WeNews/data/preferences.dart';

class TabSettings extends StatefulWidget {
  final title;

  const TabSettings({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TabSettingsState();
}

class _TabSettingsState extends State<TabSettings> {
  final TextEditingController controller = new TextEditingController();
  List data = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    //退出记得销毁
    controller.dispose();
    super.dispose();
  }

  buildDialogFunction(int index) async {
    return () async {
      var oldValue = (await prefsVals)[index];
      bool isNumber = oldValue.runtimeType == int;
      String title = titleTxts[index];
      print('原来的值${oldValue}');
      controller.text = oldValue.toString();
      var result = await showDialog(
          context: context,
          builder: (context) => SimpleDialog(
                contentPadding: EdgeInsets.only(bottom: 0),
                title: Text('设置【${title}】'),
                children: <Widget>[
                  Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                      child: TextField(
                        keyboardType: isNumber
                            ? TextInputType.numberWithOptions()
                            : TextInputType.text,
                        controller: controller,
                        decoration: InputDecoration(
                          hintText: "请输入${title}",
                        ),
                      )),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: SimpleDialogOption(
                          child: Text(
                            '确定',
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            String curValue = controller.text;
                            print('input>>${curValue}');

                            isNumber
                                ? PreferencesUtil.saveInt(
                                    prefsKeys[index], int.parse(curValue))
                                : PreferencesUtil.saveString(
                                    prefsKeys[index], curValue);
                            loadData(); //刷新数据
                            Navigator.pop(context, 'OK');
                          },
                        ),
                      ),
                      VerticalDivider(
                        width: 1,
                        color: Colors.black12,
                      ),
                      Expanded(
                        child: SimpleDialogOption(
                          child: Text('取消', textAlign: TextAlign.center),
                          onPressed: () {
                            Navigator.pop(context, 'Cancel');
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ));

      print("which-click>>${result}");
    };
  }

  static const List titleTxts = ['关键字', '单次加载数量', '语言', '国家'];
  static const List prefsKeys = [
    PreferencesConstants.NEWS_KEYWORD,
    PreferencesConstants.NEWS_PAGESIZE,
    PreferencesConstants.NEWS_LAN,
    PreferencesConstants.NEWS_COUNTRY
  ];

  get prefsVals async {
    List prefsVals = [
      await PreferencesUtil.getString(prefsKeys[0]) ?? 'china',
      await PreferencesUtil.getInt(prefsKeys[1]) ?? 20.toString(),
      await PreferencesUtil.getString(prefsKeys[2]) ?? '',
      await PreferencesUtil.getString(prefsKeys[3]) ?? 'cn'
    ];
    return prefsVals;
  }

  void loadData() async {
    List data = [
      {
        'title': titleTxts[0],
        'subtitle': '【首页】是以关键字"${(await prefsVals)[0]}"搜索的结果',
        'onPressed': await buildDialogFunction(0),
        'ledIcon': Icons.map,
      },
      {
        'title': titleTxts[1],
        'subtitle': '【首页】、【热点】单页加载"${(await prefsVals)[1]}"条数据',
        'onPressed': await buildDialogFunction(1),
        'ledIcon': Icons.list,
      },
      {
        'title': titleTxts[2],
        'subtitle': '【首页】以"${(await prefsVals)[2]}"为语言结果数据',
        'onPressed': await buildDialogFunction(2),
        'ledIcon': Icons.language,
      },
      {
        'title': titleTxts[3],
        'subtitle': '【热点】是在以"${(await prefsVals)[3]}"筛选的结果',
        'onPressed': await buildDialogFunction(3),
        'ledIcon': Icons.star,
      },
    ];

    setState(() {
      this.data = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:

//      ListView(
          //方式1实现分割线
//        children: data
//            .map<Widget>((e) => SettingsItem(
//                  title: e['title'],
//                  subtitle: e['subtitle'],
//                  onPressed: e['onPressed'],
//                  ledIcon: e['ledIcon'],
//                ))
//            .toList(),
//      方式2实现分割线
//        children: ListTile.divideTiles(
//                context: context,
//                tiles: data.map<Widget>((e) => ListTile(
//                      title: Text(e['title']),
//                      subtitle: Text(e['subtitle']),
//                      onTap: e['onPressed'],
//                      leading: Icon(e['ledIcon']),
//                    )),
//                color: Theme.of(context).dividerColor)
//            .toList(),
//      )
          //      方式3实现分割线
          ListView.separated(
              itemBuilder: (BuildContext context, int index) => ListTile(
                    title: Text(data[index]['title']),
                    subtitle: Text(data[index]['subtitle']),
                    onTap: data[index]['onPressed'],
                    leading: Icon(data[index]['ledIcon']),
                  ),
              separatorBuilder: (BuildContext context, int index) => Divider(),
              itemCount: data.length),
    );
  }
}

//class SettingsItem extends StatelessWidget {
//  final String title;
//  final String subtitle;
//
//  IconData ledIcon;
//
//  final Function onPressed;
//
//  SettingsItem({this.title, this.onPressed, this.subtitle, this.ledIcon})
//      : super();
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      child: ListTile(
//        title: Text(
//          title,
//        ),
//        subtitle: Text(
//          subtitle,
//        ),
//        onTap: onPressed,
//        trailing: Icon(Icons.arrow_forward_ios),
//        leading: Icon(ledIcon),
//      ),
//      decoration: BoxDecoration(
//          border: Border(
//              bottom:
////              Divider.createBorderSide(context,
////                  color: Theme.of(context).dividerColor, width: 1))),
//                  BorderSide(color: Theme.of(context).dividerColor, width: 1))),
//    );
//  }
//}
