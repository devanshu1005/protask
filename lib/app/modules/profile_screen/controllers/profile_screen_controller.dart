import 'package:get/get.dart';

class ProfileScreenController extends GetxController {
  //TODO: Implement ProfileScreenController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  String getInitials(String? name) {
    if (name == null || name.trim().isEmpty) return "NA";
    final parts = name.trim().split(" ");
    if (parts.length == 1) {
      return parts[0][0].toUpperCase();
    } else {
      return (parts[0][0] + parts[1][0]).toUpperCase();
    }
  }

  void increment() => count.value++;
}
