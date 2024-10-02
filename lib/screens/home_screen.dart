import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SenatiBeats - Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Bienvenido a SenatiBeats'),
            SizedBox(height: 20), // Espacio entre el texto y el botón
            ElevatedButton(
              onPressed: () {
                // Volver a la pantalla de inicio de sesión
                Navigator.of(context).pushReplacementNamed('/login');
              },
              child: Text('Regresar al Login'),
            ),
          ],
        ),
      ),
    );
  }
}
