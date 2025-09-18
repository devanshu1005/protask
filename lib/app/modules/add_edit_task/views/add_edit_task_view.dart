import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protask1/app/themes/app_colors.dart';
import 'package:protask1/app/themes/app_fonts.dart';
import '../controllers/add_edit_task_controller.dart';

class AddEditTaskView extends GetView<AddEditTaskController> {
  const AddEditTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textWhite),
          onPressed: () => Get.back(),
        ),
        title: Text(
          controller.isEdit
              ? controller.task?.title ?? 'Edit Task'
              : 'New Task',
          style: AppFonts.appBarTitle.copyWith(color: AppColors.textWhite),
        ),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: controller.saveTask,
            child: Text(
              'Save',
              style: AppFonts.button.copyWith(color: AppColors.textWhite),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: AppColors.background,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadowLight,
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Task Details',
                        style: AppFonts.heading4
                            .copyWith(color: AppColors.textPrimary),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Title',
                        style: AppFonts.formLabel
                            .copyWith(color: AppColors.textPrimary),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: controller.titleController,
                        style: AppFonts.formField
                            .copyWith(color: AppColors.textPrimary),
                        decoration: InputDecoration(
                          hintText: 'Enter task title',
                          hintStyle: AppFonts.formField
                              .copyWith(color: AppColors.textMuted),
                          filled: true,
                          fillColor: AppColors.backgroundSecondary,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: AppColors.border),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: AppColors.border),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: AppColors.borderFocus),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Description',
                        style: AppFonts.formLabel
                            .copyWith(color: AppColors.textPrimary),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: controller.descriptionController,
                        maxLines: 4,
                        style: AppFonts.formField
                            .copyWith(color: AppColors.textPrimary),
                        decoration: InputDecoration(
                          hintText: 'Enter task description\n(optional)',
                          hintStyle: AppFonts.formField
                              .copyWith(color: AppColors.textMuted),
                          filled: true,
                          fillColor: AppColors.backgroundSecondary,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: AppColors.border),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: AppColors.border),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: AppColors.borderFocus),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadowLight,
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Due Date',
                        style: AppFonts.heading4
                            .copyWith(color: AppColors.textPrimary),
                      ),
                      const SizedBox(height: 16),
                      Obx(() {
                        final selected = controller.selectedDate.value;
                        final displayText = selected != null
                            ? '${selected.day}/${selected.month}/${selected.year}'
                            : 'Select due date';

                        return GestureDetector(
                          onTap: () async {
                            final pickedDate = await showDatePicker(
                              context: Get.context!,
                              initialDate: selected ?? DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2100),
                              helpText: 'Select Due Date',
                            );
                            if (pickedDate != null) {
                              controller.setDueDate(pickedDate);
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                vertical: 14, horizontal: 16),
                            decoration: BoxDecoration(
                              color: AppColors.backgroundSecondary,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  displayText,
                                  style: AppFonts.formField.copyWith(
                                    color: selected != null
                                        ? AppColors.textPrimary
                                        : AppColors.textMuted,
                                  ),
                                ),
                                const Icon(Icons.calendar_today_rounded,
                                    size: 20),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadowLight,
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Priority',
                        style: AppFonts.heading4
                            .copyWith(color: AppColors.textPrimary),
                      ),
                      const SizedBox(height: 16),
                      Obx(() => Row(
                            children: [
                              _buildPriorityButton('Low', 'low'),
                              const SizedBox(width: 12),
                              _buildPriorityButton('Medium', 'medium'),
                              const SizedBox(width: 12),
                              _buildPriorityButton('High', 'high'),
                            ],
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPriorityButton(String label, String priority) {
    final isSelected = controller.selectedPriority.value == priority;

    return Expanded(
      child: GestureDetector(
        onTap: () => controller.setPriority(priority),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color:
                isSelected ? AppColors.primary : AppColors.backgroundSecondary,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.border,
              width: 1.5,
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: AppFonts.labelMedium.copyWith(
              color: isSelected ? AppColors.textWhite : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
