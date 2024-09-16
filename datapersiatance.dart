import 'dart:convert';
import 'dart:io';

class Datapersiatance {
  final String filePath;

  Datapersiatance(this.filePath);


  Future<void> writeJsonFile(Map<String, dynamic> data) async {
    try {
      final file = File(filePath);

      final contents = jsonEncode(data);

      await file.writeAsString(contents, flush: true);
      print("Data saved successfully to $filePath.");
    } catch (e) {
      print("Error writing JSON file: $e");
    }
  }

  Future<Map<String, dynamic>> readJsonFile() async {
    try {
      final file = File(filePath);

      if (!await file.exists()) {
        print("File not found, creating a new one.");
        await file.writeAsString('{}');
        return {};
      }

      final contents = await file.readAsString();

      if (contents.isEmpty) {
        return {};
      }

      final jsonData = jsonDecode(contents);

      if (jsonData is List) {
        print("JSON data is a list. Converting to a map.");
        return {'projects': jsonData};
      }

      if (jsonData is Map<String, dynamic>) {
        return jsonData;
      }

      print("Unexpected JSON format.");
      return {};
    } catch (e) {
      print("Error reading JSON file: $e");
      return {};
    }
  }
}
