import 'dart:convert';
import 'dart:io';

class Api {
  static final String apiUrl =
      'https://crudcrud.com/api/166ea4f7ab484ac89a1bfb65377c0bba';


  static Future<Map<String, dynamic>> getProjects() async {
  try {
    final file = File('projects.json');
    
    if (await file.exists()) {
      String data = await file.readAsString();
      final decodedData = jsonDecode(data);

      if (decodedData is Map<String, dynamic>) {
        return decodedData; 
      } else if (decodedData is List) {
      
        return {'projects': decodedData};
      } else {
      
        return {};
      }
    } else {
      return {};
    }
  } catch (e) {
    print('Error: Unable to load projects. Reason: $e');
    return {};
  }
}



  static Future<void> saveProjects(Map<String, dynamic> projectsData) async {
    try {
      final file = File('projects.json');
      await file.writeAsString(jsonEncode(projectsData));
      print('Projects saved successfully to API.');
    } catch (e) {
      print('Error: Unable to save projects to API. Reason: $e');
    }
  }

  static Future<void> updateProject(
      String projectId, Map<String, dynamic> updatedData) async {
    try {
      final projects = await getProjects();
      List<dynamic> projectsList = projects['projects'] ?? [];

      for (var project in projectsList) {
        if (project['id'] == projectId) {
          project['name'] = updatedData['name'];
          project['description'] = updatedData['description'];
          project['startDate'] = updatedData['startDate'];

          break;
        }
      }

      await saveProjects({'projects': projectsList});
      print('Project updated successfully.');
    } catch (e) {
      print('Error: Unable to update project. Reason: $e');
    }
  }

  static Future<void> deleteProject(String projectId) async {
    try {
      final projects = await getProjects();
      List<dynamic> projectsList = projects['projects'] ?? [];

      projectsList.removeWhere((project) => project['id'] == projectId);

      await saveProjects({'projects': projectsList});
      print('Project deleted successfully.');
    } catch (e) {
      print('Error: Unable to delete project. Reason: $e');
    }
  }
////task__________________________________________________________>
  static Future<Map<String, dynamic>> getTasks() async {
    try {
      final file = File('tasks.json');

      if (await file.exists()) {
        String data = await file.readAsString();
        return jsonDecode(data);
      } else {
        return {};
      }
    } catch (e) {
      print('Error: Unable to load tasks from API. Reason: $e');
      return {};
    }
  }

  static Future<void> saveTasks(Map<String, dynamic> tasksData) async {
    try {
      final file = File('tasks.json');
      await file.writeAsString(jsonEncode(tasksData));
      print('Tasks saved successfully to API.');
    } catch (e) {
      print('Error: Unable to save tasks to API. Reason: $e');
    }
  }

  static Future<void> createTask(Map<String, dynamic> taskData) async {
    try {
      final tasks = await getTasks();
      List<dynamic> tasksList = tasks['tasks'] ?? [];

      tasksList.add(taskData); 
      await saveTasks({'tasks': tasksList});

      print('Task created successfully.');
    } catch (e) {
      print('Error: Unable to create task. Reason: $e');
    }
  }

  static Future<List<dynamic>> readTasks() async {
    try {
      final tasks = await getTasks();
      return tasks['tasks'] ?? [];
    } catch (e) {
      print('Error: Unable to read tasks. Reason: $e');
      return [];
    }
  }

  static Future<void> updateTask(
      String taskId, Map<String, dynamic> updatedData) async {
    try {
      final tasks = await getTasks();
      List<dynamic> tasksList = tasks['tasks'] ?? [];

      for (var task in tasksList) {
        if (task['id'] == taskId) {
          task['title'] = updatedData['title'];
          task['description'] = updatedData['description'];
          task['dueDate'] = updatedData['dueDate'];

          break;
        }
      }

      await saveTasks({'tasks': tasksList});
      print('Task updated successfully.');
    } catch (e) {
      print('Error: Unable to update task. Reason: $e');
    }
  }

  static Future<void> deleteTask(String taskId) async {
    try {
      final tasks = await getTasks();
      List<dynamic> tasksList = tasks['tasks'] ?? [];

      tasksList.removeWhere((task) => task['id'] == taskId);

      await saveTasks({'tasks': tasksList});
      print('Task deleted successfully.');
    } catch (e) {
      print('Error: Unable to delete task. Reason: $e');
    }
  }
}
