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
    apiKey: 'AIzaSyDSVsv9SPR6Pbe7JgaXrRLtCSgg7r7mkGA',
    appId: '1:263185896491:web:bf89f110076c29baff866e',
    messagingSenderId: '263185896491',
    projectId: 'dears-40a91',
    authDomain: 'dears-40a91.firebaseapp.com',
    storageBucket: 'dears-40a91.appspot.com',
    measurementId: 'G-KW89HEXSL2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCXYY2nTyvBv7pFaytrnSLFGiqcnMCkfEE',
    appId: '1:263185896491:android:4838c0582e469e66ff866e',
    messagingSenderId: '263185896491',
    projectId: 'dears-40a91',
    storageBucket: 'dears-40a91.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC91Hy8nOWFvjpgZiDKoSh_y8rAnniz9ng',
    appId: '1:263185896491:ios:b153ca3ce8333a0aff866e',
    messagingSenderId: '263185896491',
    projectId: 'dears-40a91',
    storageBucket: 'dears-40a91.appspot.com',
    iosBundleId: 'com.dears.dears',
  );
}
