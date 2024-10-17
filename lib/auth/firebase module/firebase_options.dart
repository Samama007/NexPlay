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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyAnGOyUQidnpyJgUx-3No8BDR-Cs69Vl18',
    appId: '1:719706620793:web:8cea82311f5010a38a25a8',
    messagingSenderId: '719706620793',
    projectId: 'nexplay-36f92',
    authDomain: 'nexplay-36f92.firebaseapp.com',
    storageBucket: 'nexplay-36f92.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDoIKJ4dy7yudaHvu6b9NKWLshCPTfkmtw',
    appId: '1:719706620793:android:2540f9550a9acd118a25a8',
    messagingSenderId: '719706620793',
    projectId: 'nexplay-36f92',
    storageBucket: 'nexplay-36f92.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBZpT9ft_DRUCkD_7az6MO7IJikVHZQmtE',
    appId: '1:719706620793:ios:30349a202d40e07a8a25a8',
    messagingSenderId: '719706620793',
    projectId: 'nexplay-36f92',
    storageBucket: 'nexplay-36f92.appspot.com',
    iosBundleId: 'com.example.gamesDatabase',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBZpT9ft_DRUCkD_7az6MO7IJikVHZQmtE',
    appId: '1:719706620793:ios:30349a202d40e07a8a25a8',
    messagingSenderId: '719706620793',
    projectId: 'nexplay-36f92',
    storageBucket: 'nexplay-36f92.appspot.com',
    iosBundleId: 'com.example.gamesDatabase',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAnGOyUQidnpyJgUx-3No8BDR-Cs69Vl18',
    appId: '1:719706620793:web:de7b17ead94bac698a25a8',
    messagingSenderId: '719706620793',
    projectId: 'nexplay-36f92',
    authDomain: 'nexplay-36f92.firebaseapp.com',
    storageBucket: 'nexplay-36f92.appspot.com',
  );
}