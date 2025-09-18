import 'package:get/get.dart';
import 'package:protask1/app/models/task.dart';
import 'package:protask1/app/routes/app_pages.dart';
import 'package:protask1/app/services/call_helper.dart';
import 'package:protask1/app/utils/widgets/dialogue_helper.dart';
import 'package:protask1/app/utils/widgets/loader_view.dart';

class TaskDetailScreenController extends GetxController {
  late TaskModel task;

  @override
  void onInit() {
    super.onInit();
    task = Get.arguments as TaskModel;
    // print(task.title);
  }

  // void toggleTaskCompletion() {
  //   task.isCompleted = !task.isCompleted;
  //   update();
  // }

  Future<void> deleteTask(String taskId, String taskTitle) async {
    LoaderView.customLogoLoader();

    try {
      final response = await CallHelper().delete('/task/delete/$taskId', data: {
        'title': taskTitle,
      });

      if (response != null && response['success'] == true) {
        Get.back(result: true);
      } else {
        DialogHelper.showError(response?['message'] ?? 'Failed to delete task');
      }
    } catch (e) {
      DialogHelper.showError('An error occurred while deleting the task');
    } finally {
      await LoaderView.hideLoading();
      Get.back(result: true);
    }
  }

  void editTask() {
    Get.toNamed(
      Routes.ADD_EDIT_TASK,
      arguments: {
        'task': task,
        'isEdit': true,
      },
    );
  }
}
