import 'dart:io';
import 'project_manager.dart';
import 'task.dart';

void main() async {
  final projectManager = ProjectManager();
  // await projectManager.loadProjectsFromFile();

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

      print("15.save project");
      print("16. Exit");
      stdout.write("Choose an option: ");

      var choice = stdin.readLineSync()!;
      while (choice.isEmpty) {
        stdout.write('Enter the number 1 to 15 options:');
        choice = stdin.readLineSync()!;
      }

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

          DateTime? startDate;
          while (startDate == null) {
            stdout.write("Enter start date (YYYY-MM-DD): ");
            String input = stdin.readLineSync()!;

            try {
              startDate = DateTime.parse(input);

              if (startDate.year < 1000 ||
                  startDate.year > DateTime.now().year) {
                print(
                    "Invalid year. Please enter a year between 1000 and ${DateTime.now().year}.");
                startDate = null;
              }
            } catch (e) {
              print("Invalid date format. Please use YYYY-MM-DD.");
            }
          }

          projectManager.createProject(name, description, startDate);
          print("Project created successfully.");
          break;

        case '2':
          stdout.write("Enter project name to add task: ");
          String projectName = stdin.readLineSync()!;
          while (projectName.isEmpty) {
            stdout.write(
                'Re-enter project name (previously added project name can only be entered): ');
            projectName = stdin.readLineSync()!;
          }

          stdout.write("Enter task title: ");
          String taskTitle = stdin.readLineSync()!;
          while (taskTitle.isEmpty) {
            stdout.write(' Re-enter task title: ');
            taskTitle = stdin.readLineSync()!;
          }

          stdout.write("Enter task description: ");
          String taskDescription = stdin.readLineSync()!;
          while (taskDescription.isEmpty) {
            stdout.write(' Re-enter task description: ');
            taskDescription = stdin.readLineSync()!;
          }

          DateTime? deadline;
          while (deadline == null) {
            stdout.write("Enter task deadline (YYYY-MM-DD): ");
            String deadlineInput = stdin.readLineSync()!;

            try {
              deadline = DateTime.parse(deadlineInput);
            } catch (e) {
              print("Invalid date format. Please use YYYY-MM-DD.");
            }
          }

          Task newTask = Task(
            title: taskTitle,
            description: taskDescription,
            deadline: deadline,
          );

          try {
            projectManager.addTaskToProject(projectName, newTask);
            print("Task added successfully.");
          } catch (e) {
            print(
                "Error: Unable to add task to project '$projectName'. Reason: $e");
          }
          break;

        case '3':
          stdout.write("Enter project name to view tasks: ");
          String projectName = stdin.readLineSync()!;

          while (projectName.isEmpty) {
            stdout.write(' Re-enter project name: ');
            projectName = stdin.readLineSync()!;
          }

          try {
            projectManager.viewTasksOfProject(projectName);
          } catch (e) {
            print(
                "Error: Unable to view tasks for project '$projectName'. Reason: $e");
          }
          break;

        case '4':
          stdout.write("Enter project name to start task: ");
          String projectName = stdin.readLineSync()!;
          while (projectName.isEmpty) {
            stdout.write(' Re-enter project name: ');
            projectName = stdin.readLineSync()!;
          }

          stdout.write("Enter task title to start: ");
          String taskTitle = stdin.readLineSync()!;
          while (taskTitle.isEmpty) {
            stdout.write(' Re-enter task title: ');
            taskTitle = stdin.readLineSync()!;
          }

          try {
            projectManager.startTask(projectName, taskTitle);
            print(
                "Task '$taskTitle' started successfully in project '$projectName'.");
          } catch (e) {
            print(
                "Error: Unable to start task '$taskTitle' in project '$projectName'. Reason: $e");
          }
          break;

        case '5':
          stdout.write("Enter project name to complete task: ");
          String projectName = stdin.readLineSync()!;
          while (projectName.isEmpty) {
            stdout.write('Re-Enter the project Name');
            projectName = stdin.readLineSync()!;
          }

          stdout.write("Enter task title to complete: ");
          String taskTitle = stdin.readLineSync()!;
          while (taskTitle.isEmpty) {
            stdout
                .write('Task title cannot be empty. Re-enter the task title: ');
            taskTitle = stdin.readLineSync()!;
          }

          try {
            projectManager.completeTask(projectName, taskTitle);
            print(
                "Task '$taskTitle' completed successfully in project '$projectName'.");
          } catch (e) {
            print(
                "Error: Unable to complete task '$taskTitle' in project '$projectName'. Reason: $e");
          }
          break;

        case '6':
          stdout.write("Enter project name to update task: ");
          String projectName = stdin.readLineSync()!;
          while (projectName.isEmpty) {
            stdout.write(
                'Project name cannot be empty. Re-enter the project name: ');
            projectName = stdin.readLineSync()!;
          }

          stdout.write("Enter task title to update: ");
          String taskTitle = stdin.readLineSync()!;
          while (taskTitle.isEmpty) {
            stdout
                .write('Task title cannot be empty. Re-enter the task title: ');
            taskTitle = stdin.readLineSync()!;
          }

          stdout.write("Enter new task title: ");
          String newTitle = stdin.readLineSync()!;
          while (newTitle.isEmpty) {
            stdout.write(
                'New task title cannot be empty. Re-enter the new task title: ');
            newTitle = stdin.readLineSync()!;
          }

          stdout.write("Enter new task description: ");
          String newDescription = stdin.readLineSync()!;
          while (newDescription.isEmpty) {
            stdout.write(' Re-enter the new task description: ');
            newDescription = stdin.readLineSync()!;
          }

          DateTime newDeadline;
          while (true) {
            stdout.write("Enter new task deadline (YYYY-MM-DD): ");
            String? deadlineInput = stdin.readLineSync();
            if (deadlineInput == null || deadlineInput.isEmpty) {
              print(' Please enter a valid deadline.');
              continue;
            }
            try {
              newDeadline = DateTime.parse(deadlineInput);
              break;
            } catch (e) {
              print("Invalid date format. Please use YYYY-MM-DD.");
            }
          }

          try {
            projectManager.updateTask(
                projectName, taskTitle, newTitle, newDescription, newDeadline);
            print("Task updated successfully.");
          } catch (e) {
            print(
                "Error: Unable to update task '$taskTitle' in project '$projectName'. Reason: $e");
          }
          break;
        case '7':
          stdout.write("Enter project name to delete task: ");
          String projectName = stdin.readLineSync()!;
          while (projectName.isEmpty) {
            stdout.write(
                'Project name cannot be empty. Re-enter the project name: ');
            projectName = stdin.readLineSync()!;
          }

          stdout.write("Enter task title to delete: ");
          String taskTitle = stdin.readLineSync()!;
          while (taskTitle.isEmpty) {
            stdout
                .write('Task title cannot be empty. Re-enter the task title: ');
            taskTitle = stdin.readLineSync()!;
          }

          try {
            projectManager.deleteTask(projectName, taskTitle);
            print("Task deleted successfully.");
          } catch (e) {
            print(
                "Error: Unable to delete task '$taskTitle' from project '$projectName'. Reason: $e");
          }
          break;
        case '8':
          stdout.write("Enter project name to delete: ");
          String projectName = stdin.readLineSync()!;
          while (projectName.isEmpty) {
            stdout.write('Re-enter the project name: ');
            projectName = stdin.readLineSync()!;
          }

          try {
            projectManager.deleteProject(projectName);
            print("Project deleted successfully.");
          } catch (e) {
            print("Error: Unable to delete project '$projectName'. Reason: $e");
          }
          break;

        case '9':
          projectManager.viewAllProjects();
          break;

        case '10':
          stdout.write("Enter project name to search: ");
          String searchName = stdin.readLineSync()!;

          while (searchName.isEmpty) {
            stdout.write(
                'Project name cannot be empty. Re-enter the project name: ');
            searchName = stdin.readLineSync()!;
          }

          try {
            projectManager.searchProjectByName(searchName);
          } catch (e) {
            print("Error: Project '$searchName' not found.");
          }
          break;

        case '11':
          stdout.write("Enter project name to view completed tasks: ");
          String projectName = stdin.readLineSync()!;

          while (projectName.isEmpty) {
            stdout.write(' Re-enter the project name: ');
            projectName = stdin.readLineSync()!;
          }

          try {
            projectManager.viewCompletedTasks(projectName);
          } catch (e) {
            print(
                "Error: Unable to view completed tasks for project '$projectName'. Reason: $e");
          }
          break;

        case '12':
          stdout.write("Enter project name to view pending tasks: ");
          String projectName = stdin.readLineSync()!;

          while (projectName.isEmpty) {
            stdout.write('Re-Enter the Project Name:');
            projectName = stdin.readLineSync()!;
          }
          try {
            projectManager.viewPendingTasks(projectName);
          } catch (e) {
            print(
                "Error:Unable to view pending task for project '$projectName.Reason:$e ");
          }
          break;

        case '13':
          stdout.write("Enter project name: ");
          String projectName = stdin.readLineSync()!;

          while (projectName.isEmpty) {
            stdout.write('Re-enter the project name: ');
            projectName = stdin.readLineSync()!;
          }

          stdout.write("Enter task title to extend deadline: ");
          String taskTitle = stdin.readLineSync()!;

          while (taskTitle.isEmpty) {
            stdout.write(' Re-enter the task title: ');
            taskTitle = stdin.readLineSync()!;
          }

          DateTime? newDeadline;
          while (newDeadline == null) {
            stdout.write("Enter new task deadline (YYYY-MM-DD): ");
            String? input = stdin.readLineSync();
            if (input != null && input.isNotEmpty) {
              try {
                newDeadline = DateTime.parse(input);
              } catch (e) {
                print("Invalid date format. Please use YYYY-MM-DD.");
              }
            } else {
              print("Input cannot be empty. Please enter a valid date.");
            }
          }
          projectManager.extendTaskDeadline(
              projectName, taskTitle, newDeadline);
          print("Task deadline extended.");
          break;

        case '14':
          stdout.write("Enter project name to view details: ");
          String projectName = stdin.readLineSync()!;

          while (projectName.isEmpty) {
            stdout.write(
                'Project name cannot be empty. Re-enter the project name: ');
            projectName = stdin.readLineSync()!;
          }

          projectManager.viewProjectDetails(projectName);
          break;
          case '15':
           try {
            await projectManager.saveProjectsToApi();
            print("Projects saved successfully.");
          } catch (e) {
            print("Error: Unable to save projects. Reason: $e");
          }
          break;

        case '16':
          exit(0);



        default:
          print("Invalid option. Please try again.");
      }
    } catch (e) {
      print("An error occurred: $e. Please try again.");
    }
  }
}
