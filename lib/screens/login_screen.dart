import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Iniciar sesión
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);

        User? user = userCredential.user;

        // Verificar si el usuario está en la colección de administradores
        DocumentSnapshot adminSnapshot = await FirebaseFirestore.instance
            .collection('Administradores')
            .where('email', isEqualTo: _email)
            .get()
            .then((QuerySnapshot querySnapshot) {
          if (querySnapshot.docs.isNotEmpty) {
            return querySnapshot.docs.first;
          } else {
            // Retorna un DocumentSnapshot vacío o maneja el caso adecuadamente
            return FirebaseFirestore.instance
                .collection('Administradores')
                .doc('documento_inexistente')
                .get();
          }
        });

        if (adminSnapshot != null && adminSnapshot.exists) {
          // Si es administrador, redirigir a la pantalla de administrador
          Navigator.of(context).pushReplacementNamed('/admin');
        } else {
          // Verificar si el usuario está en la colección de usuarios
          DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
              .collection('usuarios')
              .where('email', isEqualTo: _email)
              .get()
              .then((QuerySnapshot querySnapshot) {
            if (querySnapshot.docs.isNotEmpty) {
              return querySnapshot.docs.first;
            } else {
              // Retorna un DocumentSnapshot vacío o maneja el caso adecuadamente
              return FirebaseFirestore.instance
                  .collection('usuarios')
                  .doc('documento_inexistente')
                  .get();
            }
          });

          if (userSnapshot != null && userSnapshot.exists) {
            // Si es usuario común, redirigir a la pantalla de usuario
            Navigator.of(context).pushReplacementNamed('/user');
          } else {
            // Si no se encuentra en ninguna colección
            print("Usuario no encontrado en ninguna colección");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Usuario no encontrado')),
            );
          }
        }
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al iniciar sesión')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio de Sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Campo para el correo
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu email';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              // Campo para la contraseña
              TextFormField(
                decoration: InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu contraseña';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: Text('Iniciar Sesión'),
              ),
              // Botón para ir a la pantalla de registro
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/register');
                },
                child: Text('¿No tienes una cuenta? Regístrate aquí'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
