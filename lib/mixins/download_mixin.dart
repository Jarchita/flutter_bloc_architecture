import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';

import '../exports/utilities.dart';

/// @Purpose:contains method to download any file

mixin DownloadMixin {
  ///get local filepath
  Future<String> get _localPath async {
    String path ;

    if (Platform.isAndroid) {
      /*  final directories =
          await getExternalStorageDirectories(type: StorageDirectory.downloads);
      path = directories?[0].path ?? "";*/
      // final directory = await getExternalStorageDirectory();
      final directory = Directory('/storage/emulated/0/Download');
      path = directory.path;
    } else {
      // final directory = await getApplicationDocumentsDirectory();
      // path = directory.path;
      path = "";
    }

    return path;
  }

  ///create local file from local path
  Future<File> _localFile(String fileName) async {
    final path = await _localPath;
    return File('$path/$fileName');
  }

  ///write into local file from response
  Future<File> _writeCounter(Uint8List stream, String fileName) async {
    final file = await _localFile(fileName);
    // Write the file
    return file.writeAsBytes(stream);
  }

  ///fetch file from server
  Future<Uint8List> _fetchFileFromServer(String filePath) async {
    final response = await http.get(Uri.parse(filePath));
    final responseJson = response.bodyBytes;
    return responseJson;
  }

  Future<String> downloadAnyFile(String filePath, String fileName) async {
    await _writeCounter(await _fetchFileFromServer(filePath), fileName);
    final path = (await _localFile(fileName)).path;
    Logger.d("local path", path);
    return path;
  }
}
