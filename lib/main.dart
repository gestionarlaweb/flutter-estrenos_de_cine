import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trailers/src/pages/home_page.dart';
import 'package:trailers/src/pages/pelicula_detalle.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Evitar la horientación horizontal
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black87,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Estrenos',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        'detalle': (BuildContext context) => PeliculaDetalle(),
      },
    );
  }
}
