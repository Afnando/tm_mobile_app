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
    apiKey: 'AIzaSyBx8eANpQzZOmqLMbiVFWQxpeHe2d89GHo',
    appId: '1:61194771917:web:51e2320afc32f7be0d3884',
    messagingSenderId: '61194771917',
    projectId: 'tm-mobile-app-f5e2b',
    authDomain: 'tm-mobile-app-f5e2b.firebaseapp.com',
    storageBucket: 'tm-mobile-app-f5e2b.appspot.com',
    measurementId: 'G-FYXRQR145F',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAc5fmdgR-LU46MMwISBYpLnN7UsOgSDJM',
    appId: '1:61194771917:android:aa31495826e31e7b0d3884',
    messagingSenderId: '61194771917',
    projectId: 'tm-mobile-app-f5e2b',
    storageBucket: 'tm-mobile-app-f5e2b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAkG_RdsePvC_QZEfWV604suYs5qQychDg',
    appId: '1:61194771917:ios:44ba0468e67b592b0d3884',
    messagingSenderId: '61194771917',
    projectId: 'tm-mobile-app-f5e2b',
    storageBucket: 'tm-mobile-app-f5e2b.appspot.com',
    iosClientId: '61194771917-67hu22gj4mfcd9d6fiel8m4eb2h6urie.apps.googleusercontent.com',
    iosBundleId: 'com.example.tmMobileApp',
  );
}
