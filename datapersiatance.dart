import 'dart:convert';
import 'dart:io';

class Datapersiatance {
  Future<Map> readJsonFile(String fileName) async {
    try {
      final file = File(fileName);
      if (await file.exists()) {
        final contents = await file.readAsString();
        final jsonData = jsonDecode(contents);

        if (jsonData is List) {
          return {'projects': jsonData};
        } else if (jsonData is Map) {
          return jsonData;
        } else {
          return {};
        }
      } else {
        return {};
      }
    } catch (e) {
      print('Error reading JSON file: $e');
      return {};
    }
  }

  Future<void> writeJsonFile(String fileName, Map<String, dynamic> data) async {
    try {
      final file = File(fileName);
      final contents = jsonEncode(data);
      await file.writeAsString(contents);
    } catch (e) {
      print('Error writing JSON file: $e');
    }
  }
}
