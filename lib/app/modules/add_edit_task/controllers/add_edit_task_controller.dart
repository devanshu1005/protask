import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:protask1/app/models/task.dart';
import 'package:protask1/app/routes/app_pages.dart';
import 'package:protask1/app/services/call_helper.dart';
import 'package:protask1/app/utils/widgets/dialogue_helper.dart';
import 'package:protask1/app/utils/widgets/loader_view.dart';

class AddEditTaskController extends GetxController {
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;

  final selectedPriority = 'medium'.obs;
  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  TaskModel? task;
  bool isEdit = false;

  @override
  void onInit() {
    super.onInit();

    // Initialize controllers
    titleController = TextEditingController();
    descriptionController = TextEditingController();

    // Read arguments if passed
    if (Get.arguments != null && Get.arguments is Map) {
      final args = Get.arguments as Map;
      task = args['task'] as TaskModel?;
      isEdit = args['isEdit'] ?? false;

      if (task != null) {
        titleController.text = task!.title;
        descriptionController.text = task!.description ?? '';
        selectedPriority.value = task!.priority.toLowerCase();
        selectedDate.value = task!.dueDate;
      }
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  void setPriority(String priority) {
    selectedPriority.value = priority;
  }

  void setDueDate(DateTime? date) {
    selectedDate.value = date;
  }

  Future<void> saveTask() async {
    if (titleController.text.trim().isEmpty) {
      DialogHelper.showError('Please enter a task title');
      return;
    }

    if (selectedDate.value == null) {
      DialogHelper.showError('Please select a due date');
      return;
    }

    final taskData = {
      "title": titleController.text.trim(),
      "description": descriptionController.text.trim(),
      "priority": selectedPriority.value,
      "completion": task?.isCompleted == true ? "completed" : "pending",
      "dueDate": DateFormat('yyyy-MM-dd').format(selectedDate.value!),
    };

    LoaderView.customLogoLoader();

    try {
      final response = isEdit
          ? await CallHelper().patch('/task/update/${task!.id}', data: taskData)
          : await CallHelper().post('/task/create', data: taskData);

      if (response != null && response['success'] == true) {
        Get.back(result: true); // Success result
      } else {
        DialogHelper.showError(response?['message'] ?? 'Failed to save task');
      }
    } catch (e) {
      DialogHelper.showError('Something went wrong. Please try again.');
    } finally {
      await LoaderView.hideLoading(); // ✅ Always hide loader
      if (isEdit) {
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.back(result: true);
      }
    }
  }

  void clearForm() {
    titleController.clear();
    descriptionController.clear();
    selectedPriority.value = 'medium';
    selectedDate.value = null;
  }
}
