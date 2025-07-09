import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController {
  // Observable variables
  final selectedFilter = 'All'.obs;
  final tasks = <Map<String, dynamic>>[].obs;
  
  // Getters for statistics
  int get totalTasks => tasks.length;
  int get completedTasks => tasks.where((task) => task['isCompleted'] == true).length;
  int get pendingTasks => tasks.where((task) => task['isCompleted'] == false).length;
  
  // Filtered tasks based on selected filter
  List<Map<String, dynamic>> get filteredTasks {
    switch (selectedFilter.value) {
      case 'Pending':
        return tasks.where((task) => task['isCompleted'] == false).toList();
      case 'Completed':
        return tasks.where((task) => task['isCompleted'] == true).toList();
      default:
        return tasks.toList();
    }
  }

  @override
  void onInit() {
    super.onInit();
    _loadSampleTasks();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  /// Load sample tasks that match the screenshot
  void _loadSampleTasks() {
    tasks.addAll([
      {
        'id': 1,
        'title': 'Design login screen',
        'priority': 'High',
        'dueDate': 'Today',
        'isCompleted': true,
      },
      {
        'id': 2,
        'title': 'Implement API integration',
        'priority': 'Medium',
        'dueDate': 'Tomorrow',
        'isCompleted': false,
      },
      {
        'id': 3,
        'title': 'Write documentation',
        'priority': 'Low',
        'dueDate': 'Next week',
        'isCompleted': false,
      },
      {
        'id': 4,
        'title': 'Setup project structure',
        'priority': 'High',
        'dueDate': 'Yesterday',
        'isCompleted': true,
      },
      {
        'id': 5,
        'title': 'Create user authentication',
        'priority': 'High',
        'dueDate': 'Today',
        'isCompleted': true,
      },
      {
        'id': 6,
        'title': 'Design home screen',
        'priority': 'Medium',
        'dueDate': 'Tomorrow',
        'isCompleted': true,
      },
      {
        'id': 7,
        'title': 'Implement task management',
        'priority': 'Medium',
        'dueDate': 'This week',
        'isCompleted': false,
      },
      {
        'id': 8,
        'title': 'Add search functionality',
        'priority': 'Low',
        'dueDate': 'Next week',
        'isCompleted': false,
      },
      {
        'id': 9,
        'title': 'Setup database',
        'priority': 'High',
        'dueDate': 'Yesterday',
        'isCompleted': true,
      },
      {
        'id': 10,
        'title': 'Create splash screen',
        'priority': 'Low',
        'dueDate': 'Today',
        'isCompleted': true,
      },
      {
        'id': 11,
        'title': 'Implement push notifications',
        'priority': 'Medium',
        'dueDate': 'Next week',
        'isCompleted': false,
      },
      {
        'id': 12,
        'title': 'Add dark mode support',
        'priority': 'Low',
        'dueDate': 'Next month',
        'isCompleted': false,
      },
    ]);
  }

  /// Set filter for tasks
  void setFilter(String filter) {
    selectedFilter.value = filter;
  }

  /// Toggle task completion status
  void toggleTask(int taskId) {
    final taskIndex = tasks.indexWhere((task) => task['id'] == taskId);
    if (taskIndex != -1) {
      tasks[taskIndex]['isCompleted'] = !tasks[taskIndex]['isCompleted'];
      tasks.refresh(); // Trigger UI update
      
      // Show snackbar feedback
      final task = tasks[taskIndex];
      Get.snackbar(
        'Task Updated',
        task['isCompleted'] 
            ? 'Task marked as completed!' 
            : 'Task marked as pending!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: task['isCompleted'] ? Colors.green : Colors.orange,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    }
  }

  /// Add new task
  void addTask() {
    // For demo purposes, show a simple dialog
    Get.dialog(
      AlertDialog(
        title: const Text('Add New Task'),
        content: const Text('Task creation form will be implemented here.'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Add a sample task
              final newTask = {
                'id': tasks.length + 1,
                'title': 'New Task ${tasks.length + 1}',
                'priority': 'Medium',
                'dueDate': 'Today',
                'isCompleted': false,
              };
              
              tasks.add(newTask);
              Get.back();
              
              Get.snackbar(
                'Success',
                'New task added successfully!',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  /// Delete task
  void deleteTask(int taskId) {
    tasks.removeWhere((task) => task['id'] == taskId);
    Get.snackbar(
      'Task Deleted',
      'Task has been removed successfully!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  /// Get tasks by priority
  List<Map<String, dynamic>> getTasksByPriority(String priority) {
    return tasks.where((task) => task['priority'] == priority).toList();
  }

  /// Get overdue tasks
  List<Map<String, dynamic>> getOverdueTasks() {
    return tasks.where((task) => 
      task['dueDate'] == 'Yesterday' && 
      task['isCompleted'] == false
    ).toList();
  }

  /// Get today's tasks
  List<Map<String, dynamic>> getTodaysTasks() {
    return tasks.where((task) => task['dueDate'] == 'Today').toList();
  }

  /// Mark all tasks as completed
  void markAllAsCompleted() {
    for (var task in tasks) {
      task['isCompleted'] = true;
    }
    tasks.refresh();
    
    Get.snackbar(
      'All Tasks Completed',
      'Congratulations! All tasks have been marked as completed.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  /// Clear completed tasks
  void clearCompletedTasks() {
    tasks.removeWhere((task) => task['isCompleted'] == true);
    Get.snackbar(
      'Completed Tasks Cleared',
      'All completed tasks have been removed.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );
  }
}