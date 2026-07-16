import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: const Color(0xFFE0F7F4),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.museum, color: Color(0xFF00897B)),
        ),
        const SizedBox(height: 10),
        const Text(
          'Art Gallery Manager',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 3),
        Text(
          'Sign in to manage your private local gallery',
          style: TextStyle(color: Colors.grey.shade600, fontSize: 11),
        ),
      ],
    );
  }
}
