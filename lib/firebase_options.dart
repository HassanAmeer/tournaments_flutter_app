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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAKJarmFzAMMzkTQj2z29a3kqa_FKmxQVc',
    appId: '1:1087361185926:android:5321aae20e76c15c66f907',
    messagingSenderId: '1087361185926',
    projectId: 'turnierproto2',
    storageBucket: 'turnierproto2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD9Ho1o6iHvpiK_eXTnIwDMhA_zlQu21g0',
    appId: '1:1087361185926:ios:0697489087fbddaf66f907',
    messagingSenderId: '1087361185926',
    projectId: 'turnierproto2',
    storageBucket: 'turnierproto2.appspot.com',
    androidClientId:
        '1087361185926-dln07se9loqk46kik0cloa13i79obtlt.apps.googleusercontent.com',
    iosClientId:
        '1087361185926-18ioio389ookhp2ma68d844mhq93ssj1.apps.googleusercontent.com',
    iosBundleId: 'com.admin.turnier',
  );
}
