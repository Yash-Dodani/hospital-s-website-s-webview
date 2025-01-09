import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:google_fonts/google_fonts.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  final String title;

  const WebViewPage({
    Key? key,
    required this.url,
    required this.title,
  }) : super(key: key);

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late InAppWebViewController _webViewController;
  bool isLoading = true;

  void _injectJavaScript() {
    String jsScript = """
    let navbar = document.getElementById('ftco-navbar');
    if (navbar) navbar.style.display = "none";
    
    let footer = document.querySelector("footer");
    if (footer) footer.style.display = "none";
    
    let img = document.querySelector('.img-fluid');
    if (img) img.style.display = "none";
    
    let wrap = document.querySelector('.wrap');
    if (wrap) wrap.style.display = "none";
    """;
    _webViewController.evaluateJavascript(source: jsScript);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange.shade400,
        title: Text(
          widget.title,
          style: GoogleFonts.aboreto(
            fontSize: 20.5,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(widget.url)),
            onWebViewCreated: (controller) {
              _webViewController = controller;
            },
            onLoadStop: (controller, url) {
              _injectJavaScript();
              setState(() {
                isLoading = false;
              });
            },
            onLoadStart: (controller, url) {
              setState(() {
                isLoading = true;
              });
            },
          ),
          if (isLoading)
            Center(
              child: CircularProgressIndicator(
                color: Colors.orange.shade400,
              ),
            ),
        ],
      ),
    );
  }
}