import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';


class WebPage extends StatefulWidget {
  const WebPage({super.key});

  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  late InAppWebViewController _webViewController;
  double _progress = 0;
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
