import 'dart:io';
import 'project_manager.dart';
import 'datapersiatance.dart';
import 'task.dart';

void main() async {
  final datapersiatance = Datapersiatance(); 
  final projectManager = ProjectManager(datapersiatance);
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

      var choice = stdin.readLineSync()!;
      while (choice.isEmpty ||
          int.tryParse(choice) == null ||
          int.parse(choice) < 1 ||
          int.parse(choice) > 15) {
        stdout.write('Invalid option. Enter a number between 1 and 15: ');
        choice = stdin.readLineSync()!;
      }

      switch (choice) {
        case '1':
          stdout.write("Enter project name: ");
          String name = stdin.readLineSync()!;
          while (name.isEmpty) {
            stdout.write('Re-enter project name: ');
            name = stdin.readLineSync()!;
          }

          stdout.write("Enter project description: ");
          String description = stdin.readLineSync()!;
          while (description.isEmpty) {
            stdout.write('Re-enter description: ');
            description = stdin.readLineSync()!;
          }

          stdout.write("Enter project start date (YYYY-MM-DD): ");
          String dateStr = stdin.readLineSync()!;
          DateTime startDate = DateTime.parse(dateStr);

          projectManager.createProject(name, description, startDate);
          break;

        case '2':
          stdout.write("Enter project name: ");
          String projectName = stdin.readLineSync()!;
          while (projectName.isEmpty) {
            stdout.write('Re-enter project name: ');
            projectName = stdin.readLineSync()!;
          }

          stdout.write("Enter task title: ");
          String title = stdin.readLineSync()!;
          while (title.isEmpty) {
            stdout.write('Re-enter task title: ');
            title = stdin.readLineSync()!;
          }

          stdout.write("Enter task description: ");
          String taskDescription = stdin.readLineSync()!;
          while (taskDescription.isEmpty) {
            stdout.write('Re-enter task description: ');
            taskDescription = stdin.readLineSync()!;
          }

          stdout.write("Enter task deadline (YYYY-MM-DD): ");
          String deadlineStr = stdin.readLineSync()!;
          DateTime deadline = DateTime.parse(deadlineStr);

          final task = Task(
            title: title,
            description: taskDescription,
            deadline: deadline,
            isCompleted: false,
          );

          projectManager.addTaskToProject(projectName, task);
          break;

        case '3':
          stdout.write("Enter project name: ");
          String viewProjectName = stdin.readLineSync()!;
          projectManager.viewTasksOfProject(viewProjectName);
          break;

        case '4':
          stdout.write("Enter project name: ");
          String startProjectName = stdin.readLineSync()!;

          stdout.write("Enter task title: ");
          String startTaskTitle = stdin.readLineSync()!;

          projectManager.startTask(startProjectName, startTaskTitle);
          break;

        case '5':
          stdout.write("Enter project name: ");
          String completeProjectName = stdin.readLineSync()!;

          stdout.write("Enter task title: ");
          String completeTaskTitle = stdin.readLineSync()!;

          projectManager.completeTask(completeProjectName, completeTaskTitle);
          break;

        case '6':
          stdout.write("Enter project name: ");
          String updateProjectName = stdin.readLineSync()!;

          stdout.write("Enter old task title: ");
          String oldTaskTitle = stdin.readLineSync()!;

          stdout.write("Enter new task title: ");
          String newTitle = stdin.readLineSync()!;

          stdout.write("Enter new task description: ");
          String newDescription = stdin.readLineSync()!;

          stdout.write("Enter new task deadline (YYYY-MM-DD): ");
          String newDeadlineStr = stdin.readLineSync()!;
          DateTime newDeadline = DateTime.parse(newDeadlineStr);

          projectManager.updateTask(updateProjectName, oldTaskTitle, newTitle,
              newDescription, newDeadline);
          break;

        case '7':
          stdout.write("Enter project name: ");
          String deleteProjectName = stdin.readLineSync()!;

          stdout.write("Enter task title: ");
          String deleteTaskTitle = stdin.readLineSync()!;

          projectManager.deleteTask(deleteProjectName, deleteTaskTitle);
          break;

        case '8':
          stdout.write("Enter project name to delete: ");
          String deleteProjectName = stdin.readLineSync()!;
          projectManager.deleteProject(deleteProjectName);
          break;

        case '9':
          projectManager.viewAllProjects();
          break;

        case '10':
          stdout.write("Enter project name to search: ");
          String searchProjectName = stdin.readLineSync()!;
          projectManager.searchProjectByName(searchProjectName);
          break;

        case '11':
          stdout.write("Enter project name: ");
          String completedProjectName = stdin.readLineSync()!;
          projectManager.viewCompletedTasks(completedProjectName);
          break;

        case '12':
          stdout.write("Enter project name: ");
          String pendingProjectName = stdin.readLineSync()!;
          projectManager.viewPendingTasks(pendingProjectName);
          break;

        case '13':
          stdout.write("Enter project name: ");
          String extendProjectName = stdin.readLineSync()!;

          stdout.write("Enter task title: ");
          String extendTaskTitle = stdin.readLineSync()!;

          stdout.write("Enter new deadline (YYYY-MM-DD): ");
          String newDeadlineStr = stdin.readLineSync()!;
          DateTime newDeadline = DateTime.parse(newDeadlineStr);

          projectManager.extendTaskDeadline(
              extendProjectName, extendTaskTitle, newDeadline);
          break;

        case '14':
          stdout.write("Enter project name: ");
          String detailsProjectName = stdin.readLineSync()!;
          projectManager.viewProjectDetails(detailsProjectName);
          break;

        case '15':
          exit(0);
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
