import 'dart:io';
import 'package:get/get_connect.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../config/app_config.dart';
import '../util/token_util.dart';

class FileService extends GetConnect {
  Future<http.StreamedResponse> upload(File file) async {
    // Const
    var fileFieldName = 'file';
    var mediaTypeStr = 'application/octet-stream';

    // Set request
    var request = http.MultipartRequest('POST', Uri.parse('${AppConfig.apiDomain}/firebase/upload'));
    request.headers['Authorization'] = 'Bearer ${TokenUtil.getAccessToken()}';
    request.files.add(
      http.MultipartFile.fromBytes(
        fileFieldName,
        file.readAsBytesSync(),
        filename: file.path.split('/').last,
        contentType: MediaType.parse(mediaTypeStr),
      ),
    );

    // Send request
    return await request.send();
  }
}
