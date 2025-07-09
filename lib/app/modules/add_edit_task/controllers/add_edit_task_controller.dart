import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEditTaskController extends GetxController {
  // Text controllers for form fields
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  
  // Observable for selected priority
  final selectedPriority = 'medium'.obs;
  
  @override
  void onInit() {
    super.onInit();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
  }
  
  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
  
  /// Set the priority level
  void setPriority(String priority) {
    selectedPriority.value = priority;
  }
  
  /// Save the task
  void saveTask() {
    // Validate title is not empty
    if (titleController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter a task title',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    
    // Create task object (you can customize this based on your data model)
    final task = {
      'title': titleController.text.trim(),
      'description': descriptionController.text.trim(),
      'priority': selectedPriority.value,
      'createdAt': DateTime.now().toIso8601String(),
      'isCompleted': false,
    };
    
    // TODO: Add your task saving logic here
    // For example: await taskService.createTask(task);
    
    print('Task saved: $task');
    
    // Show success message
    Get.snackbar(
      'Success',
      'Task created successfully',
      snackPosition: SnackPosition.BOTTOM,
    );
    
    // Navigate back
    Get.back();
  }
  
  /// Clear all form fields
  void clearForm() {
    titleController.clear();
    descriptionController.clear();
    selectedPriority.value = 'medium';
  }
}