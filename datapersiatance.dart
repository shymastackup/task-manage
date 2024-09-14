import 'dart:convert';
import 'dart:io';

class Datapersiatance {
  final String filePath;

  Datapersiatance(this.filePath);

  Future<Map<String, dynamic>> readJsonFile() async {
    try {
      final file = File(filePath);

      if (!await file.exists()) {
        print("File not found, creating a new one.");
        return {};
      }

      final contents = await file.readAsString();
      if (contents.isEmpty) {
        return {};
      }
      return jsonDecode(contents);
    } catch (e) {
      print("Error reading JSON file: $e");
      return {};
    }
  }

  Future<void> writeJsonFile(Map<String, dynamic> data) async {
    try {
      final file = File(filePath);
      final contents = jsonEncode(data);
      await file.writeAsString(contents);
    } catch (e) {
      print("Error writing JSON file: $e");
    }
  }
}
