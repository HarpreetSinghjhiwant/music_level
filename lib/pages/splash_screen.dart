import 'package:flutter/material.dart';
import 'package:music_level/services/appwrite_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AppwriteService appwriteService = AppwriteService();

  @override
  void initState() {
    // _navigateBasedOnUserStatus();
    appwriteService.checkSession().then((value) {
      if (value) {
        Navigator.pushReplacementNamed(context, '/');
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
    super.initState();
  }

  Future<void> _navigateBasedOnUserStatus() async {
    try {
      final user = await appwriteService.getCurrentUser();
      if (!mounted) return; // Ensure context is still valid
      if (user != null) {
        Navigator.pushReplacementNamed(context, '/');
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (e) {
      // Handle errors gracefully
      print('Error during navigation: $e');
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/error'); // Optional error page
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                'assets/icon.jpg', // Ensure this path is correct
                width: MediaQuery.of(context).size.width * 0.45,
                height: MediaQuery.of(context).size.width * 0.45,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Music Level',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          const CircularProgressIndicator(color: Colors.white),
        ],
      ),
    );
  }
}
