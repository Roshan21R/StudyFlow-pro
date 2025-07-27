import 'dart:io';

void main() {
  final screens = [
    'auth/register_screen.dart:RegisterScreen',
    'auth/forgot_password_screen.dart:ForgotPasswordScreen',
    'study_planner/study_planner_screen.dart:StudyPlannerScreen',
    'timetable/timetable_screen.dart:TimetableScreen',
    'tasks/tasks_screen.dart:TasksScreen',
    'tasks/task_detail_screen.dart:TaskDetailScreen',
    'notes/notes_screen.dart:NotesScreen',
    'notes/note_editor_screen.dart:NoteEditorScreen',
    'flashcards/flashcards_screen.dart:FlashcardsScreen',
    'flashcards/flashcard_study_screen.dart:FlashcardStudyScreen',
    'progress/progress_screen.dart:ProgressScreen',
    'calendar/calendar_screen.dart:CalendarScreen',
    'reminders/reminders_screen.dart:RemindersScreen',
    'ai_assistant/ai_assistant_screen.dart:AiAssistantScreen',
    'pdf_scanner/pdf_scanner_screen.dart:PdfScannerScreen',
    'voice_notes/voice_notes_screen.dart:VoiceNotesScreen',
    'statistics/statistics_screen.dart:StatisticsScreen',
    'settings/settings_screen.dart:SettingsScreen',
    'profile/profile_screen.dart:ProfileScreen',
    'backup/backup_screen.dart:BackupScreen',
    'themes/themes_screen.dart:ThemesScreen',
    'notifications/notifications_screen.dart:NotificationsScreen',
    'offline_sync/offline_sync_screen.dart:OfflineSyncScreen',
    'about/about_screen.dart:AboutScreen',
    'help/help_screen.dart:HelpScreen',
    'privacy/privacy_screen.dart:PrivacyScreen',
    'terms/terms_screen.dart:TermsScreen',
  ];

  for (final screen in screens) {
    final parts = screen.split(':');
    final filePath = parts[0];
    final className = parts[1];
    
    final content = '''import 'package:flutter/material.dart';

class $className extends StatelessWidget {
  ${className == 'TaskDetailScreen' ? 'final String taskId;' : ''}
  ${className == 'FlashcardStudyScreen' ? 'final String setId;' : ''}
  ${className == 'NoteEditorScreen' ? 'final String? noteId;' : ''}
  
  const $className({
    Key? key,
    ${className == 'TaskDetailScreen' ? 'required this.taskId,' : ''}
    ${className == 'FlashcardStudyScreen' ? 'required this.setId,' : ''}
    ${className == 'NoteEditorScreen' ? 'this.noteId,' : ''}
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${className.replaceAll('Screen', '').replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match.group(1)}').trim()}')),
      body: const Center(child: Text('${className.replaceAll('Screen', '')} - Coming Soon!')),
    );
  }
}
''';

    final file = File('lib/presentation/pages/$filePath');
    file.createSync(recursive: true);
    file.writeAsStringSync(content);
    print('Created: $filePath');
  }
}