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
    apiKey: 'AIzaSyCdJWSW5ODVpit0Pkn4pZvfLMtPR1TfkZ8',
    appId: '1:969447912901:web:fb65e3d107e9adea2b87ac',
    messagingSenderId: '969447912901',
    projectId: 'delivery-app-c7be9',
    authDomain: 'delivery-app-c7be9.firebaseapp.com',
    storageBucket: 'delivery-app-c7be9.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDbonn6VEvIFDU4HkDMRBbWspYoFzl6Xns',
    appId: '1:969447912901:android:7351dad3a342c5c52b87ac',
    messagingSenderId: '969447912901',
    projectId: 'delivery-app-c7be9',
    storageBucket: 'delivery-app-c7be9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD5GUUhPq5m7o5R7mObuZmIotQJYXnHxqQ',
    appId: '1:969447912901:ios:199ac951fbf5049e2b87ac',
    messagingSenderId: '969447912901',
    projectId: 'delivery-app-c7be9',
    storageBucket: 'delivery-app-c7be9.appspot.com',
    iosClientId: '969447912901-i8lb5j31annv0c037ju8re84efejp4ms.apps.googleusercontent.com',
    iosBundleId: 'com.example.delivery',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD5GUUhPq5m7o5R7mObuZmIotQJYXnHxqQ',
    appId: '1:969447912901:ios:199ac951fbf5049e2b87ac',
    messagingSenderId: '969447912901',
    projectId: 'delivery-app-c7be9',
    storageBucket: 'delivery-app-c7be9.appspot.com',
    iosClientId: '969447912901-i8lb5j31annv0c037ju8re84efejp4ms.apps.googleusercontent.com',
    iosBundleId: 'com.example.delivery',
  );
}
