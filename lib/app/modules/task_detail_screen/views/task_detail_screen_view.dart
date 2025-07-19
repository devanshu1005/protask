import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protask1/app/themes/app_colors.dart';
import 'package:protask1/app/themes/app_fonts.dart';
import '../controllers/task_detail_screen_controller.dart';

class TaskDetailScreenView extends GetView<TaskDetailScreenController> {
  const TaskDetailScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTaskHeader(),
            const SizedBox(height: 24),
            _buildTaskInfo(),
            const SizedBox(height: 24),
            _buildDescription(),
            const SizedBox(height: 32),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        color: AppColors.textPrimary,
        onPressed: () => Get.back(),
      ),
      title: Text(
        'Task Details',
        style: AppFonts.appBarTitle.copyWith(
          color: AppColors.textPrimary,
        ),
      ),
      centerTitle: true,
      // actions: [
      //   IconButton(
      //     icon: const Icon(Icons.more_vert),
      //     color: AppColors.textPrimary,
      //     onPressed: () {
      //       // Handle more options
      //     },
      //   ),
      // ],
    );
  }

  Widget _buildTaskHeader() {
    return GetBuilder<TaskDetailScreenController>(
      builder: (controller) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
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
              Row(
                children: [
                  // Completion status checkbox
                  // GestureDetector(
                  //   onTap: () {
                  //     controller.toggleTaskCompletion();
                  //   },
                  //   child: Container(
                  //     width: 28,
                  //     height: 28,
                  //     decoration: BoxDecoration(
                  //       color: controller.task.isCompleted
                  //           ? AppColors.success
                  //           : AppColors.surface,
                  //       border: Border.all(
                  //         color: controller.task.isCompleted
                  //             ? AppColors.success
                  //             : AppColors.border,
                  //         width: 2,
                  //       ),
                  //       borderRadius: BorderRadius.circular(14),
                  //     ),
                  //     child: controller.task.isCompleted
                  //         ? const Icon(
                  //             Icons.check,
                  //             color: AppColors.textWhite,
                  //             size: 18,
                  //           )
                  //         : null,
                  //   ),
                  // ),
                  // const SizedBox(width: 16),
                  // Task title
                  Expanded(
                    child: Text(
                      controller.task.title,
                      style: AppFonts.heading3.copyWith(
                        color: controller.task.isCompleted
                            ? AppColors.textMuted
                            : AppColors.textPrimary,
                        decoration: controller.task.isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Priority and status row
              Wrap(
                spacing: 12,
                runSpacing: 8,
                children: [
                  // Priority badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.getPriorityBackgroundColor(
                          controller.task.priority),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: AppColors.getPriorityColor(
                                controller.task.priority),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${controller.task.priority} Priority',
                          style: AppFonts.labelSmall.copyWith(
                            color: AppColors.getPriorityColor(
                                controller.task.priority),
                            fontWeight: AppFonts.semiBold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Completion status badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: controller.task.isCompleted
                          ? AppColors.success.withOpacity(0.1)
                          : AppColors.warning.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      controller.task.isCompleted ? 'Completed' : 'In Progress',
                      style: AppFonts.labelSmall.copyWith(
                        color: controller.task.isCompleted
                            ? AppColors.success
                            : AppColors.warning,
                        fontWeight: AppFonts.semiBold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTaskInfo() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
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
            'Task Information',
            style: AppFonts.heading4.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 20),
          _buildInfoRow(
            Icons.calendar_today_outlined,
            'Due Date',
            controller.task.dueDateLabel,
            _getDueDateColor(),
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            Icons.access_time_outlined,
            'Created',
            _formatDate(controller.task.createdAt),
            AppColors.textSecondary,
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            Icons.update_outlined,
            'Last Updated',
            _formatDate(controller.task.updatedAt),
            AppColors.textSecondary,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
      IconData icon, String label, String value, Color valueColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.backgroundSecondary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 18,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppFonts.labelSmall.copyWith(
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: AppFonts.bodyMedium.copyWith(
                  color: valueColor,
                  fontWeight: AppFonts.medium,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
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
          Row(
            children: [
              Icon(
                Icons.description_outlined,
                color: AppColors.textSecondary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Description',
                style: AppFonts.heading4.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            controller.task.description.isNotEmpty
                ? controller.task.description
                : 'No description provided for this task.',
            style: AppFonts.bodyMedium.copyWith(
              color: controller.task.description.isNotEmpty
                  ? AppColors.textPrimary
                  : AppColors.textMuted,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        // Edit button
        SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton.icon(
            onPressed: () {
             controller.editTask();
            },
            icon: const Icon(
              Icons.edit_outlined,
              color: AppColors.textWhite,
              size: 20,
            ),
            label: Text(
              'Edit Task',
              style: AppFonts.button.copyWith(
                color: AppColors.textWhite,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Delete button
        SizedBox(
          width: double.infinity,
          height: 54,
          child: OutlinedButton.icon(
            onPressed: () {
              controller.deleteTask(controller.task.id, controller.task.title);
            },
            icon: const Icon(
              Icons.delete_outline,
              color: AppColors.error,
              size: 20,
            ),
            label: Text(
              'Delete Task',
              style: AppFonts.button.copyWith(
                color: AppColors.error,
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(
                color: AppColors.error,
                width: 1.5,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Color _getDueDateColor() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dueDate = DateTime(
      controller.task.dueDate.year,
      controller.task.dueDate.month,
      controller.task.dueDate.day,
    );
    final diff = dueDate.difference(today).inDays;

    if (diff < 0) return AppColors.error; // Overdue
    if (diff == 0) return AppColors.warning; // Due today
    if (diff <= 3) return AppColors.warning; // Due soon
    return AppColors.textSecondary; // Normal
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date).inDays;

    if (diff == 0) return 'Today';
    if (diff == 1) return 'Yesterday';
    if (diff < 7) return '$diff days ago';

    return '${date.day}/${date.month}/${date.year}';
  }

  // void _showDeleteConfirmation() {
  //   Get.dialog(
  //     AlertDialog(
  //       backgroundColor: AppColors.surface,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(16),
  //       ),
  //       title: Text(
  //         'Delete Task',
  //         style: AppFonts.heading4.copyWith(
  //           color: AppColors.textPrimary,
  //         ),
  //       ),
  //       content: Text(
  //         'Are you sure you want to delete this task? This action cannot be undone.',
  //         style: AppFonts.bodyMedium.copyWith(
  //           color: AppColors.textSecondary,
  //         ),
  //       ),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Get.back(),
  //           child: Text(
  //             'Cancel',
  //             style: AppFonts.button.copyWith(
  //               color: AppColors.textSecondary,
  //             ),
  //           ),
  //         ),
  //         ElevatedButton(
  //           onPressed: () {
  //             controller.deleteTask(controller.task.id, controller.task.title);
  //           },
  //           style: ElevatedButton.styleFrom(
  //             backgroundColor: AppColors.error,
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(8),
  //             ),
  //           ),
  //           child: Text(
  //             'Delete',
  //             style: AppFonts.button.copyWith(
  //               color: AppColors.textWhite,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
