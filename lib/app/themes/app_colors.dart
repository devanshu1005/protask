// ============================================================================
// AppColors.dart
// ============================================================================

import 'package:flutter/material.dart';

class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // ============================================================================
  // PRIMARY COLORS
  // ============================================================================
  
  /// Primary brand color - Indigo
  static const Color primary = Color(0xFF4F46E5);
  
  /// Secondary brand color - Purple
  static const Color secondary = Color(0xFF7C3AED);
  
  /// Primary gradient colors
  static const List<Color> primaryGradient = [
    Color(0xFF4F46E5),
    Color(0xFF7C3AED),
  ];
  
  /// Success gradient colors
  static const List<Color> successGradient = [
    Color(0xFF10B981),
    Color(0xFF059669),
  ];

  // ============================================================================
  // NEUTRAL COLORS
  // ============================================================================
  
  /// Pure white
  static const Color white = Color(0xFFFFFFFF);
  
  /// Pure black
  static const Color black = Color(0xFF000000);
  
  /// Main background color
  static const Color background = Color(0xFFF8FAFC);
  
  /// Card and surface color
  static const Color surface = Color(0xFFFFFFFF);
  
  /// Light gray for subtle backgrounds
  static const Color backgroundSecondary = Color(0xFFF1F5F9);

  // ============================================================================
  // TEXT COLORS
  // ============================================================================
  
  /// Primary text color - Dark slate
  static const Color textPrimary = Color(0xFF1E293B);
  
  /// Secondary text color - Medium gray
  static const Color textSecondary = Color(0xFF64748B);
  
  /// Muted text color - Light gray
  static const Color textMuted = Color(0xFF94A3B8);
  
  /// White text for dark backgrounds
  static const Color textWhite = Color(0xFFFFFFFF);
  
  /// Disabled text color
  static const Color textDisabled = Color(0xFFCBD5E1);

  // ============================================================================
  // BORDER COLORS
  // ============================================================================
  
  /// Primary border color
  static const Color border = Color(0xFFE5E7EB);
  
  /// Light border color
  static const Color borderLight = Color(0xFFF1F5F9);
  
  /// Focus border color
  static const Color borderFocus = Color(0xFF4F46E5);
  
  /// Error border color
  static const Color borderError = Color(0xFFDC2626);

  // ============================================================================
  // STATUS COLORS
  // ============================================================================
  
  /// Success color
  static const Color success = Color(0xFF10B981);
  
  /// Warning color
  static const Color warning = Color(0xFFD97706);
  
  /// Error color
  static const Color error = Color(0xFFDC2626);
  
  /// Info color
  static const Color info = Color(0xFF3B82F6);

  // ============================================================================
  // PRIORITY COLORS
  // ============================================================================
  
  /// High priority color
  static const Color priorityHigh = Color(0xFFDC2626);
  
  /// High priority background
  static const Color priorityHighBg = Color(0xFFFEE2E2);
  
  /// Medium priority color
  static const Color priorityMedium = Color(0xFFD97706);
  
  /// Medium priority background
  static const Color priorityMediumBg = Color(0xFFFEF3C7);
  
  /// Low priority color
  static const Color priorityLow = Color(0xFF16A34A);
  
  /// Low priority background
  static const Color priorityLowBg = Color(0xFFDCFCE7);

  // ============================================================================
  // COMPONENT COLORS
  // ============================================================================
  
  /// Floating Action Button color
  static const Color fab = Color(0xFF4F46E5);
  
  /// Status bar color
  static const Color statusBar = Color(0xFF1E293B);
  
  /// Divider color
  static const Color divider = Color(0xFFE5E7EB);
  
  /// Shimmer base color
  static const Color shimmerBase = Color(0xFFF1F5F9);
  
  /// Shimmer highlight color
  static const Color shimmerHighlight = Color(0xFFFFFFFF);
  
  /// Overlay color for modals
  static const Color overlay = Color(0x80000000);

  // ============================================================================
  // SHADOW COLORS
  // ============================================================================
  
  /// Light shadow color
  static const Color shadowLight = Color(0x0A000000);
  
  /// Medium shadow color
  static const Color shadowMedium = Color(0x1A000000);
  
  /// Heavy shadow color
  static const Color shadowHeavy = Color(0x26000000);

  // ============================================================================
  // GRADIENT DEFINITIONS
  // ============================================================================
  
  /// Primary linear gradient
  static const LinearGradient primaryLinearGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: primaryGradient,
  );
  
  /// Success linear gradient
  static const LinearGradient successLinearGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: successGradient,
  );
  
  /// Subtle background gradient
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFF8FAFC),
      Color(0xFFF1F5F9),
    ],
  );

  // ============================================================================
  // UTILITY METHODS
  // ============================================================================
  
  /// Get priority color based on priority level
  static Color getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return priorityHigh;
      case 'medium':
        return priorityMedium;
      case 'low':
        return priorityLow;
      default:
        return priorityMedium;
    }
  }
  
  /// Get priority background color based on priority level
  static Color getPriorityBackgroundColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return priorityHighBg;
      case 'medium':
        return priorityMediumBg;
      case 'low':
        return priorityLowBg;
      default:
        return priorityMediumBg;
    }
  }
  
  /// Create a color with opacity
  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }
  
  /// Create a lighter version of a color
  static Color lighter(Color color, [double amount = 0.1]) {
    return Color.lerp(color, white, amount) ?? color;
  }
  
  /// Create a darker version of a color
  static Color darker(Color color, [double amount = 0.1]) {
    return Color.lerp(color, black, amount) ?? color;
  }
}