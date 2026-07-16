import 'package:flutter/material.dart';

import '../screens/add_screen.dart';
import '../screens/login_screen.dart';
import '../screens/main_tab_screen.dart';
import '../screens/register_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
  static const add = '/add';

  static Map<String, WidgetBuilder> get routes {
    return {
      login: (_) => const LoginScreen(),
      register: (_) => const RegisterScreen(),
      home: (_) => const MainTabScreen(),
      add: (_) => const AddScreen(),
    };
  }
}
