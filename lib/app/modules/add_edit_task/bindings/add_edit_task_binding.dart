import 'package:get/get.dart';

import '../controllers/add_edit_task_controller.dart';

class AddEditTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddEditTaskController>(
      () => AddEditTaskController(),
    );
  }
}
