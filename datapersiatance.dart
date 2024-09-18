 import 'dart:convert';
 import 'dart:io';
 class Datapersiatance {
  final String filePath;

  Datapersiatance(this.filePath);

  Future<void> saveProjectsToFile(Map<String, dynamic> projects) async {
    try {
      final file = File(filePath);
   
      String jsonString = jsonEncode(projects);
      await file.writeAsString(jsonString);
      print("Data saved successfully to $filePath.");
    } catch (e) {
      print("Error while saving data to $filePath: $e");
    }
  }

  Future<Map<String, dynamic>> loadProjectsFromFile() async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
   
        String jsonString = await file.readAsString();
      
        return jsonDecode(jsonString);
      } else {
        print("No data file found, returning an empty project list.");
        return {};
      }
    } catch (e) {
      print("Error while loading data from $filePath: $e");
      return {};
    }
  }
 }
