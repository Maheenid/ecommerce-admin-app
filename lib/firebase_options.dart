// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC3YrjujLLX30YbX4sY6vPhRU_IaoOGbjU',
    appId: '1:367284984661:web:20e4bb6f572c19ad92addc',
    messagingSenderId: '367284984661',
    projectId: 'chat-app-822a2',
    authDomain: 'chat-app-822a2.firebaseapp.com',
    storageBucket: 'chat-app-822a2.appspot.com',
    measurementId: 'G-S7765HWS62',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyADYQRgB7fAT5K_1yyHhpMPJRnkYXAacko',
    appId: '1:367284984661:android:e33e31fa2612b76692addc',
    messagingSenderId: '367284984661',
    projectId: 'chat-app-822a2',
    storageBucket: 'chat-app-822a2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyABP0S2fSa4-J-zsbatyIr1RRxiDjSGgpc',
    appId: '1:367284984661:ios:21c585fa8c0960de92addc',
    messagingSenderId: '367284984661',
    projectId: 'chat-app-822a2',
    storageBucket: 'chat-app-822a2.appspot.com',
    iosBundleId: 'com.example.ecoAdminPanel',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyABP0S2fSa4-J-zsbatyIr1RRxiDjSGgpc',
    appId: '1:367284984661:ios:ecf0579e18bac75592addc',
    messagingSenderId: '367284984661',
    projectId: 'chat-app-822a2',
    storageBucket: 'chat-app-822a2.appspot.com',
    iosBundleId: 'com.example.ecoAdminPanel.RunnerTests',
  );
}
