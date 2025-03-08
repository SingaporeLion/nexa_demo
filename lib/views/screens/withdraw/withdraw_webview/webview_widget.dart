import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:nexa/core/route/route.dart';
import 'package:nexa/views/components/snackbar/show_custom_snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/utils/my_strings.dart';
import '../../../../core/utils/url_container.dart';

class MyWebViewWidget extends StatefulWidget {
  const MyWebViewWidget({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  State<MyWebViewWidget> createState() => _MyWebViewWidgetState();
}

class _MyWebViewWidgetState extends State<MyWebViewWidget> {
  @override
  void initState() {
    url = widget.url;
    super.initState();
  }

  String url = '';
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;

  InAppWebViewSettings settings = InAppWebViewSettings(
    isInspectable: kDebugMode,
    mediaPlaybackRequiresUserGesture: false,
    allowsInlineMediaPlayback: true,
    iframeAllow: "camera; microphone",
    iframeAllowFullscreen: true,
  );

  bool isKycPending = false;

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      InAppWebViewController.setWebContentsDebuggingEnabled(true);
    }
    return Stack(
      children: [
        isLoading ? const Center(child: CircularProgressIndicator()) : const SizedBox(),
        InAppWebView(
          key: webViewKey,
          initialUrlRequest: URLRequest(url: WebUri(widget.url)),
          onWebViewCreated: (controller) {
            webViewController = controller;
          },
          initialSettings: settings,
          onLoadStart: (controller, url) {
            if (url.toString() == '${UrlContainer.baseUrl}user/mining-tracks') {
              Get.offAndToNamed(RouteHelper.miningTrackScreen);
            } else if (url.toString() == '${UrlContainer.baseUrl}/user/dashboard') {
              Get.back();
              CustomSnackBar.error(errorList: [MyStrings.requestFail]);
            }
          },
          onPermissionRequest: (controller, resources) async {
            return PermissionResponse(resources: resources.resources, action: PermissionResponseAction.GRANT);
          },
          shouldOverrideUrlLoading: (controller, navigationAction) async {
            var uri = navigationAction.request.url!;

            if (!["http", "https", "file", "chrome", "data", "javascript", "about"].contains(uri.scheme)) {
              if (await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(
                  Uri.parse(url),
                );
                return NavigationActionPolicy.CANCEL;
              }
            }
            return NavigationActionPolicy.ALLOW;
          },
          onLoadStop: (controller, url) async {
            setState(() {
              isLoading = false;
              this.url = url.toString();
            });
          },
          onReceivedError: (controller, resourceRequest, resourceError) {},
          onProgressChanged: (controller, progress) {},
          onUpdateVisitedHistory: (controller, url, androidIsReload) {
            setState(() {
              this.url = url.toString();
            });
          },
          onConsoleMessage: (controller, consoleMessage) {},
        )
      ],
    );
  }
}
