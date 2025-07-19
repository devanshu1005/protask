import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:protask1/app/services/call_helper.dart';
import 'package:protask1/app/utils/widgets/dialogue_helper.dart';
import 'package:protask1/app/utils/widgets/loader_view.dart';

class AddEditTaskController extends GetxController {
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;

  final selectedPriority = 'medium'.obs;
  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

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
      "completion": "pending",
      "dueDate": DateFormat('yyyy-MM-dd').format(selectedDate.value!),
    };

    LoaderView.customLogoLoader();

    try {
      final response = await CallHelper().post('/task/create', data: taskData);

      if (response != null && response['success'] == true) {
        Get.back(result: true); // ✅ Return result to caller
      } else {
        DialogHelper.showError(response?['message'] ?? 'Failed to create task');
      }
    } catch (e) {
      DialogHelper.showError('Something went wrong. Please try again.');
    } finally {
      await LoaderView.hideLoading(); // ✅ Always hide loader
      Get.back(result: true);
    }
  }

  void clearForm() {
    titleController.clear();
    descriptionController.clear();
    selectedPriority.value = 'medium';
    selectedDate.value = null;
  }
}
