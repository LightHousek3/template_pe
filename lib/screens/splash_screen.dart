import 'package:flutter/material.dart';

import '../routes/app_routes.dart';
import '../services/session_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _sessionService = SessionService();

  @override
  void initState() {
    super.initState();
    _openInitialScreen();
  }

  Future<void> _openInitialScreen() async {
    final userId = await _sessionService.getUserId();
    if (!mounted) return;

    Navigator.pushReplacementNamed(
      context,
      userId == null ? AppRoutes.login : AppRoutes.home,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
