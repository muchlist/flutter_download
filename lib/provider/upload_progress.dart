import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class UploadProgress with ChangeNotifier {
  var _progress = 0.0;

  double get progress => _progress;

  void start({@required String url, @required String filename}) async {
    //upload logic here
    _resetProgress();

    // path and name
    final directory = await getTemporaryDirectory();
    final filePath = "${directory.path}/$filename";

    final payload =
        FormData.fromMap({"file": await MultipartFile.fromFile(filePath)});

    /*
    // if file upload more than one
    final payload = FormData.fromMap({
      "nickname" : "muchlis",
      "morefile": [
        await MultipartFile.fromFile(filePath),
        await MultipartFile.fromFile(filePath)
      ]
    });
    */


    /*
    // Default seeting for Dio
    final options = BaseOptions(
      baseUrl: "https://muchlis.dev/api/v1/",
      connectTimeout: 4000,
      receiveTimeout: 3000,
      headers: {
        "bearer" : "value",
        "something": 5,
      }
    );

    final dio = Dio(options);

    // menggunkanannya tinggal
    await dio.get<T>(...);
    await dio.download(...);
    */

    await Dio().post<String>(url,
        data: payload,
        options: Options(contentType: Headers.formUrlEncodedContentType),
        onSendProgress: (sent, total) {
      var pos = sent / total * 100;
      _updateProgress(pos);
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
