import 'package:flutter/material.dart';

class CustomButtons extends StatelessWidget {
  final VoidCallback onPress;
  final String text;
  final Color color;
  final double radius; // Added radius parameter

  const CustomButtons({
    Key? key,
    required this.onPress,
    required this.text,
    required this.color,
    required this.radius, // Marked radius as required
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),),),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
