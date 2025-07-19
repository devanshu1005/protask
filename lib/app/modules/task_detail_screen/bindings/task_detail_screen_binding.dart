import 'package:get/get.dart';

import '../controllers/task_detail_screen_controller.dart';

class TaskDetailScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskDetailScreenController>(
      () => TaskDetailScreenController(),
    );
  }
}
