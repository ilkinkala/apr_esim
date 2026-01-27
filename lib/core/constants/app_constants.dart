/// Global application constants
class AppConstants {
  AppConstants._();

  // App Identity
  static const String appName = 'APR eSIM';
  static const String appVersion = '1.0.0';
  static const String appBuildNumber = '1';

  // API Configuration (PLACEHOLDER - Update when you get API docs)
  static const String baseUrl = 'https://api.yourdomain.com/v1';
  static const String apiKey = 'YOUR_API_KEY_HERE';
  
  // Timeout Durations
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Storage Keys (for local storage)
  static const String keyAuthToken = 'auth_token';
  static const String keyRefreshToken = 'refresh_token';
  static const String keyUserId = 'user_id';
  static const String keyUserEmail = 'user_email';
  static const String keyIsFirstLaunch = 'is_first_launch';
  static const String keyLanguage = 'app_language';

  // eSIM Related
  static const String eSIMActivationPrefix = 'LPA:1\$';
  
  // Pagination
  static const int defaultPageSize = 20;
  
  // Validation
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 32;
  
  // Support
  static const String supportEmail = 'support@apr-ks.com';
  static const String privacyPolicyUrl = 'https://apr-ks.com/privacy';
  static const String termsOfServiceUrl = 'https://apr-ks.com/terms';
  
  // Social Media (Optional)
  static const String websiteUrl = 'https://apr-ks.com';
  static const String instagramUrl = 'https://instagram.com/apresim';
  static const String twitterUrl = 'https://twitter.com/apresim';
}