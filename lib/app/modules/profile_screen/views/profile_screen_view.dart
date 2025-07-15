import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protask1/app/utils/app_globals.dart';
import '../controllers/profile_screen_controller.dart';

class ProfileScreenView extends GetView<ProfileScreenController> {
  const ProfileScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Top gradient section with profile info
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF4F46E5), // AppColors.primary
                  Color(0xFF7C3AED), // AppColors.secondary
                ],
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: Column(
                  children: [
                    // Profile avatar
                    Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          'JD',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF4F46E5),
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Name
                    const Text(
                      'John Doe',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Email
                    const Text(
                      'john@example.com',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontFamily: 'Inter',
                        // opacity: 0.9,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Menu items section
          Expanded(
            child: Container(
              color: const Color(0xFFF8FAFC), // AppColors.background
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  _buildMenuItem(
                    icon: Icons.person_outline,
                    iconColor: const Color(0xFF3B82F6), // AppColors.info
                    title: 'Edit Profile',
                    onTap: () {
                      // Handle edit profile
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.notifications_outlined,
                    iconColor: const Color(0xFFD97706), // AppColors.warning
                    title: 'Notifications',
                    onTap: () {
                      // Handle notifications
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.dark_mode_outlined,
                    iconColor: const Color(0xFFD97706), // AppColors.warning
                    title: 'Dark Mode',
                    onTap: () {
                      // Handle dark mode
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.lock_outline,
                    iconColor:
                        const Color(0xFF64748B), // AppColors.textSecondary
                    title: 'Privacy',
                    onTap: () {
                      // Handle privacy
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildMenuItem(
                    icon: Icons.logout,
                    iconColor: const Color(0xFFDC2626), // AppColors.error
                    title: 'Logout',
                    onTap: () {
                      // Handle logout
                      AppGlobals.instance.logout();
                    },
                    showArrow: false,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required VoidCallback onTap,
    bool showArrow = true,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: iconColor,
                  size: 24,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1E293B), // AppColors.textPrimary
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
                if (showArrow)
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0xFF94A3B8), // AppColors.textMuted
                    size: 16,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
