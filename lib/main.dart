import 'dart:io';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart' as p;
import 'package:dio/dio.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text("Dio Downloader"),
      ),
      body: Downloader(),
    ),
  ));
}

class Downloader extends StatefulWidget {
  const Downloader({Key? key}) : super(key: key);

  @override
  State<Downloader> createState() => _DownloaderState();
}

class _DownloaderState extends State<Downloader> {
  double progress = 0;
  final urlPath =
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4";
  void downloadFile() async {
    final response = await http.get(Uri.parse(urlPath));
    final bytes = await response.bodyBytes;
    final dir = await getDirPath();
    final path = dir!.path;
    var fileName = "video1.mp4";
    File file = File("$path/$fileName");
    file.writeAsBytesSync(bytes);
    // await Dio().downloadUri(Uri.parse(urlPath), file.path,
    //     onReceiveProgress: (rec, tot) {
    //   setState(() {
    //     progress = (rec / tot) * 100gi;
    //   });
    // });
    print("Downloaded");
  }

  Future<Directory?> getDirPath() {
    return p.getExternalStorageDirectory();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          FlatButton(
            color: Colors.blueGrey,
            child: Text("Download"),
            onPressed: () {
              downloadFile();
            },
          ),
          Text(" File Downloaded $progress %")
        ],
      ),
    );
  }
}
