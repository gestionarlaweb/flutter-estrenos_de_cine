import 'package:flutter/material.dart';
import 'package:trailers/src/models/pelicula_model.dart';
import 'package:trailers/src/providers/peliculas_provider.dart';
import 'package:trailers/src/utils/constants.dart';

class BuscadorDelegate extends SearchDelegate {
  // Para el buildSuggestions
  final peliculasProvider = new PeliculasProvider();

  String seleccion = '';
  final peliculas = [];
  final peliculasRecientes = [];

// Acciones de nuestro AppBar, por ejemplo el asterisco o el cancelar
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

// Icono a la izquierda del Appbar, por ejemplo el icono de regresar
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

// Crea los resultados que vamos a mostrar
  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.amberAccent,
        child: Text(seleccion),
      ),
    );
  }

// Sugerencias al escribir
  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }
    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if (snapshot.hasData) {
          final peliculas = snapshot.data;
          return ListView(
              children: peliculas.map((peli) {
            return ListTile(
              leading: FadeInImage(
                image: NetworkImage(peli.getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                width: 50.0,
                fit: BoxFit.contain,
              ),
              title: Text(
                peli.title,
                style: kTextPopulares,
              ),
              subtitle: Text(peli.originalTitle, style: kTextTarjetHorizontal),
              onTap: () {
                close(context, null);
                // El tag no puede ser null
                peli.uniqueId = '';
                Navigator.pushNamed(context, 'detalle', arguments: peli);
              },
            );
          }).toList());
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  // CÓDIGO DE MUESTRA
  // @override
  // Widget buildSuggestions(BuildContext context) {
  //   final listaSugerida = (query.isEmpty)
  //       ? peliculasRecientes
  //       : peliculas
  //           .where((element) =>
  //               element.toLowerCase().startsWith(query.toLowerCase()))
  //           .toList();

  //   return ListView.builder(
  //     itemCount: listaSugerida.length,
  //     itemBuilder: (context, i) {
  //       return ListTile(
  //         leading: Icon(Icons.movie),
  //         title: Text(listaSugerida[i]),
  //         onTap: () {
  //           seleccion = listaSugerida[i];
  //           // Contruye los resultados
  //           showResults(context);
  //         },
  //       );
  //     },
  //   );
  // }
}
