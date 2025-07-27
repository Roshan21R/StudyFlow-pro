import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

class PermissionService {
  static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  // Request all necessary permissions at app startup
  static Future<void> requestAllPermissions() async {
    await Future.wait([
      requestNotificationPermission(),
      requestStoragePermission(),
      requestCameraPermission(),
      requestMicrophonePermission(),
      requestLocationPermission(),
      requestContactsPermission(),
    ]);
  }

  // Notification Permission
  static Future<bool> requestNotificationPermission() async {
    final status = await Permission.notification.status;
    if (status.isDenied) {
      final result = await Permission.notification.request();
      return result.isGranted;
    }
    return status.isGranted;
  }

  static Future<bool> hasNotificationPermission() async {
    return await Permission.notification.isGranted;
  }

  // Storage Permission
  static Future<bool> requestStoragePermission() async {
    if (Platform.isAndroid) {
      final androidInfo = await _deviceInfo.androidInfo;
      
      if (androidInfo.version.sdkInt >= 33) {
        // Android 13+ uses scoped storage
        final photos = await Permission.photos.status;
        final videos = await Permission.videos.status;
        final audio = await Permission.audio.status;
        
        if (photos.isDenied || videos.isDenied || audio.isDenied) {
          final results = await [
            Permission.photos,
            Permission.videos,
            Permission.audio,
          ].request();
          
          return results.values.every((status) => status.isGranted);
        }
        return photos.isGranted && videos.isGranted && audio.isGranted;
      } else {
        // Android 12 and below
        final status = await Permission.storage.status;
        if (status.isDenied) {
          final result = await Permission.storage.request();
          return result.isGranted;
        }
        return status.isGranted;
      }
    } else if (Platform.isIOS) {
      final photos = await Permission.photos.status;
      if (photos.isDenied) {
        final result = await Permission.photos.request();
        return result.isGranted;
      }
      return photos.isGranted;
    }
    return true;
  }

  static Future<bool> hasStoragePermission() async {
    if (Platform.isAndroid) {
      final androidInfo = await _deviceInfo.androidInfo;
      
      if (androidInfo.version.sdkInt >= 33) {
        return await Permission.photos.isGranted &&
               await Permission.videos.isGranted &&
               await Permission.audio.isGranted;
      } else {
        return await Permission.storage.isGranted;
      }
    } else if (Platform.isIOS) {
      return await Permission.photos.isGranted;
    }
    return true;
  }

  // Camera Permission
  static Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.status;
    if (status.isDenied) {
      final result = await Permission.camera.request();
      return result.isGranted;
    }
    return status.isGranted;
  }

  static Future<bool> hasCameraPermission() async {
    return await Permission.camera.isGranted;
  }

  // Microphone Permission
  static Future<bool> requestMicrophonePermission() async {
    final status = await Permission.microphone.status;
    if (status.isDenied) {
      final result = await Permission.microphone.request();
      return result.isGranted;
    }
    return status.isGranted;
  }

  static Future<bool> hasMicrophonePermission() async {
    return await Permission.microphone.isGranted;
  }

  // Location Permission
  static Future<bool> requestLocationPermission() async {
    final status = await Permission.locationWhenInUse.status;
    if (status.isDenied) {
      final result = await Permission.locationWhenInUse.request();
      return result.isGranted;
    }
    return status.isGranted;
  }

  static Future<bool> hasLocationPermission() async {
    return await Permission.locationWhenInUse.isGranted;
  }

  // Contacts Permission (for study groups feature)
  static Future<bool> requestContactsPermission() async {
    final status = await Permission.contacts.status;
    if (status.isDenied) {
      final result = await Permission.contacts.request();
      return result.isGranted;
    }
    return status.isGranted;
  }

  static Future<bool> hasContactsPermission() async {
    return await Permission.contacts.isGranted;
  }

  // Calendar Permission
  static Future<bool> requestCalendarPermission() async {
    final status = await Permission.calendarFullAccess.status;
    if (status.isDenied) {
      final result = await Permission.calendarFullAccess.request();
      return result.isGranted;
    }
    return status.isGranted;
  }

  static Future<bool> hasCalendarPermission() async {
    return await Permission.calendarFullAccess.isGranted;
  }

  // Speech Recognition Permission
  static Future<bool> requestSpeechPermission() async {
    final status = await Permission.speech.status;
    if (status.isDenied) {
      final result = await Permission.speech.request();
      return result.isGranted;
    }
    return status.isGranted;
  }

  static Future<bool> hasSpeechPermission() async {
    return await Permission.speech.isGranted;
  }

  // Manage External Storage (Android 11+)
  static Future<bool> requestManageExternalStoragePermission() async {
    if (Platform.isAndroid) {
      final androidInfo = await _deviceInfo.androidInfo;
      
      if (androidInfo.version.sdkInt >= 30) {
        final status = await Permission.manageExternalStorage.status;
        if (status.isDenied) {
          final result = await Permission.manageExternalStorage.request();
          return result.isGranted;
        }
        return status.isGranted;
      }
    }
    return true;
  }

  // Background App Refresh (iOS)
  static Future<bool> requestBackgroundAppRefreshPermission() async {
    if (Platform.isIOS) {
      final status = await Permission.appTrackingTransparency.status;
      if (status.isDenied) {
        final result = await Permission.appTrackingTransparency.request();
        return result.isGranted;
      }
      return status.isGranted;
    }
    return true;
  }

  // System Alert Window (Android - for overlay features)
  static Future<bool> requestSystemAlertWindowPermission() async {
    if (Platform.isAndroid) {
      final status = await Permission.systemAlertWindow.status;
      if (status.isDenied) {
        final result = await Permission.systemAlertWindow.request();
        return result.isGranted;
      }
      return status.isGranted;
    }
    return true;
  }

  // Check all permissions status
  static Future<Map<String, bool>> checkAllPermissionsStatus() async {
    return {
      'notification': await hasNotificationPermission(),
      'storage': await hasStoragePermission(),
      'camera': await hasCameraPermission(),
      'microphone': await hasMicrophonePermission(),
      'location': await hasLocationPermission(),
      'contacts': await hasContactsPermission(),
      'calendar': await hasCalendarPermission(),
      'speech': await hasSpeechPermission(),
    };
  }

  // Get permission status as string
  static Future<String> getPermissionStatusString(Permission permission) async {
    final status = await permission.status;
    switch (status) {
      case PermissionStatus.granted:
        return 'Granted';
      case PermissionStatus.denied:
        return 'Denied';
      case PermissionStatus.restricted:
        return 'Restricted';
      case PermissionStatus.limited:
        return 'Limited';
      case PermissionStatus.permanentlyDenied:
        return 'Permanently Denied';
      case PermissionStatus.provisional:
        return 'Provisional';
      default:
        return 'Unknown';
    }
  }

  // Open app settings if permission is permanently denied
  static Future<bool> openAppSettings() async {
    return await openAppSettings();
  }

  // Check if permission is permanently denied
  static Future<bool> isPermissionPermanentlyDenied(Permission permission) async {
    final status = await permission.status;
    return status.isPermanentlyDenied;
  }

  // Request permission with rationale
  static Future<bool> requestPermissionWithRationale({
    required Permission permission,
    required String rationale,
    required Function(String) showRationaleDialog,
  }) async {
    final status = await permission.status;
    
    if (status.isDenied) {
      // Show rationale if needed
      if (await permission.shouldShowRequestRationale) {
        showRationaleDialog(rationale);
      }
      
      final result = await permission.request();
      return result.isGranted;
    } else if (status.isPermanentlyDenied) {
      // Show dialog to open settings
      showRationaleDialog(
        '$rationale\n\nPlease enable this permission in app settings.',
      );
      return false;
    }
    
    return status.isGranted;
  }

  // Batch permission request
  static Future<Map<Permission, PermissionStatus>> requestMultiplePermissions(
    List<Permission> permissions,
  ) async {
    return await permissions.request();
  }

  // Get required permissions for specific features
  static List<Permission> getPermissionsForFeature(String feature) {
    switch (feature) {
      case 'camera_scanner':
        return [Permission.camera, Permission.storage];
      case 'voice_notes':
        return [Permission.microphone, Permission.storage];
      case 'location_reminders':
        return [Permission.locationWhenInUse];
      case 'calendar_integration':
        return [Permission.calendarFullAccess];
      case 'contact_sharing':
        return [Permission.contacts];
      case 'file_management':
        return [Permission.storage];
      case 'notifications':
        return [Permission.notification];
      case 'speech_to_text':
        return [Permission.microphone, Permission.speech];
      default:
        return [];
    }
  }

  // Check if all permissions for a feature are granted
  static Future<bool> hasAllPermissionsForFeature(String feature) async {
    final permissions = getPermissionsForFeature(feature);
    for (final permission in permissions) {
      if (!(await permission.isGranted)) {
        return false;
      }
    }
    return true;
  }

  // Request all permissions for a specific feature
  static Future<bool> requestPermissionsForFeature(String feature) async {
    final permissions = getPermissionsForFeature(feature);
    final results = await permissions.request();
    return results.values.every((status) => status.isGranted);
  }

  // Get permission rationale text
  static String getPermissionRationale(Permission permission) {
    switch (permission) {
      case Permission.camera:
        return 'StudyFlow Pro needs camera access to scan documents, take photos of notes, and use QR code features.';
      case Permission.microphone:
        return 'StudyFlow Pro needs microphone access to record voice notes and use speech-to-text features.';
      case Permission.storage:
        return 'StudyFlow Pro needs storage access to save your notes, documents, and backup your data.';
      case Permission.notification:
        return 'StudyFlow Pro needs notification permission to send you study reminders and important updates.';
      case Permission.locationWhenInUse:
        return 'StudyFlow Pro needs location access to provide location-based study reminders and find nearby study spots.';
      case Permission.contacts:
        return 'StudyFlow Pro needs contacts access to help you share study materials and create study groups.';
      case Permission.calendarFullAccess:
        return 'StudyFlow Pro needs calendar access to integrate your study schedule with your calendar.';
      case Permission.speech:
        return 'StudyFlow Pro needs speech recognition access to convert your voice to text for notes and search.';
      default:
        return 'StudyFlow Pro needs this permission to provide you with the best study experience.';
    }
  }

  // Show permission denied dialog
  static void showPermissionDeniedDialog({
    required Permission permission,
    required Function(String, VoidCallback) showDialog,
  }) {
    final rationale = getPermissionRationale(permission);
    showDialog(
      '$rationale\n\nWould you like to open app settings to grant this permission?',
      () => openAppSettings(),
    );
  }
}