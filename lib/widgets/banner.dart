import 'package:flutter/material.dart';

class AppBanner extends StatelessWidget {
  const AppBanner({super.key, required this.username});

  final String? username;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 105,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage("assets/images/arm.png"),
          fit: .cover,
        ),
        // gradient: const LinearGradient(
        //   colors: [Color(0xFF0E4B57), Color(0xFF13343D)],
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        // ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Positioned(
          //   right: -10,
          //   top: 12,
          //   child: Icon(
          //     Icons.palette,
          //     color: Colors.white.withValues(alpha: 0.16),
          //     size: 96,
          //   ),
          // ),
          // Positioned(
          //   right: 16,
          //   bottom: 12,
          //   child: Icon(
          //     Icons.filter_frames,
          //     color: Colors.amber.shade100.withValues(alpha: 0.65),
          //     size: 36,
          //   ),
          // ),
          Center(
            child: Padding(
              padding: EdgeInsets.all(14),
              child: Row(
                children: [
                  Icon(Icons.museum, color: Colors.white),
                  SizedBox(width: 12),
                  Text(
                    'Welcome ${username ?? 'Guest'}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: .w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
