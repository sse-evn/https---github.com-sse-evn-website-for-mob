import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    // Инициализация WebView
    WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WebView Example"),
      ),
      body: WebView(
        initialUrl: 'https://almatypolytech.edu.kz/', // Замените на ваш URL
        javascriptMode: JavascriptMode.unrestricted, // Включаем JavaScript
        onWebViewCreated: (WebViewController webViewController) {
          _webViewController = webViewController;
        },
        navigationDelegate: (NavigationRequest request) {
          // Проверка на HTTPS
          if (!request.url.startsWith('https://')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
        onPageStarted: (String url) {
          print('Загрузка страницы: $url');
        },
        onPageFinished: (String url) {
          print('Страница загружена: $url');
        },
        onWebResourceError: (WebResourceError error) {
          // Показать кастомную ошибку
          print('Ошибка: ${error.description}');
        },
      ),
    );
  }
}
