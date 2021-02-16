import 'package:flutter/material.dart';
import 'package:trailers/src/models/pelicula_model.dart';
import 'package:trailers/src/utils/constants.dart';

class PeliculaDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Center(
        child: Text(
          'Pelicula: ${pelicula.title}',
          style: kTextTarjetHorizontal,
        ),
      ),
    );
  }
}
