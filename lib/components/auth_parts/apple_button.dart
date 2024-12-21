import 'package:flutter/material.dart';

class AppleButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AppleButton({
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.black, // Black background for Apple button
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // Smooth corners
            ),
          elevation: 4, // Slight shadow for depth
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          minimumSize: const Size(double.infinity, 16), // Full-width button
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              "https://upload.wikimedia.org/wikipedia/commons/thumb/3/31/Apple_logo_white.svg/505px-Apple_logo_white.svg.png?20220821122232", // Apple logo
              width: 20,
              height: 20, // Maintain aspect ratio
            ),
            const SizedBox(width: 16), // Space between icon and text
            const Text(
              'Sign in with Apple',
              style: TextStyle(
                color: Colors.white, // White text on black button
                fontSize: 16,
                fontWeight: FontWeight.w600, // Slightly bolder text
              ),
            ),
          ],
        ),
      ),
    );
  }
}
