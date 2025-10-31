import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDMfbz8YbIYeC1xj2gpecXD9eiFOr-bn2U",
            authDomain: "scripturly-bible-app.firebaseapp.com",
            projectId: "scripturly-bible-app",
            storageBucket: "scripturly-bible-app.firebasestorage.app",
            messagingSenderId: "559528678223",
            appId: "1:559528678223:web:027d30eb8d69169cd7eb3a",
            measurementId: "G-ZT9V3NPPBP"));
  } else {
    await Firebase.initializeApp();
  }
}
