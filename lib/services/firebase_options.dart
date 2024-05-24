import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';

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
    apiKey: 'Tu apikey',
    appId: 'Tu appid',
    messagingSenderId: 'tu messanginsenderid',
    projectId: 'tu projectID',
    authDomain: 'tu authdomain',
    storageBucket: 'tu storagebucket',
    measurementId: 'tu measurementID',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'Tu apikey',
    appId: 'Tu appid',
    messagingSenderId: 'tu messanginsenderid',
    projectId: 'tu projectID',
    storageBucket: 'tu storagebucket',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'Tu apikey',
    appId: 'Tu appid',
    messagingSenderId: 'tu messanginsenderid',
    projectId: 'tu projectID',
    storageBucket: 'tu storagebucket',
    iosBundleId: 'com.example.admiCpo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'Tu apikey',
    appId: 'Tu appid',
    messagingSenderId: 'tu messanginsenderid',
    projectId: 'tu projectID',
    storageBucket: 'tu storagebucket',
    iosBundleId: 'com.example.admiCpo',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'Tu apikey',
    appId: 'Tu appid',
    messagingSenderId: 'tu messanginsenderid',
    projectId: 'tu projectID',
    authDomain: 'tu authdomain',
    storageBucket: 'tu storagebucket',
    measurementId: 'tu measurementID',
  );
}
