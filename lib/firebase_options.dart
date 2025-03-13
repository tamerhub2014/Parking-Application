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
    apiKey: 'AIzaSyDK7BSkvGqSbTlfcgWp1c-Gryii7QIQTyM',
    appId: '1:387760850481:web:2881b25ea6f5a459acf710',
    messagingSenderId: '387760850481',
    projectId: 'parking-lot-25ada',
    authDomain: 'parking-lot-25ada.firebaseapp.com',
    storageBucket: 'parking-lot-25ada.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBOIn-md-UB_z_JSquXQxBVWfxLUXvBMvE',
    appId: '1:387760850481:android:26854504a91930cfacf710',
    messagingSenderId: '387760850481',
    projectId: 'parking-lot-25ada',
    storageBucket: 'parking-lot-25ada.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB19_n7gaN6blu4RnjQEuN6pxLe2twzwk0',
    appId: '1:387760850481:ios:13819c158656a99aacf710',
    messagingSenderId: '387760850481',
    projectId: 'parking-lot-25ada',
    storageBucket: 'parking-lot-25ada.firebasestorage.app',
    iosBundleId: 'com.example.flutterParkingUiNew',
  );
}
