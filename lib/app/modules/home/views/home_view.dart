import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protask1/app/models/task.dart';
import 'package:protask1/app/routes/app_pages.dart';
import 'package:protask1/app/themes/app_colors.dart';
import 'package:protask1/app/themes/app_fonts.dart';
import 'package:protask1/app/utils/app_globals.dart';
import 'package:protask1/app/utils/widgets/dialogue_helper.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with greeting and stats
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryLinearGradient,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Row for greeting and avatar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Greeting
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Good morning,',
                              style: AppFonts.bodyLarge.copyWith(
                                color: AppColors.textWhite.withOpacity(0.9),
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              AppGlobals.instance.name ?? 'User',
                              style: AppFonts.heading2.copyWith(
                                color: AppColors.textWhite,
                                fontSize: 24,
                                fontWeight: AppFonts.bold,
                              ),
                            ),
                          ],
                        ),

                        // Profile Avatar
                        Row(
                          children: [
                            // Reload Button
                            IconButton(
                              icon: const Icon(Icons.refresh,
                                  color: Colors.white),
                              onPressed: () {
                                controller.fetchTasks(); // Manual refresh
                              },
                            ),
                            const SizedBox(width: 4),

                            // Profile Avatar
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.PROFILE_SCREEN);
                              },
                              child: CircleAvatar(
                                radius: 24,
                                backgroundColor: Colors.white24,
                                child: Text(
                                  'JD',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Stats Row
                    Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildStatItem('${controller.totalTasks}', 'Total'),
                            _buildStatItem(
                                '${controller.completedTasks}', 'Completed'),
                            _buildStatItem(
                                '${controller.pendingTasks}', 'Pending'),
                          ],
                        )),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Filter Tabs
              Row(
                children: [
                  Obx(() => _buildFilterTab(
                      'All', controller.selectedFilter.value == 'All')),
                  const SizedBox(width: 8),
                  Obx(() => _buildFilterTab(
                      'Pending', controller.selectedFilter.value == 'Pending')),
                  const SizedBox(width: 8),
                  Obx(() => _buildFilterTab('Completed',
                      controller.selectedFilter.value == 'Completed')),
                ],
              ),

              const SizedBox(height: 20),

              // Tasks List
              Expanded(
                child: Obx(() => ListView.builder(
                      itemCount: controller.filteredTasks.length,
                      itemBuilder: (context, index) {
                        final task = controller.filteredTasks[index];
                        return _buildTaskItem(task);
                      },
                    )),
              ),
            ],
          ),
        ),
      ),

      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.ADD_EDIT_TASK)?.then((result) {
            if (result == true) {
              controller.fetchTasks();
              DialogHelper.showSuccess('Task created successfully');
            }
          });
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: AppColors.textWhite, size: 28),
      ),
    );
  }

  Widget _buildStatItem(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: AppFonts.heading1.copyWith(
            color: AppColors.textWhite,
            fontSize: 32,
            fontWeight: AppFonts.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppFonts.bodySmall.copyWith(
            color: AppColors.textWhite.withOpacity(0.8),
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterTab(String label, bool isSelected) {
    return GestureDetector(
      onTap: () => controller.setFilter(label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: AppFonts.labelMedium.copyWith(
            color: isSelected ? AppColors.textWhite : AppColors.textSecondary,
            fontWeight: isSelected ? AppFonts.medium : AppFonts.regular,
          ),
        ),
      ),
    );
  }

  Widget _buildTaskItem(TaskModel task) {
    final isCompleted = task.isCompleted;
    final priority = task.priority;

    return InkWell(
      onTap: () {
        Get.toNamed(Routes.TASK_DETAIL_SCREEN, arguments: task)?.then((result) {
          if (result == true) {
            controller.fetchTasks();
            DialogHelper.showSuccess(
              'Task has been removed successfully!',
              title: 'Task Deleted',
              backgroundColor: Colors.red,
            );
          }
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.borderLight,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Checkbox
            GestureDetector(
              onTap: () => controller.toggleTask(task.id),
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: isCompleted ? AppColors.success : AppColors.surface,
                  border: Border.all(
                    color: isCompleted ? AppColors.success : AppColors.border,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: isCompleted
                    ? const Icon(
                        Icons.check,
                        color: AppColors.textWhite,
                        size: 16,
                      )
                    : null,
              ),
            ),

            const SizedBox(width: 16),

            // Task Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Task Title
                  Text(
                    task.title,
                    style: AppFonts.bodyMedium.copyWith(
                      color: isCompleted
                          ? AppColors.textMuted
                          : AppColors.textPrimary,
                      decoration: isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      fontWeight: AppFonts.medium,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Priority and Due Date
                  Row(
                    children: [
                      // Priority Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.getPriorityBackgroundColor(priority),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          priority,
                          style: AppFonts.labelSmall.copyWith(
                            color: AppColors.getPriorityColor(priority),
                            fontSize: 12,
                            fontWeight: AppFonts.medium,
                          ),
                        ),
                      ),

                      const SizedBox(width: 16),

                      // Due Date
                      Text(
                        'Due: ${task.dueDateLabel}',
                        style: AppFonts.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 16),

            // Delete Icon
            GestureDetector(
              onTap: () => controller.deleteTask(task.id, task.title),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
