import 'dart:io';
import 'project_manager.dart';
import 'task.dart';

void main() async {
  final projectManager = ProjectManager();
  await projectManager.loadProjectsFromFile();

  while (true) {
    try {
      print("\nProject Management System:");
      print("1. Create Project");
      print("2. Add Task to Project");
      print("3. View Tasks of Project");
      print("4. Start a Task");
      print("5. Complete a Task");
      print("6. Update a Task");
      print("7. Delete a Task");
      print("8. Delete a Project");
      print("9. View All Projects");
      print("10. Search for Project by Name");
      print("11. View Completed Tasks in a Project");
      print("12. View Pending Tasks in a Project");
      print("13. Extend Task Deadline");
      print("14. View Project Details");
      print("15. Exit");
      stdout.write("Choose an option: ");
      var choice = stdin.readLineSync();

      switch (choice) {
        case '1':
          stdout.write("Enter project name: ");
          String name = stdin.readLineSync()!;
          while (name.isEmpty) {
            stdout.write('ReEnter project name: ');
            name = stdin.readLineSync()!;
          }
          stdout.write("Enter project description: ");
          String description = stdin.readLineSync()!;
          while (description.isEmpty) {
            stdout.write('ReEnter description: ');
            description = stdin.readLineSync()!;
          }

          stdout.write("Enter start date (YYYY-MM-DD): ");
          DateTime startDate;
          try {
            startDate = DateTime.parse(stdin.readLineSync()!);
          } catch (e) {
            print("Invalid date format. Please use YYYY-MM-DD.");
            continue;
          }

          projectManager.createProject(name, description, startDate);
          print("Project created successfully.");
          break;

        case '2':
          stdout.write("Enter project name to add task: ");
          String projectName = stdin.readLineSync()!;
          stdout.write("Enter task title: ");
          String taskTitle = stdin.readLineSync()!;
          stdout.write("Enter task description: ");
          String taskDescription = stdin.readLineSync()!;
          stdout.write("Enter task deadline (YYYY-MM-DD): ");
          DateTime deadline;
          try {
            deadline = DateTime.parse(stdin.readLineSync()!);
          } catch (e) {
            print("Invalid date format. Please use YYYY-MM-DD.");
            continue;
          }

          // If Task class has an 'id' field, ensure to add it to the constructor
          Task newTask = Task(
            title: taskTitle,
            description: taskDescription,
            deadline: deadline,
          );

          projectManager.addTaskToProject(projectName, newTask);
          print("Task added successfully.");
          break;

        case '3':
          stdout.write("Enter project name to view tasks: ");
          String projectName = stdin.readLineSync()!;
          projectManager.viewTasksOfProject(projectName);
          break;

        case '4':
          stdout.write("Enter project name to start task: ");
          String projectName = stdin.readLineSync()!;
          stdout.write("Enter task title to start: ");
          String taskTitle = stdin.readLineSync()!;
          projectManager.startTask(projectName, taskTitle);
          break;

        case '5':
          stdout.write("Enter project name to complete task: ");
          String projectName = stdin.readLineSync()!;
          stdout.write("Enter task title to complete: ");
          String taskTitle = stdin.readLineSync()!;
          projectManager.completeTask(projectName, taskTitle);
          break;

        case '6':
          stdout.write("Enter project name to update task: ");
          String projectName = stdin.readLineSync()!;
          stdout.write("Enter task title to update: ");
          String taskTitle = stdin.readLineSync()!;
          stdout.write("Enter new task title: ");
          String newTitle = stdin.readLineSync()!;
          stdout.write("Enter new task description: ");
          String newDescription = stdin.readLineSync()!;
          stdout.write("Enter new task deadline (YYYY-MM-DD): ");
          DateTime newDeadline;
          try {
            newDeadline = DateTime.parse(stdin.readLineSync()!);
          } catch (e) {
            print("Invalid date format. Please use YYYY-MM-DD.");
            continue;
          }
          projectManager.updateTask(
              projectName, taskTitle, newTitle, newDescription, newDeadline);
          print("Task updated successfully.");
          break;

        case '7':
          stdout.write("Enter project name to delete task: ");
          String projectName = stdin.readLineSync()!;
          stdout.write("Enter task title to delete: ");
          String taskTitle = stdin.readLineSync()!;
          projectManager.deleteTask(projectName, taskTitle);
          print("Task deleted successfully.");
          break;

        case '8':
          stdout.write("Enter project name to delete: ");
          String projectName = stdin.readLineSync()!;
          projectManager.deleteProject(projectName);
          print("Project deleted successfully.");
          break;

        case '9':
          projectManager.viewAllProjects();
          break;

        case '10':
          stdout.write("Enter project name to search: ");
          String searchName = stdin.readLineSync()!;
          projectManager.searchProjectByName(searchName);
          break;

        case '11':
          stdout.write("Enter project name to view completed tasks: ");
          String projectName = stdin.readLineSync()!;
          projectManager.viewCompletedTasks(projectName);
          break;

        case '12':
          stdout.write("Enter project name to view pending tasks: ");
          String projectName = stdin.readLineSync()!;
          projectManager.viewPendingTasks(projectName);
          break;

        case '13':
          stdout.write("Enter project name: ");
          String projectName = stdin.readLineSync()!;
          stdout.write("Enter task title to extend deadline: ");
          String taskTitle = stdin.readLineSync()!;
          stdout.write("Enter new task deadline (YYYY-MM-DD): ");
          DateTime newDeadline;
          try {
            newDeadline = DateTime.parse(stdin.readLineSync()!);
          } catch (e) {
            print("Invalid date format. Please use YYYY-MM-DD.");
            continue;
          }
          projectManager.extendTaskDeadline(
              projectName, taskTitle, newDeadline);
          print("Task deadline extended.");
          break;

        case '14':
          stdout.write("Enter project name to view details: ");
          String projectName = stdin.readLineSync()!;
          projectManager.viewProjectDetails(projectName);
          break;

        case '15':
          exit(0);

        default:
          print("Invalid option. Please try again.");
      }
    } catch (e) {
      print("An error occurred: $e. Please try again.");
    }
  }
}
