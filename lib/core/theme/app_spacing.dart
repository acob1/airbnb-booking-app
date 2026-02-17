class AppSpacing {
  // Prevent instantiation
  AppSpacing._();

  // Spacing Values
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;

  // Border Radius
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 24.0;
  static const double radiusRound = 100.0;
}

// Backward compatibility alias
class AppRadius {
  // Prevent instantiation
  AppRadius._();

  static const double sm = AppSpacing.radiusSm;
  static const double md = AppSpacing.radiusMd;
  static const double lg = AppSpacing.radiusLg;
  static const double xl = AppSpacing.radiusXl;
  static const double round = AppSpacing.radiusRound;
}
