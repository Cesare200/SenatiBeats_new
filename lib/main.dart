import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Importa Firestore
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Inicializa Firebase aquí

  // Agregar datos de prueba a Firestore
  await addTestData();

  runApp(MyApp());
}

Future<void> addTestData() async {
  // Crear datos de prueba para usuarios
  await FirebaseFirestore.instance.collection('usuarios').add({
    'nombre': 'Juan',
    'apellidos': 'Pérez',
    'edad': 25,
    'género': 'Masculino',
    'fecha_de_creación': FieldValue.serverTimestamp(),
  });

  // Crear datos de prueba para música
  await FirebaseFirestore.instance.collection('musicas').add({
    'nombre': 'Canción de Prueba',
    'artista': 'Artista de Prueba',
    'álbum': 'Álbum de Prueba',
    'género': 'Pop',
    'tipo': 'local',
    'usuario_id':
        'user_123', // Cambia esto al ID real del usuario si es necesario
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Senati Beats',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Senati Beats'),
        ),
        body: Center(
          child: Text('Bienvenido a Senati Beats!'),
        ),
      ),
    );
  }
}
