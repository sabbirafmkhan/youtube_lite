import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebPage extends StatefulWidget {
  const WebPage({super.key});

  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  late InAppWebViewController _inAppWebViewController;
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool isPop) async {
        if (await _inAppWebViewController.canGoBack()) {
          _inAppWebViewController.goBack();
        } else {
          exit(0);
        }
      },
      child: Scaffold(
        appBar:
            MediaQuery.of(context).orientation == Orientation.landscape
                ? null
                : AppBar(
                  title: const Text(
                    "Youtube Lite",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () async {
                        if (await _inAppWebViewController.canGoBack()) {
                          _inAppWebViewController.goBack();
                        }
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ],
                  centerTitle: true,
                  backgroundColor: Colors.blue,
                ),
        body: Stack(
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(
                url: WebUri('https://www.youtube.com/watch?v=DG9S-LTPg_4'),
              ),
              initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                  javaScriptEnabled: true,
                  supportZoom: false,
                ),
              ),
              onWebViewCreated: (controller) {
                _inAppWebViewController = controller;
              },
              onLoadStop: (controller, url) {
                setState(() {
                  progress = 1.0;
                });
              },
              onProgressChanged: (controller, progress) {
                setState(() {
                  this.progress = progress / 100;
                });
              },
            ),
            if (progress < 1.0)
              LinearProgressIndicator(
                value: progress,
                color: Colors.red,
                backgroundColor: Colors.white,
              ),
          ],
        ),
      ),
    );
  }
}
