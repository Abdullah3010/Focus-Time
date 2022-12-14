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
    apiKey: 'AIzaSyDArO4kzdfQ4VKftP7xDmX2BeSwAYU-SBQ',
    appId: '1:148422060929:web:5b74a71006dc3280855680',
    messagingSenderId: '148422060929',
    projectId: 'focus-time-27c9f',
    authDomain: 'focus-time-27c9f.firebaseapp.com',
    storageBucket: 'focus-time-27c9f.appspot.com',
    measurementId: 'G-YJKW8L6LPR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBB8amEQnV7u0Y443N_04rqBccV2X5o1xs',
    appId: '1:148422060929:android:eda070fac71fd165855680',
    messagingSenderId: '148422060929',
    projectId: 'focus-time-27c9f',
    storageBucket: 'focus-time-27c9f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAXwe1yswrJzwSeBoCG6UECCgOH77SjYDQ',
    appId: '1:148422060929:ios:5b73cb58fdfad7c3855680',
    messagingSenderId: '148422060929',
    projectId: 'focus-time-27c9f',
    storageBucket: 'focus-time-27c9f.appspot.com',
    iosClientId: '148422060929-bjj1s78v2lvqe7io5libiuo70mam7c4r.apps.googleusercontent.com',
    iosBundleId: 'com.example.focusTime',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAXwe1yswrJzwSeBoCG6UECCgOH77SjYDQ',
    appId: '1:148422060929:ios:5b73cb58fdfad7c3855680',
    messagingSenderId: '148422060929',
    projectId: 'focus-time-27c9f',
    storageBucket: 'focus-time-27c9f.appspot.com',
    iosClientId: '148422060929-bjj1s78v2lvqe7io5libiuo70mam7c4r.apps.googleusercontent.com',
    iosBundleId: 'com.example.focusTime',
  );
}
