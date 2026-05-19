import 'dart:io';

import 'package:path_provider/path_provider.dart';

class Base64ToFile {
  static Future<String> base64ToFile(List<int> bytes) async {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/temp_doc.pdf');
    await file.writeAsBytes(bytes);
    return file.path;
  }
}
