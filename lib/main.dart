import 'package:flutter/material.dart';
import 'package:music_level/pages/auth_page.dart';

void main() {
  Client client = Client();

  client
    .setEndpoint('https://cloud.appwrite.io/v1') // Your Appwrite Endpoint
    .setProject('5e8cf4f46b5e8')
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Level',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      initialRoute: '/auth', // Set initial route to Login page
      routes: {
        '/auth': (context) => const AuthPage(),
      },
    );
  }
}
