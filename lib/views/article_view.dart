// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class ArticleView extends StatefulWidget {
//
//   final String blogUrl;
//   ArticleView({required this.blogUrl});
//
//   @override
//   _ArticleViewState createState() => _ArticleViewState();
// }
//
// class _ArticleViewState extends State<ArticleView> {
//   final Completer<WebViewController> _completer = Completer<WebViewController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//      appBar: AppBar(
//        title: const Row(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Text("Flutter", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.black87)),
//            Text("News",style: TextStyle( fontWeight: FontWeight.bold , color: Colors.black87)) ,
//            //style: TextStyle(color: Colors.blue),
//          ],
//        ),
//          actions:<Widget>[
//            Opacity(opacity:0, child: Container(padding: EdgeInsets.symmetric(horizontal: 16), child: Icon(Icons.save)))
//          ],
//
//        centerTitle: true,
//        elevation: 0.0,
//      ),
//
//     body:Container(
//       height: MediaQuery.of(context).size.height,
//       width: MediaQuery.of(context).size.width,
//       child: WebView(
//         initialUrl:  widget.blogUrl,
//         onWebViewCreated: (WebViewController webViewController){
//           _completer.complete(webViewController);
//         },
//       ),
//     ),
//     );
//   }
//
//
// }


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {

  final String blogUrl;
  const ArticleView({super.key, required this.blogUrl});

  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {

  final Completer<WebViewController> _controller = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Flutter",
              style:
              TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
            ),
            Text(
              "News",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
            )
          ],
        ),
        actions: <Widget>[
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Icon(Icons.share,))
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WebView(
          initialUrl:  widget.blogUrl,
          onWebViewCreated: (WebViewController webViewController){
            _controller.complete(webViewController);
          },
        ),
      ),
    );
  }

}

