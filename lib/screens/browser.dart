import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class Browser extends StatefulWidget {
  final url;
  final title;

  const Browser({Key key, this.title, @required this.url}) : super(key: key);

  @override
  _BrowserState createState() => _BrowserState();
}

class _BrowserState extends State<Browser> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      url: widget.url,
      allowFileURLs: true,
      withLocalStorage: true,
    );
  }
}
