import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBp5BA9-NGUiudoWgae-Sj1hSPXuWQmo50",
            authDomain: "mhafu-a5ea5.firebaseapp.com",
            projectId: "mhafu-a5ea5",
            storageBucket: "mhafu-a5ea5.appspot.com",
            messagingSenderId: "1069789379278",
            appId: "1:1069789379278:web:892d2525154156e602ae9f",
            measurementId: "G-C18ZJ6QZEC"));
  } else {
    await Firebase.initializeApp();
  }
}
