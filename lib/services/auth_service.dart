class AuthService {
  // Método de ejemplo para simular autenticación
  static Future<bool> login(String email, String password) async {
    if (email == 'admin@senati.com' && password == 'admin123') {
      return true; // Administrador
    } else if (email == 'user@senati.com' && password == 'user123') {
      return false; // Usuario normal
    }
    return false; // Login fallido
  }
}
