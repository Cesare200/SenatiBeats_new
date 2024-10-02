import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String _nombre = '';
  String _apellidos = '';
  int _edad = 0;
  String _genero = '';
  String _email = '';
  String _password = '';

  // Función de validación para la contraseña
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingresa tu contraseña';
    }
    if (value.length < 8) {
      return 'La contraseña debe tener al menos 8 caracteres';
    }
    // Validar al menos un número y un carácter especial
    if (!RegExp(r'(?=.*[0-9])(?=.*[!@#$%^&*])').hasMatch(value)) {
      return 'La contraseña debe contener al menos un número y un carácter especial';
    }
    return null; // La contraseña es válida
  }

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      // Crear usuario en Firebase Authentication
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );

      // Guardar datos en Firestore
      await FirebaseFirestore.instance.collection('usuarios').add({
        'nombre': _nombre,
        'apellidos': _apellidos,
        'edad': _edad,
        'género': _genero,
        'email': _email,
        'fecha_de_creación': FieldValue.serverTimestamp(),
      });

      // Redirigir o mostrar mensaje de éxito
      Navigator.of(context).pop(); // Regresar a la pantalla de login
    }
  }

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
        'password':
            _password, // Asegúrate de encriptar la contraseña si decides guardarla
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
        title: Text('Registro'),
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
                decoration: InputDecoration(labelText: 'Edad'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu edad';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _edad = int.tryParse(value) ?? 0;
                  });
                },
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Género'),
                items: ['Masculino', 'Femenino', 'Otro']
                    .map(
                        (gen) => DropdownMenuItem(value: gen, child: Text(gen)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _genero = value!;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Por favor selecciona tu género';
                  }
                  return null;
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
                validator: _validatePassword, // Usar la función de validación
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _register,
                child: Text('Registrarse'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
