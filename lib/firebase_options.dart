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
    apiKey: 'AIzaSyD-8qjysVOVaLqz7xI7Wf1Ib2kOTfij3fc',
    appId: '1:590216398315:web:b28954a1f5e5496e32c5ae',
    messagingSenderId: '590216398315',
    projectId: 'cryptopulse-adold',
    authDomain: 'cryptopulse-adold.firebaseapp.com',
    storageBucket: 'cryptopulse-adold.firebasestorage.app',
    measurementId: 'G-S4Y8L2TBHT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB9xWtPvB-EP4Gv5AMn63CHI78Z4Zvsg8M',
    appId: '1:590216398315:android:1da3f0c67fc6f1ec32c5ae',
    messagingSenderId: '590216398315',
    projectId: 'cryptopulse-adold',
    storageBucket: 'cryptopulse-adold.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyACjRiAqpP4r5MCbANrTqfYOYW_xrxKm48',
    appId: '1:590216398315:ios:798506026cf57e1932c5ae',
    messagingSenderId: '590216398315',
    projectId: 'cryptopulse-adold',
    storageBucket: 'cryptopulse-adold.firebasestorage.app',
    iosBundleId: 'com.example.appproject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyACjRiAqpP4r5MCbANrTqfYOYW_xrxKm48',
    appId: '1:590216398315:ios:798506026cf57e1932c5ae',
    messagingSenderId: '590216398315',
    projectId: 'cryptopulse-adold',
    storageBucket: 'cryptopulse-adold.firebasestorage.app',
    iosBundleId: 'com.example.appproject',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD-8qjysVOVaLqz7xI7Wf1Ib2kOTfij3fc',
    appId: '1:590216398315:web:a1469b243acd579b32c5ae',
    messagingSenderId: '590216398315',
    projectId: 'cryptopulse-adold',
    authDomain: 'cryptopulse-adold.firebaseapp.com',
    storageBucket: 'cryptopulse-adold.firebasestorage.app',
    measurementId: 'G-6E2K4W6CDP',
  );
}
