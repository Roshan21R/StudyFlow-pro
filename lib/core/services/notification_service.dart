import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:awesome_notifications/awesome_notifications.dart';
import '../constants/app_constants.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  
  static bool _initialized = false;

  static Future<void> initialize() async {
    if (_initialized) return;

    // Initialize Awesome Notifications
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelGroupKey: 'study_reminders',
          channelKey: 'study_reminder_channel',
          channelName: 'Study Reminders',
          channelDescription: 'Notifications for study session reminders',
          defaultColor: const Color(0xFF6750A4),
          ledColor: Colors.white,
          importance: NotificationImportance.High,
          channelShowBadge: true,
          onlyAlertOnce: true,
          playSound: true,
          criticalAlerts: false,
        ),
        NotificationChannel(
          channelGroupKey: 'task_reminders',
          channelKey: 'task_reminder_channel',
          channelName: 'Task Reminders',
          channelDescription: 'Notifications for task deadlines and reminders',
          defaultColor: const Color(0xFF625B71),
          ledColor: Colors.white,
          importance: NotificationImportance.High,
          channelShowBadge: true,
          onlyAlertOnce: true,
          playSound: true,
          criticalAlerts: false,
        ),
        NotificationChannel(
          channelGroupKey: 'break_reminders',
          channelKey: 'break_reminder_channel',
          channelName: 'Break Reminders',
          channelDescription: 'Notifications for break time reminders',
          defaultColor: const Color(0xFF7D5260),
          ledColor: Colors.white,
          importance: NotificationImportance.Default,
          channelShowBadge: true,
          onlyAlertOnce: true,
          playSound: true,
          criticalAlerts: false,
        ),
        NotificationChannel(
          channelGroupKey: 'daily_goals',
          channelKey: 'daily_goal_channel',
          channelName: 'Daily Goals',
          channelDescription: 'Notifications for daily goal achievements',
          defaultColor: const Color(0xFF00C853),
          ledColor: Colors.white,
          importance: NotificationImportance.Default,
          channelShowBadge: true,
          onlyAlertOnce: true,
          playSound: true,
          criticalAlerts: false,
        ),
        NotificationChannel(
          channelGroupKey: 'motivational',
          channelKey: 'motivational_channel',
          channelName: 'Motivational Messages',
          channelDescription: 'Motivational notifications to keep you focused',
          defaultColor: const Color(0xFF2196F3),
          ledColor: Colors.white,
          importance: NotificationImportance.Low,
          channelShowBadge: false,
          onlyAlertOnce: false,
          playSound: false,
          criticalAlerts: false,
        ),
      ],
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: 'study_reminders',
          channelGroupName: 'Study Reminders',
        ),
        NotificationChannelGroup(
          channelGroupKey: 'task_reminders',
          channelGroupName: 'Task Reminders',
        ),
        NotificationChannelGroup(
          channelGroupKey: 'break_reminders',
          channelGroupName: 'Break Reminders',
        ),
        NotificationChannelGroup(
          channelGroupKey: 'daily_goals',
          channelGroupName: 'Daily Goals',
        ),
        NotificationChannelGroup(
          channelGroupKey: 'motivational',
          channelGroupName: 'Motivational',
        ),
      ],
      debug: true,
    );

    // Initialize Flutter Local Notifications as backup
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    _initialized = true;
  }

  static void _onNotificationTapped(NotificationResponse response) {
    // Handle notification tap
    final String? payload = response.payload;
    if (payload != null) {
      // Navigate to appropriate screen based on payload
      _handleNotificationNavigation(payload);
    }
  }

  static void _handleNotificationNavigation(String payload) {
    // Parse payload and navigate to appropriate screen
    // This would be implemented based on your navigation system
    print('Notification tapped with payload: $payload');
  }

  // Request notification permissions
  static Future<bool> requestPermissions() async {
    final bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      return await AwesomeNotifications().requestPermissionToSendNotifications();
    }
    return true;
  }

  // Study Session Reminders
  static Future<void> scheduleStudyReminder({
    required String title,
    required String body,
    required DateTime scheduledTime,
    String? payload,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: AppConstants.studyReminderNotificationId,
        channelKey: 'study_reminder_channel',
        title: title,
        body: body,
        payload: payload != null ? {'data': payload} : null,
        notificationLayout: NotificationLayout.Default,
        wakeUpScreen: true,
        category: NotificationCategory.Reminder,
        actionType: ActionType.Default,
      ),
      schedule: NotificationCalendar.fromDate(date: scheduledTime),
    );
  }

  // Task Deadline Reminders
  static Future<void> scheduleTaskReminder({
    required String taskTitle,
    required DateTime deadline,
    String? description,
  }) async {
    // Schedule 1 day before
    final DateTime oneDayBefore = deadline.subtract(const Duration(days: 1));
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: AppConstants.taskReminderNotificationId,
        channelKey: 'task_reminder_channel',
        title: 'Task Due Tomorrow',
        body: 'Don\'t forget: $taskTitle is due tomorrow!',
        payload: {'task_id': taskTitle, 'type': 'task_reminder'},
        notificationLayout: NotificationLayout.BigText,
        largeIcon: 'resource://drawable/task_icon',
        wakeUpScreen: true,
        category: NotificationCategory.Reminder,
      ),
      schedule: NotificationCalendar.fromDate(date: oneDayBefore),
    );

    // Schedule 1 hour before
    final DateTime oneHourBefore = deadline.subtract(const Duration(hours: 1));
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: AppConstants.taskReminderNotificationId + 1,
        channelKey: 'task_reminder_channel',
        title: 'Task Due Soon!',
        body: '$taskTitle is due in 1 hour!',
        payload: {'task_id': taskTitle, 'type': 'task_urgent'},
        notificationLayout: NotificationLayout.BigText,
        largeIcon: 'resource://drawable/urgent_icon',
        wakeUpScreen: true,
        category: NotificationCategory.Alarm,
      ),
      schedule: NotificationCalendar.fromDate(date: oneHourBefore),
    );
  }

  // Break Time Reminders
  static Future<void> scheduleBreakReminder({
    required int studyDurationMinutes,
  }) async {
    final DateTime breakTime = DateTime.now().add(
      Duration(minutes: studyDurationMinutes),
    );

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: AppConstants.breakReminderNotificationId,
        channelKey: 'break_reminder_channel',
        title: 'Time for a Break! 🎉',
        body: 'Great job studying! Take a ${AppConstants.defaultBreakDuration}-minute break.',
        payload: {'type': 'break_time'},
        notificationLayout: NotificationLayout.Default,
        wakeUpScreen: true,
        category: NotificationCategory.Reminder,
      ),
      schedule: NotificationCalendar.fromDate(date: breakTime),
    );
  }

  // Daily Goal Notifications
  static Future<void> scheduleDailyGoalReminder({
    required String goalText,
    required TimeOfDay reminderTime,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: AppConstants.dailyGoalNotificationId,
        channelKey: 'daily_goal_channel',
        title: 'Daily Goal Reminder 🎯',
        body: 'Don\'t forget your goal: $goalText',
        payload: {'type': 'daily_goal'},
        notificationLayout: NotificationLayout.Default,
        wakeUpScreen: false,
        category: NotificationCategory.Reminder,
      ),
      schedule: NotificationCalendar(
        hour: reminderTime.hour,
        minute: reminderTime.minute,
        second: 0,
        repeats: true,
      ),
    );
  }

  // Motivational Notifications
  static Future<void> scheduleMotivationalMessage() async {
    final List<String> motivationalMessages = [
      "You're doing great! Keep up the excellent work! 💪",
      "Every small step counts towards your big goals! 🌟",
      "Consistency is key to success. You've got this! 🔥",
      "Learning is a journey, not a destination. Enjoy the process! 📚",
      "Your future self will thank you for studying today! ✨",
      "Progress, not perfection. Keep moving forward! 🚀",
      "Believe in yourself and your ability to succeed! 💫",
      "Hard work pays off. Stay focused and determined! 🎯",
    ];

    final String randomMessage = motivationalMessages[
        DateTime.now().millisecondsSinceEpoch % motivationalMessages.length
    ];

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        channelKey: 'motivational_channel',
        title: 'StudyFlow Pro Motivation',
        body: randomMessage,
        payload: {'type': 'motivational'},
        notificationLayout: NotificationLayout.Default,
        wakeUpScreen: false,
        category: NotificationCategory.Social,
      ),
    );
  }

  // Pomodoro Timer Notifications
  static Future<void> schedulePomodoroNotifications({
    required int sessionNumber,
    required int totalSessions,
  }) async {
    final bool isLastSession = sessionNumber == totalSessions;
    final String title = isLastSession 
        ? 'Pomodoro Complete! 🎉'
        : 'Pomodoro Session $sessionNumber Complete!';
    
    final String body = isLastSession
        ? 'Congratulations! You\'ve completed all $totalSessions sessions. Take a long break!'
        : 'Great work! Time for a short break before session ${sessionNumber + 1}.';

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 2000 + sessionNumber,
        channelKey: 'study_reminder_channel',
        title: title,
        body: body,
        payload: {
          'type': 'pomodoro_complete',
          'session': sessionNumber.toString(),
          'is_last': isLastSession.toString(),
        },
        notificationLayout: NotificationLayout.BigText,
        wakeUpScreen: true,
        category: NotificationCategory.Reminder,
      ),
    );
  }

  // Cancel specific notification
  static Future<void> cancelNotification(int id) async {
    await AwesomeNotifications().cancel(id);
  }

  // Cancel all notifications
  static Future<void> cancelAllNotifications() async {
    await AwesomeNotifications().cancelAll();
  }

  // Show immediate notification
  static Future<void> showImmediateNotification({
    required String title,
    required String body,
    String? payload,
    String channelKey = 'study_reminder_channel',
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        channelKey: channelKey,
        title: title,
        body: body,
        payload: payload != null ? {'data': payload} : null,
        notificationLayout: NotificationLayout.Default,
        wakeUpScreen: true,
        category: NotificationCategory.Message,
      ),
    );
  }

  // Check if notifications are enabled
  static Future<bool> areNotificationsEnabled() async {
    return await AwesomeNotifications().isNotificationAllowed();
  }

  // Get pending notifications
  static Future<List<NotificationModel>> getPendingNotifications() async {
    return await AwesomeNotifications().listScheduledNotifications();
  }

  // Schedule weekly study plan reminder
  static Future<void> scheduleWeeklyPlanReminder() async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 3001,
        channelKey: 'study_reminder_channel',
        title: 'Weekly Planning Time 📅',
        body: 'Time to plan your study schedule for the upcoming week!',
        payload: {'type': 'weekly_planning'},
        notificationLayout: NotificationLayout.Default,
        wakeUpScreen: false,
        category: NotificationCategory.Reminder,
      ),
      schedule: NotificationCalendar(
        weekday: 7, // Sunday
        hour: 18, // 6 PM
        minute: 0,
        second: 0,
        repeats: true,
      ),
    );
  }

  // Schedule study streak celebration
  static Future<void> celebrateStudyStreak(int streakDays) async {
    String title = 'Study Streak! 🔥';
    String body = 'Amazing! You\'ve studied for $streakDays days in a row!';
    
    if (streakDays == 7) {
      title = 'One Week Streak! 🌟';
      body = 'Incredible! You\'ve maintained a 7-day study streak!';
    } else if (streakDays == 30) {
      title = 'One Month Streak! 🏆';
      body = 'Outstanding! 30 days of consistent studying!';
    } else if (streakDays == 100) {
      title = 'Century Streak! 💯';
      body = 'Legendary! 100 days of dedicated studying!';
    }

    await showImmediateNotification(
      title: title,
      body: body,
      payload: 'streak_celebration',
      channelKey: 'daily_goal_channel',
    );
  }
}