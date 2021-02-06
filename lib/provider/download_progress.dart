import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class DownloadProgress with ChangeNotifier {
  var _progress = 0.0;

  double get progress => _progress;

  void start({@required String url, @required String filename}) async {
    //download logic here
    //reset progress dulu
    _resetProgress();

    //path and name
    final directory = await getTemporaryDirectory();
    final pathName = "${directory.path}/$filename";

    //download menggunkan Dio
    await Dio().download(url, pathName,
        options: Options(headers: {HttpHeaders.acceptEncodingHeader: "*"}),
        onReceiveProgress: (received, total) {
      if (total != -1) {
        // persentasi dari data yang diterima terlampaui
        // total ukuran file terdownlod
        var pos = received / total * 100;
        _updateProgress(pos);
      }
    });
  }

  void _resetProgress() {
    if (progress != 0) {
      _progress = 0;
      notifyListeners();
    }
  }

  void _updateProgress(double value) {
    _progress = value;
    notifyListeners();
  }
}
