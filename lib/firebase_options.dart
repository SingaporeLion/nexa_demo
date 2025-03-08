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
    apiKey: 'AIzaSyBcqlp6pUhKJztN6qjoNbK04a8Sm7-qz7c',
    appId: '1:898772373587:web:d5f5c0d8fbcae0d85536a6',
    messagingSenderId: '898772373587',
    projectId: 'minelab-fa1b1',
    authDomain: 'minelab-fa1b1.firebaseapp.com',
    storageBucket: 'minelab-fa1b1.appspot.com',
    measurementId: 'G-747EFJTR7V',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCCYL-4efgU3T1Ivqsl8nsuJc7w6sCCOGc',
    appId: '1:898772373587:android:26c466a7751f83d55536a6',
    messagingSenderId: '898772373587',
    projectId: 'minelab-fa1b1',
    storageBucket: 'minelab-fa1b1.firebasestorage.app',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBcqlp6pUhKJztN6qjoNbK04a8Sm7-qz7c',
    appId: '1:898772373587:web:904882af9fa1464e5536a6',
    messagingSenderId: '898772373587',
    projectId: 'minelab-fa1b1',
    authDomain: 'minelab-fa1b1.firebaseapp.com',
    storageBucket: 'minelab-fa1b1.appspot.com',
    measurementId: 'G-DHRPGD4B8Y',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDiOQbzqYuPZ4ev4cyvtSijCFq8rHbHgxA',
    appId: '1:898772373587:ios:5119f54f29a8b6525536a6',
    messagingSenderId: '898772373587',
    projectId: 'minelab-fa1b1',
    storageBucket: 'minelab-fa1b1.firebasestorage.app',
    androidClientId: '898772373587-55ni4di8ql7auiscnsaqmo09e92q6rcm.apps.googleusercontent.com',
    iosClientId: '898772373587-st6rpq13j96d2mhtq8hgv3i7bmum40gd.apps.googleusercontent.com',
    iosBundleId: 'com.example.mineLab',
  );

}