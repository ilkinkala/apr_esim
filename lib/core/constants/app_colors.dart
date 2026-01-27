import 'package:flutter/material.dart';

/// APR eSIM Brand Colors
class AppColors {
  AppColors._();

  // Primary Brand Colors
  static const Color primary = Color(0xFF004643);      // Cyprus Green
  static const Color primaryLight = Color(0xFF006B66);
  static const Color primaryDark = Color(0xFF003533);

  // Background Colors
  static const Color background = Color(0xFFF0EDE5);   // Cream
  static const Color surface = Color(0xFFFFFFFF);      // White (cards)
  static const Color surfaceVariant = Color(0xFFF5F2EC);

  // Text Colors
  static const Color textPrimary = Color(0xFF1A1A1A);  // Charcoal
  static const Color textSecondary = Color(0xFF666666);
  static const Color textTertiary = Color(0xFF999999);
  static const Color textDisabled = Color(0xFFCCCCCC);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color errorColor = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF0EA5E9);

  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey100 = Color(0xFFF3F4F6);
  static const Color grey200 = Color(0xFFE5E7EB);
  static const Color grey300 = Color(0xFFD1D5DB);
  static const Color grey400 = Color(0xFF9CA3AF);
  static const Color grey500 = Color(0xFF6B7280);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, primaryLight],
  );
}