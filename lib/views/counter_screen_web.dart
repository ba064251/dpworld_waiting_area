import '../index.dart';

class CounterScreenWebView extends StatefulWidget {
  const CounterScreenWebView({super.key, required this.url});

  final String url;

  @override
  State<CounterScreenWebView> createState() => _CounterScreenWebViewState();
}

class _CounterScreenWebViewState extends State<CounterScreenWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CallingProvider>(context, listen: false).startPolling();
    });


    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            debugPrint("Page loading: $url");
          },
          onPageFinished: (url) {
            debugPrint("Page loaded: $url");
          },
          onWebResourceError: (error) {
            debugPrint("Web error: ${error.description}");
          },
        ),
      )
      ..loadRequest(
        Uri.parse(
          "${widget.url}/CounterScreen?branchId=7",
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: _controller),
    );
  }
}