import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebContentPage extends StatefulWidget {
  @override
  State createState() {
    return WebContentPageState();
  }
}

class WebContentPageState extends State<WebContentPage> {

  WebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RaisedButton(
            onPressed: (){
              webViewController.loadUrl("https://google.de");
            },
            child: Text("Load Google"),
          ),
        Expanded(
          child: Container(
            child: WebView(
              initialUrl: 'https://flutter.io',
              javaScriptMode: JavaScriptMode.unrestricted,
              onWebViewCreated: (ctrl){
                webViewController = ctrl;
              },
            ),
          ),
        )
      ],
    );
  }
}
