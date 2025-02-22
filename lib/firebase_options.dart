// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDRgHMkHyCN1xbKARqf57zvcHKQgKjwWuE',
    appId: '1:519953653697:web:c9eebe4adeac7bb2d69940',
    messagingSenderId: '519953653697',
    projectId: 'practice-ce70d',
    authDomain: 'practice-ce70d.firebaseapp.com',
    storageBucket: 'practice-ce70d.firebasestorage.app',
    measurementId: 'G-GBNKYW2X10',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBkZ9RogvDI3z-37IWqtzqDFkFUmrA1zUM',
    appId: '1:519953653697:android:b34cb475b30d7025d69940',
    messagingSenderId: '519953653697',
    projectId: 'practice-ce70d',
    storageBucket: 'practice-ce70d.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAnGJs8KQx0Jro41H_3U9G6ktreKmKLANI',
    appId: '1:519953653697:ios:a0254b49c32abca5d69940',
    messagingSenderId: '519953653697',
    projectId: 'practice-ce70d',
    storageBucket: 'practice-ce70d.firebasestorage.app',
    iosBundleId: 'com.example.practice',
  );

}