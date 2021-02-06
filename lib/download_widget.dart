import 'package:flutter/material.dart';
import 'package:flutter_download/progress.dart';
import 'package:provider/provider.dart';

class DownloadWidget extends StatelessWidget {
  final String url = "https://website.com/files/test.pdf";

  const DownloadWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<DownloadProgress>(
        builder: (context, status, _) {
          var progress = status.progress.toStringAsFixed(1);

          return ElevatedButton(
              child: Text("$progress %"),
              onPressed: () =>
                  {status.start(url: url, filename: "myfile.pdf")});
        },
      ),
    );
  }
}
