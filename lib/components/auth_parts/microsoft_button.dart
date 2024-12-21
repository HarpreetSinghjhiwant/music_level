import 'package:flutter/material.dart';

class MicrosoftButton extends StatelessWidget {
  final VoidCallback onPressed;

  const MicrosoftButton({
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
          backgroundColor: Colors.black, // Button background color
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
              "https://cdn-icons-png.flaticon.com/512/732/732221.png", // Microsoft logo
              width: 20,
              height: 20, // Maintain aspect ratio
            ),
            const SizedBox(width: 16), // Space between icon and text
            const Text(
              'Sign in with Microsoft',
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
