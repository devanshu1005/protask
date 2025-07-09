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
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textWhite),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'New Task',
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
      body: Container(
        color: AppColors.background,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Task Details Section
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
                      style: AppFonts.heading4.copyWith(color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 20),
                    
                    // Title Field
                    Text(
                      'Title',
                      style: AppFonts.formLabel.copyWith(color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: controller.titleController,
                      style: AppFonts.formField.copyWith(color: AppColors.textPrimary),
                      decoration: InputDecoration(
                        hintText: 'Enter task title',
                        hintStyle: AppFonts.formField.copyWith(color: AppColors.textMuted),
                        filled: true,
                        fillColor: AppColors.backgroundSecondary,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: AppColors.border),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: AppColors.border),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: AppColors.borderFocus),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Description Field
                    Text(
                      'Description',
                      style: AppFonts.formLabel.copyWith(color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: controller.descriptionController,
                      maxLines: 4,
                      style: AppFonts.formField.copyWith(color: AppColors.textPrimary),
                      decoration: InputDecoration(
                        hintText: 'Enter task description\n(optional)',
                        hintStyle: AppFonts.formField.copyWith(color: AppColors.textMuted),
                        filled: true,
                        fillColor: AppColors.backgroundSecondary,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: AppColors.border),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: AppColors.border),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: AppColors.borderFocus),
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
              
              // Priority Section
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
                      style: AppFonts.heading4.copyWith(color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 16),
                    
                    // Priority Buttons
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
            color: isSelected ? AppColors.primary : AppColors.backgroundSecondary,
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