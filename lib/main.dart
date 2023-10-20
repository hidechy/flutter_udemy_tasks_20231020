import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyBYf8HElbRXX1ZMiqhIrt4l6cx7dFh0PDg',
      authDomain: 'test20231003-74bb1.firebaseapp.com',
      projectId: 'test20231003-74bb1',
      storageBucket: 'test20231003-74bb1.appspot.com',
      messagingSenderId: '47719856047',
      appId: '1:47719856047:web:408fe9b51d71c644a1615a',
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}
