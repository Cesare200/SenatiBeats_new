import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminRegisterScreen extends StatefulWidget {
  @override
  _AdminRegisterScreenState createState() => _AdminRegisterScreenState();
}

class _AdminRegisterScreenState extends State<AdminRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String _nombre = '';
  String _apellidos = '';
  String _email = '';
  String _password = '';

  Future<void> _registerAdmin() async {
    if (_formKey.currentState!.validate()) {
      // Crear usuario en Firebase Authentication
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );

      // Guardar datos en la colección 'Administradores'
      await FirebaseFirestore.instance.collection('Administradores').add({
        'email': _email,
        'nombre': _nombre,
        'apellidos': _apellidos,
      });

      // Redirigir o mostrar mensaje de éxito
      Navigator.of(context).pop(); // Regresar a la pantalla de login
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Administrador'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu nombre';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _nombre = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Apellidos'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tus apellidos';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _apellidos = value;
                  });
                },
              ),
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
              TextFormField(
                decoration: InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu contraseña';
                  } else if (value.length < 8) {
                    return 'La contraseña debe tener al menos 8 caracteres';
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
                onPressed: _registerAdmin,
                child: Text('Registrar Administrador'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
