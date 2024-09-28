import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  static const String baseUrl =
      'https://crudcrud.com/api/933a808629a2488d8a918ad945233461https://crudcrud.com/api/933a808629a2488d8a918ad945233461';

  // Projects-------------------------------------------------------------------------->
  static Future<Map<String, dynamic>?> getProjects() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/projects'));

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        print(
            'Error: Failed to load projects. Status Code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: Unable to load projects. Exception: $e');
      return null;
    }
  }

  static Future<void> updateProject(
      String projectId, Map<String, dynamic> projectData) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/projects/$projectId'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(projectData),
      );

      if (response.statusCode == 200) {
        print('Project updated successfully.');
      } else {
        print(
            'Error: Failed to update project. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: Unable to update project. Exception: $e');
    }
  }
static Future<void> saveProjects(Map<String, dynamic> newProject) async {
  try {
    final existingProjects = await getProjects();
    bool isDuplicate = false;

    if (existingProjects != null) {
      for (var project in existingProjects['projects'] ?? []) {
        if (project['name'] == newProject['name']) { 
          isDuplicate = true;
          break;
        }
      }
    }

    if (!isDuplicate) {
      
      final response = await http.post(
        Uri.parse('$baseUrl/projects'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(newProject),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Project saved successfully.');
      } else {
        print('Error: Failed to save project. Status Code: ${response.statusCode}');
      }
    } else {
      print('Error: Project already exists.');
    }
  } catch (e) {
    print('Error: Unable to save project. Exception: $e');
  }
}


  static Future<void> deleteProject(String projectId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/projects/$projectId'),
      );

      if (response.statusCode == 200) {
        print('Project deleted successfully.');
      } else {
        print(
            'Error: Failed to delete project. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: Unable to delete project. Exception: $e');
    }
  }

  // Tasks_----------------------------------------------------------------------------------->
  static Future<List<Map<String, dynamic>>?> getTasks() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/tasks'));

      if (response.statusCode == 200) {
        List tasks = jsonDecode(response.body);

        final uniqueTasks = tasks.toSet().toList();

        return uniqueTasks.cast<Map<String, dynamic>>();
      } else {
        print(
            'Error: Failed to load tasks. Status Code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: Unable to load tasks. Exception: $e');
      return null;
    }
  }

  static Future<void> saveTasks(Map<String, dynamic> newTask) async {
    try {
      final existingTasks = await getTasks();
      bool isDuplicate = false;

      if (existingTasks != null) {
        for (var task in existingTasks) {
          if (task['name'] == newTask['name']) {
            isDuplicate = true;
            break;
          }
        }
      }

      if (!isDuplicate) {
        final response = await http.post(
          Uri.parse('$baseUrl/tasks'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(newTask),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          print('Task saved successfully.');
        } else {
          print(
              'Error: Failed to save task. Status Code: ${response.statusCode}');
        }
      } else {
        print('Error: Task already exists.');
      }
    } catch (e) {
      print('Error: Unable to save task. Exception: $e');
    }
  }

  static Future<void> updateTasks(
      String taskId, Map<String, dynamic> tasks) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/tasks/$taskId'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(tasks),
      );

      if (response.statusCode == 200) {
        print('Tasks updated successfully.');
      } else {
        print(
            'Error: Failed to update tasks. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: Unable to update tasks. Exception: $e');
    }
  }

  static Future<void> postTasks(Map<String, dynamic> taskData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/tasks'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(taskData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Task created successfully.');
      } else {
        print(
            'Error: Failed to create task. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: Unable to create task. Exception: $e');
    }
  }

  static Future<void> deleteTask(String taskId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/tasks/$taskId'),
      );

      if (response.statusCode == 200) {
        print('Task deleted successfully.');
      } else {
        print(
            'Error: Failed to delete task. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: Unable to delete task. Exception: $e');
    }
  }
}
