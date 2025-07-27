class AppConstants {
  // App Information
  static const String appName = 'StudyFlow Pro';
  static const String appVersion = '1.0.0';
  static const String appCreator = 'Created by Roshan';
  static const String packageName = 'com.roshan.studyflowpro';
  static const String supportEmail = 'roshan8800jp@gmail.com';
  
  // App Description
  static const String appDescription = 
      'Advanced Study Management App for Students with AI-powered features, '
      'comprehensive study tools, and modern design.';
  
  // API & Network
  static const String baseUrl = 'https://api.studyflowpro.com';
  static const int connectionTimeout = 30000;
  static const int receiveTimeout = 30000;
  
  // Local Storage Keys
  static const String userPrefsBox = 'user_preferences';
  static const String studyDataBox = 'study_data';
  static const String notesBox = 'notes';
  static const String tasksBox = 'tasks';
  static const String timetableBox = 'timetable';
  static const String flashcardsBox = 'flashcards';
  static const String progressBox = 'progress';
  static const String settingsBox = 'settings';
  
  // Theme & UI
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double borderRadius = 12.0;
  static const double cardElevation = 4.0;
  
  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);
  
  // Study Session Defaults
  static const int defaultStudyDuration = 25; // minutes
  static const int defaultBreakDuration = 5; // minutes
  static const int defaultLongBreakDuration = 15; // minutes
  static const int pomodoroSessions = 4;
  
  // Notification IDs
  static const int studyReminderNotificationId = 1001;
  static const int taskReminderNotificationId = 1002;
  static const int breakReminderNotificationId = 1003;
  static const int dailyGoalNotificationId = 1004;
  
  // File Types
  static const List<String> supportedImageTypes = ['jpg', 'jpeg', 'png', 'gif'];
  static const List<String> supportedDocumentTypes = ['pdf', 'doc', 'docx', 'txt'];
  static const List<String> supportedAudioTypes = ['mp3', 'wav', 'aac', 'm4a'];
  
  // AI Features
  static const String aiAssistantName = 'StudyBot';
  static const int maxAiResponseLength = 1000;
  static const int aiRequestTimeout = 15000;
  
  // Backup & Sync
  static const String cloudStorageBucket = 'studyflow-pro-backup';
  static const int maxBackupFiles = 10;
  static const Duration autoBackupInterval = Duration(hours: 24);
  
  // Performance
  static const int maxCacheSize = 100 * 1024 * 1024; // 100MB
  static const Duration cacheExpiration = Duration(days: 7);
  
  // Security
  static const int maxLoginAttempts = 5;
  static const Duration lockoutDuration = Duration(minutes: 15);
  static const int sessionTimeout = 30; // minutes
  
  // Feature Limits
  static const int maxNotesPerDay = 100;
  static const int maxTasksPerDay = 50;
  static const int maxFlashcardsPerSet = 200;
  static const int maxStudySessionsPerDay = 20;
  
  // URLs
  static const String privacyPolicyUrl = 'https://studyflowpro.com/privacy';
  static const String termsOfServiceUrl = 'https://studyflowpro.com/terms';
  static const String supportUrl = 'https://studyflowpro.com/support';
  static const String githubUrl = 'https://github.com/Roshan21R/StudyFlow-pro';
  
  // Social Media
  static const String twitterUrl = 'https://twitter.com/studyflowpro';
  static const String instagramUrl = 'https://instagram.com/studyflowpro';
  static const String linkedinUrl = 'https://linkedin.com/company/studyflowpro';
  
  // App Features List
  static const List<String> appFeatures = [
    'AI-Powered Study Assistant',
    'Smart Timetable Generation',
    'Advanced Task Management',
    'Interactive Flashcards',
    'Progress Analytics',
    'Study Reminders',
    'Note Taking & Organization',
    'PDF Scanner & Reader',
    'Voice Notes & Text-to-Speech',
    'Offline Mode Support',
    'Cloud Backup & Sync',
    'Dark/Light Theme',
    'Pomodoro Timer',
    'Calendar Integration',
    'Goal Setting & Tracking',
    'Study Statistics',
    'Focus Mode',
    'Habit Tracker',
    'Mind Maps',
    'Quiz Generator',
    'Study Groups',
    'Time Blocking',
    'Distraction Blocker',
    'Study Music Player',
    'Weather Integration',
    'Location-based Reminders',
    'Biometric Security',
    'Multi-language Support',
    'Accessibility Features',
    'Custom Themes',
  ];
  
  // Error Messages
  static const String networkError = 'Network connection failed. Please check your internet connection.';
  static const String unknownError = 'An unexpected error occurred. Please try again.';
  static const String authError = 'Authentication failed. Please login again.';
  static const String permissionError = 'Permission denied. Please grant required permissions.';
  static const String storageError = 'Storage operation failed. Please check available space.';
  
  // Success Messages
  static const String saveSuccess = 'Data saved successfully!';
  static const String deleteSuccess = 'Item deleted successfully!';
  static const String updateSuccess = 'Updated successfully!';
  static const String syncSuccess = 'Data synchronized successfully!';
  static const String backupSuccess = 'Backup created successfully!';
}