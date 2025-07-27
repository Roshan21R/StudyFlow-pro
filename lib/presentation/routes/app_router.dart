import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Import all screens (we'll create these)
import '../pages/splash/splash_screen.dart';
import '../pages/onboarding/onboarding_screen.dart';
import '../pages/auth/login_screen.dart';
import '../pages/auth/register_screen.dart';
import '../pages/auth/forgot_password_screen.dart';
import '../pages/main/main_screen.dart';
import '../pages/dashboard/dashboard_screen.dart';
import '../pages/study_planner/study_planner_screen.dart';
import '../pages/timetable/timetable_screen.dart';
import '../pages/tasks/tasks_screen.dart';
import '../pages/tasks/task_detail_screen.dart';
import '../pages/notes/notes_screen.dart';
import '../pages/notes/note_editor_screen.dart';
import '../pages/flashcards/flashcards_screen.dart';
import '../pages/flashcards/flashcard_study_screen.dart';
import '../pages/progress/progress_screen.dart';
import '../pages/calendar/calendar_screen.dart';
import '../pages/reminders/reminders_screen.dart';
import '../pages/ai_assistant/ai_assistant_screen.dart';
import '../pages/pdf_scanner/pdf_scanner_screen.dart';
import '../pages/voice_notes/voice_notes_screen.dart';
import '../pages/statistics/statistics_screen.dart';
import '../pages/settings/settings_screen.dart';
import '../pages/profile/profile_screen.dart';
import '../pages/backup/backup_screen.dart';
import '../pages/themes/themes_screen.dart';
import '../pages/notifications/notifications_screen.dart';
import '../pages/offline_sync/offline_sync_screen.dart';
import '../pages/about/about_screen.dart';
import '../pages/help/help_screen.dart';
import '../pages/privacy/privacy_screen.dart';
import '../pages/terms/terms_screen.dart';

// Route names
class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String main = '/main';
  static const String dashboard = '/dashboard';
  static const String studyPlanner = '/study-planner';
  static const String timetable = '/timetable';
  static const String tasks = '/tasks';
  static const String taskDetail = '/tasks/:id';
  static const String notes = '/notes';
  static const String noteEditor = '/notes/editor';
  static const String flashcards = '/flashcards';
  static const String flashcardStudy = '/flashcards/study/:setId';
  static const String progress = '/progress';
  static const String calendar = '/calendar';
  static const String reminders = '/reminders';
  static const String aiAssistant = '/ai-assistant';
  static const String pdfScanner = '/pdf-scanner';
  static const String voiceNotes = '/voice-notes';
  static const String statistics = '/statistics';
  static const String settings = '/settings';
  static const String profile = '/profile';
  static const String backup = '/backup';
  static const String themes = '/themes';
  static const String notifications = '/notifications';
  static const String offlineSync = '/offline-sync';
  static const String about = '/about';
  static const String help = '/help';
  static const String privacy = '/privacy';
  static const String terms = '/terms';
}

// Router provider
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    routes: [
      // Splash Screen
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      
      // Onboarding
      GoRoute(
        path: AppRoutes.onboarding,
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      
      // Authentication Routes
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        name: 'forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      
      // Main App Shell
      ShellRoute(
        builder: (context, state, child) => MainScreen(child: child),
        routes: [
          // Dashboard
          GoRoute(
            path: AppRoutes.dashboard,
            name: 'dashboard',
            builder: (context, state) => const DashboardScreen(),
          ),
          
          // Study Planner
          GoRoute(
            path: AppRoutes.studyPlanner,
            name: 'study-planner',
            builder: (context, state) => const StudyPlannerScreen(),
          ),
          
          // Timetable
          GoRoute(
            path: AppRoutes.timetable,
            name: 'timetable',
            builder: (context, state) => const TimetableScreen(),
          ),
          
          // Tasks
          GoRoute(
            path: AppRoutes.tasks,
            name: 'tasks',
            builder: (context, state) => const TasksScreen(),
            routes: [
              GoRoute(
                path: '/:id',
                name: 'task-detail',
                builder: (context, state) {
                  final taskId = state.pathParameters['id']!;
                  return TaskDetailScreen(taskId: taskId);
                },
              ),
            ],
          ),
          
          // Notes
          GoRoute(
            path: AppRoutes.notes,
            name: 'notes',
            builder: (context, state) => const NotesScreen(),
            routes: [
              GoRoute(
                path: '/editor',
                name: 'note-editor',
                builder: (context, state) {
                  final noteId = state.uri.queryParameters['id'];
                  return NoteEditorScreen(noteId: noteId);
                },
              ),
            ],
          ),
          
          // Flashcards
          GoRoute(
            path: AppRoutes.flashcards,
            name: 'flashcards',
            builder: (context, state) => const FlashcardsScreen(),
            routes: [
              GoRoute(
                path: '/study/:setId',
                name: 'flashcard-study',
                builder: (context, state) {
                  final setId = state.pathParameters['setId']!;
                  return FlashcardStudyScreen(setId: setId);
                },
              ),
            ],
          ),
          
          // Progress
          GoRoute(
            path: AppRoutes.progress,
            name: 'progress',
            builder: (context, state) => const ProgressScreen(),
          ),
          
          // Calendar
          GoRoute(
            path: AppRoutes.calendar,
            name: 'calendar',
            builder: (context, state) => const CalendarScreen(),
          ),
          
          // Reminders
          GoRoute(
            path: AppRoutes.reminders,
            name: 'reminders',
            builder: (context, state) => const RemindersScreen(),
          ),
          
          // AI Assistant
          GoRoute(
            path: AppRoutes.aiAssistant,
            name: 'ai-assistant',
            builder: (context, state) => const AiAssistantScreen(),
          ),
          
          // PDF Scanner
          GoRoute(
            path: AppRoutes.pdfScanner,
            name: 'pdf-scanner',
            builder: (context, state) => const PdfScannerScreen(),
          ),
          
          // Voice Notes
          GoRoute(
            path: AppRoutes.voiceNotes,
            name: 'voice-notes',
            builder: (context, state) => const VoiceNotesScreen(),
          ),
          
          // Statistics
          GoRoute(
            path: AppRoutes.statistics,
            name: 'statistics',
            builder: (context, state) => const StatisticsScreen(),
          ),
          
          // Settings
          GoRoute(
            path: AppRoutes.settings,
            name: 'settings',
            builder: (context, state) => const SettingsScreen(),
          ),
          
          // Profile
          GoRoute(
            path: AppRoutes.profile,
            name: 'profile',
            builder: (context, state) => const ProfileScreen(),
          ),
          
          // Backup
          GoRoute(
            path: AppRoutes.backup,
            name: 'backup',
            builder: (context, state) => const BackupScreen(),
          ),
          
          // Themes
          GoRoute(
            path: AppRoutes.themes,
            name: 'themes',
            builder: (context, state) => const ThemesScreen(),
          ),
          
          // Notifications
          GoRoute(
            path: AppRoutes.notifications,
            name: 'notifications',
            builder: (context, state) => const NotificationsScreen(),
          ),
          
          // Offline Sync
          GoRoute(
            path: AppRoutes.offlineSync,
            name: 'offline-sync',
            builder: (context, state) => const OfflineSyncScreen(),
          ),
        ],
      ),
      
      // Standalone Routes
      GoRoute(
        path: AppRoutes.about,
        name: 'about',
        builder: (context, state) => const AboutScreen(),
      ),
      GoRoute(
        path: AppRoutes.help,
        name: 'help',
        builder: (context, state) => const HelpScreen(),
      ),
      GoRoute(
        path: AppRoutes.privacy,
        name: 'privacy',
        builder: (context, state) => const PrivacyScreen(),
      ),
      GoRoute(
        path: AppRoutes.terms,
        name: 'terms',
        builder: (context, state) => const TermsScreen(),
      ),
    ],
    
    // Error handling
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(
        title: const Text('Page Not Found'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Page Not Found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'The page you\'re looking for doesn\'t exist.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.dashboard),
              child: const Text('Go to Dashboard'),
            ),
          ],
        ),
      ),
    ),
    
    // Redirect logic
    redirect: (context, state) {
      // Add authentication logic here
      // For now, redirect splash to dashboard after a delay
      if (state.matchedLocation == AppRoutes.splash) {
        // In a real app, you'd check authentication status here
        // For now, we'll let the splash screen handle the navigation
        return null;
      }
      return null;
    },
  );
});

// Navigation extension
extension AppRouterExtension on GoRouter {
  void pushAndClearStack(String location) {
    while (canPop()) {
      pop();
    }
    pushReplacement(location);
  }
}

// Route information class
class RouteInfo {
  final String path;
  final String name;
  final IconData icon;
  final String label;
  final bool showInBottomNav;
  final bool showInDrawer;
  final List<String> requiredPermissions;

  const RouteInfo({
    required this.path,
    required this.name,
    required this.icon,
    required this.label,
    this.showInBottomNav = false,
    this.showInDrawer = true,
    this.requiredPermissions = const [],
  });
}

// App routes configuration
class AppRoutesConfig {
  static const List<RouteInfo> bottomNavRoutes = [
    RouteInfo(
      path: AppRoutes.dashboard,
      name: 'dashboard',
      icon: Icons.dashboard,
      label: 'Dashboard',
      showInBottomNav: true,
    ),
    RouteInfo(
      path: AppRoutes.studyPlanner,
      name: 'study-planner',
      icon: Icons.schedule,
      label: 'Planner',
      showInBottomNav: true,
    ),
    RouteInfo(
      path: AppRoutes.tasks,
      name: 'tasks',
      icon: Icons.task_alt,
      label: 'Tasks',
      showInBottomNav: true,
    ),
    RouteInfo(
      path: AppRoutes.progress,
      name: 'progress',
      icon: Icons.analytics,
      label: 'Progress',
      showInBottomNav: true,
    ),
    RouteInfo(
      path: AppRoutes.aiAssistant,
      name: 'ai-assistant',
      icon: Icons.psychology,
      label: 'AI Assistant',
      showInBottomNav: true,
    ),
  ];

  static const List<RouteInfo> drawerRoutes = [
    RouteInfo(
      path: AppRoutes.notes,
      name: 'notes',
      icon: Icons.note,
      label: 'Notes',
      showInDrawer: true,
    ),
    RouteInfo(
      path: AppRoutes.flashcards,
      name: 'flashcards',
      icon: Icons.quiz,
      label: 'Flashcards',
      showInDrawer: true,
    ),
    RouteInfo(
      path: AppRoutes.calendar,
      name: 'calendar',
      icon: Icons.calendar_today,
      label: 'Calendar',
      showInDrawer: true,
    ),
    RouteInfo(
      path: AppRoutes.timetable,
      name: 'timetable',
      icon: Icons.table_chart,
      label: 'Timetable',
      showInDrawer: true,
    ),
    RouteInfo(
      path: AppRoutes.reminders,
      name: 'reminders',
      icon: Icons.notifications,
      label: 'Reminders',
      showInDrawer: true,
    ),
    RouteInfo(
      path: AppRoutes.pdfScanner,
      name: 'pdf-scanner',
      icon: Icons.document_scanner,
      label: 'PDF Scanner',
      showInDrawer: true,
      requiredPermissions: ['camera'],
    ),
    RouteInfo(
      path: AppRoutes.voiceNotes,
      name: 'voice-notes',
      icon: Icons.mic,
      label: 'Voice Notes',
      showInDrawer: true,
      requiredPermissions: ['microphone'],
    ),
    RouteInfo(
      path: AppRoutes.statistics,
      name: 'statistics',
      icon: Icons.bar_chart,
      label: 'Statistics',
      showInDrawer: true,
    ),
    RouteInfo(
      path: AppRoutes.settings,
      name: 'settings',
      icon: Icons.settings,
      label: 'Settings',
      showInDrawer: true,
    ),
    RouteInfo(
      path: AppRoutes.profile,
      name: 'profile',
      icon: Icons.person,
      label: 'Profile',
      showInDrawer: true,
    ),
  ];

  static RouteInfo? getRouteInfo(String path) {
    final allRoutes = [...bottomNavRoutes, ...drawerRoutes];
    try {
      return allRoutes.firstWhere((route) => route.path == path);
    } catch (e) {
      return null;
    }
  }

  static List<RouteInfo> getRoutesForBottomNav() {
    return bottomNavRoutes;
  }

  static List<RouteInfo> getRoutesForDrawer() {
    return drawerRoutes;
  }
}