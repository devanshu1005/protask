import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protask1/app/themes/app_colors.dart';
import 'package:protask1/app/themes/app_fonts.dart';
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
                    // Greeting
                    Text(
                      'Good morning,',
                      style: AppFonts.bodyLarge.copyWith(
                        color: AppColors.textWhite.withOpacity(0.9),
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'John Doe',
                      style: AppFonts.heading2.copyWith(
                        color: AppColors.textWhite,
                        fontSize: 24,
                        fontWeight: AppFonts.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Stats Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem('12', 'Total'),
                        _buildStatItem('8', 'Completed'),
                        _buildStatItem('4', 'Pending'),
                      ],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Filter Tabs
              Row(
                children: [
                  Obx(() => _buildFilterTab('All', controller.selectedFilter.value == 'All')),
                  const SizedBox(width: 8),
                  Obx(() => _buildFilterTab('Pending', controller.selectedFilter.value == 'Pending')),
                  const SizedBox(width: 8),
                  Obx(() => _buildFilterTab('Completed', controller.selectedFilter.value == 'Completed')),
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
        onPressed: controller.addTask,
        backgroundColor: AppColors.primary,
        child: const Icon(
          Icons.add,
          color: AppColors.textWhite,
          size: 28,
        ),
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

  Widget _buildTaskItem(Map<String, dynamic> task) {
    final isCompleted = task['isCompleted'] as bool;
    final priority = task['priority'] as String;
    
    return Container(
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
            onTap: () => controller.toggleTask(task['id']),
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
                  task['title'],
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
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                      'Due: ${task['dueDate']}',
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
        ],
      ),
    );
  }
}