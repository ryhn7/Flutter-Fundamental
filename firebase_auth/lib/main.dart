import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'pages/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyD9T5G2UloZ_2vmo18jvwGNA06gIdnraK0", 
      appId: "1:35990779797:android:f2c5b663cd5855bed1e89c",
      messagingSenderId: "35990779797",
      projectId: "crud-firestore-63101",
      )
  );


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const AnonSignInPage(),
    );
  }
}
