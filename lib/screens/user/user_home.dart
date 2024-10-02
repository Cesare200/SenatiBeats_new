import 'package:flutter/material.dart';

class UserHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SenatiBeats - Usuario'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bienvenido a SenatiBeats, Usuario',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Aquí puedes agregar la funcionalidad de reproducir música
              },
              child: Text('Explorar Música'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navegar a la pantalla de perfil
                Navigator.pushNamed(context, '/profile');
              },
              child: Text('Ver Perfil'),
            ),
          ],
        ),
      ),
    );
  }
}
