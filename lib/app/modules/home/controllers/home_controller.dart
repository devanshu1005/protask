import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protask1/app/models/task.dart';
import 'package:protask1/app/services/call_helper.dart';
import 'package:protask1/app/utils/widgets/dialogue_helper.dart';
import 'package:protask1/app/utils/widgets/loader_view.dart';

class HomeController extends GetxController {
  final selectedFilter = 'All'.obs;
  final tasks = <TaskModel>[].obs;
  // final isLoading = false.obs;

  int get totalTasks => tasks.length;
  int get completedTasks => tasks.where((t) => t.isCompleted).length;
  int get pendingTasks => tasks.where((t) => !t.isCompleted).length;

  List<TaskModel> get filteredTasks {
    switch (selectedFilter.value) {
      case 'Pending':
        return tasks.where((t) => !t.isCompleted).toList();
      case 'Completed':
        return tasks.where((t) => t.isCompleted).toList();
      default:
        return tasks;
    }
  }

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchTasks();
    });
  }

  Future<void> fetchTasks() async {
    try {
      LoaderView.customLogoLoader();
      final response = await CallHelper().get('/task/get');

      if (response != null &&
          response['success'] == true &&
          response['data'] != null) {
        final List<dynamic> apiTasks = response['data'];
        tasks.assignAll(apiTasks.map((e) => TaskModel.fromJson(e)).toList());
      } else {
        DialogHelper.showError(response['message'] ?? 'Failed to load tasks');
      }
    } finally {
      LoaderView.hideLoading();
    }
  }

  void setFilter(String filter) => selectedFilter.value = filter;

  Future<void> toggleTask(String taskId) async {
    final index = tasks.indexWhere((t) => t.id == taskId);
    if (index == -1) return;

    final currentTask = tasks[index];
    final newCompletionStatus =
        currentTask.isCompleted ? "pending" : "completed";

    LoaderView.customLogoLoader();

    try {
      final response = await CallHelper().patch(
        '/task/update/$taskId',
        data: {'completion': newCompletionStatus},
      );

      if (response != null && response['success'] == true) {
        tasks[index].isCompleted = !currentTask.isCompleted;
        tasks.refresh();

        DialogHelper.showSuccess(
          tasks[index].isCompleted
              ? 'Task marked as completed!'
              : 'Task marked as pending!',
          title: 'Task Updated',
          backgroundColor:
              tasks[index].isCompleted ? Colors.green : Colors.orange,
        );
      } else {
        DialogHelper.showError(
          response['message'] ?? 'Failed to update task',
        );
      }
    } catch (e) {
      DialogHelper.showError('Something went wrong while updating task');
    } finally {
      LoaderView.hideLoading();
    }
  }

  Future<void> deleteTask(String taskId, String taskTitle) async {
    LoaderView.customLogoLoader();

    final response = await CallHelper().delete('/task/delete/$taskId', data: {
      'title': taskTitle,
    });

    LoaderView.hideLoading();

    if (response != null && response['success'] == true) {
      tasks.removeWhere((t) => t.id == taskId);
      DialogHelper.showSuccess(
        'Task has been removed successfully!',
        title: 'Task Deleted',
        backgroundColor: Colors.red,
      );
    } else {
      DialogHelper.showError(response['message'] ?? 'Failed to delete task');
    }
  }

  List<TaskModel> getTasksByPriority(String priority) {
    return tasks.where((t) => t.priority == priority).toList();
  }

  List<TaskModel> getOverdueTasks() {
    return tasks
        .where((t) => t.dueDateLabel == 'Yesterday' && !t.isCompleted)
        .toList();
  }

  List<TaskModel> getTodaysTasks() {
    return tasks.where((t) => t.dueDateLabel == 'Today').toList();
  }

  // void markAllAsCompleted() {
  //   for (var task in tasks) {
  //     task.isCompleted = true;
  //   }
  //   tasks.refresh();

  //   Get.snackbar(
  //     'All Tasks Completed',
  //     'Congratulations! All tasks have been marked as completed.',
  //     snackPosition: SnackPosition.BOTTOM,
  //     backgroundColor: Colors.green,
  //     colorText: Colors.white,
  //   );
  // }

  void clearCompletedTasks() {
    tasks.removeWhere((t) => t.isCompleted);
    DialogHelper.showSuccess(
      'All completed tasks have been removed.',
      title: 'Completed Tasks Cleared',
      backgroundColor: Colors.blue,
    );
  }
}
