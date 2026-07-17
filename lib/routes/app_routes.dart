import 'package:flutter/material.dart';

import '../screens/add_screen.dart';
import '../screens/main_tab_screen.dart';

class AppRoutes {
  AppRoutes._();

  // NO-AUTH TEMPLATE: login/register khong nam trong flow chinh.
  // Neu de yeu cau auth, quay ve commit truoc hoac them lai route builder tai day.
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
  static const add = '/add';

  static Map<String, WidgetBuilder> get routes {
    return {home: (_) => const MainTabScreen(), add: (_) => const AddScreen()};
  }
}
