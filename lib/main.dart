import 'package:flutter/material.dart';
import 'file:///C:/flutter-project/flutter_download/lib/provider/download_progress.dart';
import 'package:provider/provider.dart';

import 'download_widget.dart';

void main() => runApp(DemoApp());

class DemoApp extends StatelessWidget {
  const DemoApp();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DownloadProgress>(
      create: (_) => DownloadProgress(),
      child: MaterialApp(
          home: Scaffold(
              appBar: AppBar(
                title: const Text("Download Demo"),
              ),
              body: Center(
                child: const DownloadWidget(),
              )
          )
      ),
    );
  }
}