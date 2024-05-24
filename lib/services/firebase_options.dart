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
    apiKey: 'AIzaSyCXh-trLNHmShwFIhA1A6wxRJaRI5GLUyc',
    appId: '1:386337423848:web:af27b9e05431265b23a45d',
    messagingSenderId: '386337423848',
    projectId: 'admi-cpo',
    authDomain: 'admi-cpo.firebaseapp.com',
    storageBucket: 'admi-cpo.appspot.com',
    measurementId: 'G-2H7LG5HS2E',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDJi-6QePkRd9p10Ck1QCCSZwuHMkyGspI',
    appId: '1:386337423848:android:746e2759f300026423a45d',
    messagingSenderId: '386337423848',
    projectId: 'admi-cpo',
    storageBucket: 'admi-cpo.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDevlI5tvM6Lm4G9A5pX7ujINDnK1hPzcA',
    appId: '1:386337423848:ios:8212d665c420673f23a45d',
    messagingSenderId: '386337423848',
    projectId: 'admi-cpo',
    storageBucket: 'admi-cpo.appspot.com',
    iosBundleId: 'com.example.admiCpo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDevlI5tvM6Lm4G9A5pX7ujINDnK1hPzcA',
    appId: '1:386337423848:ios:8212d665c420673f23a45d',
    messagingSenderId: '386337423848',
    projectId: 'admi-cpo',
    storageBucket: 'admi-cpo.appspot.com',
    iosBundleId: 'com.example.admiCpo',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCXh-trLNHmShwFIhA1A6wxRJaRI5GLUyc',
    appId: '1:386337423848:web:198a0256affb282823a45d',
    messagingSenderId: '386337423848',
    projectId: 'admi-cpo',
    authDomain: 'admi-cpo.firebaseapp.com',
    storageBucket: 'admi-cpo.appspot.com',
    measurementId: 'G-W8PN1FWFGT',
  );
}
