import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  static String routeName = "/web_view";

  @override
  WebViewScreenState createState() => WebViewScreenState();
}

class WebViewScreenState extends State<WebViewScreen> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    // if (Platform.isIOS) WebView.platform = IOSWebView();
  }

  @override
  Widget build(BuildContext context) {
    final WebViewArguments webArgs =
    ModalRoute.of(context).settings.arguments as WebViewArguments;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: WebView(
        initialUrl: webArgs.url,
      ),
    );
  }
}

class WebViewArguments {
  final String url;

  WebViewArguments({this.url});
}
