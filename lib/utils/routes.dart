// utils/routes.dart
import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/admin/admin_home.dart';
import '../screens/user/user_home.dart';
import '../screens/profile_screen.dart';
import '../screens/admin/AdminRegisterScreen.dart';

Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => LoginScreen(), // Ruta inicial
  '/home': (context) => HomeScreen(),
  '/admin': (context) => AdminHomeScreen(),
  '/user': (context) => UserHomeScreen(),
  '/profile': (context) => ProfileScreen(),
  '/register': (context) => RegisterScreen(), // Ruta de registro
  '/login': (context) => LoginScreen(), // Ruta de inicio de sesión
  '/admin_register': (context) => AdminRegisterScreen(),
};
