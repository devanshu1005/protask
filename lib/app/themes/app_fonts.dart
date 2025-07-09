// ============================================================================
// AppFonts.dart
// ============================================================================

import 'package:flutter/material.dart';

class AppFonts {
  // Private constructor to prevent instantiation
  AppFonts._();

  // ============================================================================
  // FONT FAMILY
  // ============================================================================
  
  /// Primary font family - System default
  static const String primaryFontFamily = 'Inter';
  
  /// Secondary font family - Fallback
  static const String secondaryFontFamily = 'Roboto';

  // ============================================================================
  // FONT WEIGHTS
  // ============================================================================
  
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;

  // ============================================================================
  // FONT SIZES
  // ============================================================================
  
  static const double fontSizeXS = 12.0;
  static const double fontSizeS = 14.0;
  static const double fontSizeM = 16.0;
  static const double fontSizeL = 18.0;
  static const double fontSizeXL = 20.0;
  static const double fontSizeXXL = 24.0;
  static const double fontSizeXXXL = 32.0;

  // ============================================================================
  // HEADINGS
  // ============================================================================
  
  /// Large heading (32px, Bold)
  static const TextStyle heading1 = TextStyle(
    fontSize: fontSizeXXXL,
    fontWeight: bold,
    fontFamily: primaryFontFamily,
    height: 1.2,
    letterSpacing: -0.5,
  );
  
  /// Medium heading (24px, Bold)
  static const TextStyle heading2 = TextStyle(
    fontSize: fontSizeXXL,
    fontWeight: bold,
    fontFamily: primaryFontFamily,
    height: 1.3,
    letterSpacing: -0.3,
  );
  
  /// Small heading (20px, SemiBold)
  static const TextStyle heading3 = TextStyle(
    fontSize: fontSizeXL,
    fontWeight: semiBold,
    fontFamily: primaryFontFamily,
    height: 1.4,
    letterSpacing: -0.2,
  );
  
  /// Subheading (18px, SemiBold)
  static const TextStyle heading4 = TextStyle(
    fontSize: fontSizeL,
    fontWeight: semiBold,
    fontFamily: primaryFontFamily,
    height: 1.4,
    letterSpacing: -0.1,
  );

  // ============================================================================
  // BODY TEXT
  // ============================================================================
  
  /// Large body text (18px, Regular)
  static const TextStyle bodyLarge = TextStyle(
    fontSize: fontSizeL,
    fontWeight: regular,
    fontFamily: primaryFontFamily,
    height: 1.5,
    letterSpacing: 0,
  );
  
  /// Medium body text (16px, Regular)
  static const TextStyle bodyMedium = TextStyle(
    fontSize: fontSizeM,
    fontWeight: regular,
    fontFamily: primaryFontFamily,
    height: 1.5,
    letterSpacing: 0,
  );
  
  /// Small body text (14px, Regular)
  static const TextStyle bodySmall = TextStyle(
    fontSize: fontSizeS,
    fontWeight: regular,
    fontFamily: primaryFontFamily,
    height: 1.4,
    letterSpacing: 0,
  );

  // ============================================================================
  // LABELS & BUTTONS
  // ============================================================================
  
  /// Large label (16px, Medium)
  static const TextStyle labelLarge = TextStyle(
    fontSize: fontSizeM,
    fontWeight: medium,
    fontFamily: primaryFontFamily,
    height: 1.4,
    letterSpacing: 0.1,
  );
  
  /// Medium label (14px, Medium)
  static const TextStyle labelMedium = TextStyle(
    fontSize: fontSizeS,
    fontWeight: medium,
    fontFamily: primaryFontFamily,
    height: 1.4,
    letterSpacing: 0.1,
  );
  
  /// Small label (12px, Medium)
  static const TextStyle labelSmall = TextStyle(
    fontSize: fontSizeXS,
    fontWeight: medium,
    fontFamily: primaryFontFamily,
    height: 1.3,
    letterSpacing: 0.2,
  );
  
  /// Button text (16px, SemiBold)
  static const TextStyle button = TextStyle(
    fontSize: fontSizeM,
    fontWeight: semiBold,
    fontFamily: primaryFontFamily,
    height: 1.2,
    letterSpacing: 0.1,
  );

  // ============================================================================
  // CAPTIONS & OVERLINES
  // ============================================================================
  
  /// Caption text (12px, Regular)
  static const TextStyle caption = TextStyle(
    fontSize: fontSizeXS,
    fontWeight: regular,
    fontFamily: primaryFontFamily,
    height: 1.3,
    letterSpacing: 0.2,
  );
  
  /// Overline text (12px, SemiBold, Uppercase)
  static const TextStyle overline = TextStyle(
    fontSize: fontSizeXS,
    fontWeight: semiBold,
    fontFamily: primaryFontFamily,
    height: 1.3,
    letterSpacing: 1.0,
  );

  // ============================================================================
  // SPECIALIZED STYLES
  // ============================================================================
  
  /// App bar title
  static const TextStyle appBarTitle = TextStyle(
    fontSize: fontSizeL,
    fontWeight: semiBold,
    fontFamily: primaryFontFamily,
    height: 1.2,
    letterSpacing: 0,
  );
  
  /// Tab bar text
  static const TextStyle tabBar = TextStyle(
    fontSize: fontSizeS,
    fontWeight: medium,
    fontFamily: primaryFontFamily,
    height: 1.2,
    letterSpacing: 0.1,
  );
  
  /// Form field text
  static const TextStyle formField = TextStyle(
    fontSize: fontSizeM,
    fontWeight: regular,
    fontFamily: primaryFontFamily,
    height: 1.4,
    letterSpacing: 0,
  );
  
  /// Form field label
  static const TextStyle formLabel = TextStyle(
    fontSize: fontSizeS,
    fontWeight: medium,
    fontFamily: primaryFontFamily,
    height: 1.2,
    letterSpacing: 0.1,
  );
  
  /// Navigation label
  static const TextStyle navigation = TextStyle(
    fontSize: fontSizeXS,
    fontWeight: medium,
    fontFamily: primaryFontFamily,
    height: 1.2,
    letterSpacing: 0.2,
  );

  // ============================================================================
  // UTILITY METHODS
  // ============================================================================
  
  /// Apply color to text style
  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }
  
  /// Apply weight to text style
  static TextStyle withWeight(TextStyle style, FontWeight weight) {
    return style.copyWith(fontWeight: weight);
  }
  
  /// Apply size to text style
  static TextStyle withSize(TextStyle style, double size) {
    return style.copyWith(fontSize: size);
  }
  
  /// Apply height to text style
  static TextStyle withHeight(TextStyle style, double height) {
    return style.copyWith(height: height);
  }
  
  /// Apply letter spacing to text style
  static TextStyle withLetterSpacing(TextStyle style, double letterSpacing) {
    return style.copyWith(letterSpacing: letterSpacing);
  }
  
  /// Create a text style with decoration
  static TextStyle withDecoration(TextStyle style, TextDecoration decoration) {
    return style.copyWith(decoration: decoration);
  }
  
  /// Create a text style with opacity
  static TextStyle withOpacity(TextStyle style, double opacity) {
    return style.copyWith(color: style.color?.withOpacity(opacity));
  }
}

// ============================================================================
// USAGE EXAMPLES
// ============================================================================

/*
EXAMPLE USAGE:

1. Using colors:
   Container(
     color: AppColors.primary,
     child: Text(
       'Hello World',
       style: AppFonts.heading2.copyWith(color: AppColors.white),
     ),
   )

2. Using gradients:
   Container(
     decoration: BoxDecoration(
       gradient: AppColors.primaryLinearGradient,
       borderRadius: BorderRadius.circular(10),
     ),
   )

3. Using priority colors:
   Container(
     padding: EdgeInsets.all(8),
     decoration: BoxDecoration(
       color: AppColors.getPriorityBackgroundColor('high'),
       borderRadius: BorderRadius.circular(10),
     ),
     child: Text(
       'High Priority',
       style: AppFonts.labelSmall.copyWith(
         color: AppColors.getPriorityColor('high'),
       ),
     ),
   )

4. Using font utilities:
   Text(
     'Custom Text',
     style: AppFonts.withColor(AppFonts.bodyMedium, AppColors.textSecondary),
   )

5. Creating theme:
   ThemeData(
     primaryColor: AppColors.primary,
     textTheme: TextTheme(
       headlineLarge: AppFonts.heading1,
       headlineMedium: AppFonts.heading2,
       bodyLarge: AppFonts.bodyLarge,
       bodyMedium: AppFonts.bodyMedium,
       labelLarge: AppFonts.button,
     ),
   )
*/