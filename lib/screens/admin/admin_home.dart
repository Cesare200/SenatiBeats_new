import 'package:flutter/material.dart';

class AdminHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Panel de Administración'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Administrador - Gestiona Música y Usuarios'),
            ElevatedButton(
              onPressed: () {
                // Aquí podrías navegar a la gestión de música
              },
              child: Text('Gestionar Música'),
            ),
            ElevatedButton(
              onPressed: () {
                // Aquí podrías navegar a la gestión de usuarios
              },
              child: Text('Gestionar Usuarios'),
            ),
          ],
        ),
      ),
    );
  }
}
