import 'package:flutter/material.dart';
import 'package:trailers/src/models/actores_model.dart';
import 'package:trailers/src/models/pelicula_model.dart';
import 'package:trailers/src/providers/peliculas_provider.dart';
import 'package:trailers/src/utils/constants.dart';

class PeliculaDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          // _crearAppbarSimple(pelicula),
          _crearAppbar(pelicula),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 10.0),
                _posterTitulo(pelicula),
                _descripcion(pelicula),
                _crearCastingActores(pelicula),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearAppbar(Pelicula pelicula) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.black54,
      expandedHeight: 260.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: FadeInImage(
          image: NetworkImage(pelicula.getBackgroundImg()),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(milliseconds: 350),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitulo(Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(pelicula.getPosterImg()),
                height: 150.0,
              ),
            ),
          ),
          SizedBox(width: 20.0),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(pelicula.title,
                  style: kTextAppBar, overflow: TextOverflow.ellipsis),
              SizedBox(
                height: 2.0,
              ),
              Text(pelicula.originalTitle,
                  style: kTextPopulares, overflow: TextOverflow.ellipsis),
              SizedBox(
                height: 2.0,
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.star_border,
                    color: Colors.amberAccent,
                  ),
                  SizedBox(
                    width: 4.0,
                  ),
                  Text(
                    pelicula.voteAverage.toString(),
                    style: kTextPopulares,
                  ),
                ],
              ),
              SizedBox(
                height: 2.0,
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.date_range_outlined,
                    color: Colors.amberAccent,
                  ),
                  SizedBox(
                    width: 4.0,
                  ),
                  Text(
                    pelicula.releaseDate,
                    style: kTextPopulares,
                  ),
                ],
              ),
              SizedBox(
                height: 2.0,
              ),
              // Genero
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 4.0,
                  ),
                ],
              ),
              generoPelicula(pelicula),
            ],
          ))
        ],
      ),
    );
  }

  generoPelicula(Pelicula pelicula) {
    List genero;

    genero = [pelicula.genreIds.first];

    if (genero.toString() == '[28]') {
      return Text(
        'Acción',
        style: kTextGenero,
      );
    } else if (genero.toString() == '[12]') {
      return Text(
        'Aventura',
        style: kTextGenero,
      );
    } else if (genero.toString() == '[16]') {
      return Text(
        'Animación',
        style: kTextGenero,
      );
    } else if (genero.toString() == '[35]') {
      return Text(
        'Comedia',
        style: kTextGenero,
      );
    } else if (genero.toString() == '[80]') {
      return Text(
        'Crimen',
        style: kTextGenero,
      );
    } else if (genero.toString() == '[99]') {
      return Text(
        'Documental',
        style: kTextGenero,
      );
    } else if (genero.toString() == '[18]') {
      return Text(
        'Drama',
        style: kTextGenero,
      );
    } else if (genero.toString() == '[10751]') {
      return Text(
        'Familia',
        style: kTextGenero,
      );
    } else if (genero.toString() == '[14]') {
      return Text(
        'Fantasía',
        style: kTextGenero,
      );
    } else if (genero.toString() == '[36]') {
      return Text(
        'Historia',
        style: kTextGenero,
      );
    } else if (genero.toString() == '[27]') {
      return Text(
        'Terror',
        style: kTextGenero,
      );
    } else if (genero.toString() == '[10402]') {
      return Text(
        'Música',
        style: kTextGenero,
      );
    } else if (genero.toString() == '[9648]') {
      return Text(
        'Misterio',
        style: kTextGenero,
      );
    } else if (genero.toString() == '[10749]') {
      return Text(
        'Romance',
        style: kTextGenero,
      );
    } else if (genero.toString() == '[878]') {
      return Text(
        'Ciencia ficción',
        style: kTextGenero,
      );
    } else if (genero.toString() == '[10770]') {
      return Text(
        'Película de Tv',
        style: kTextGenero,
      );
    } else if (genero.toString() == '[53]') {
      return Text(
        'Suspense',
        style: kTextGenero,
      );
    } else if (genero.toString() == '[10752]') {
      return Text(
        'Bélica',
        style: kTextGenero,
      );
    } else if (genero.toString() == '[37]') {
      return Text(
        'Western',
        style: kTextGenero,
      );
    }
  }

  Widget _descripcion(Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        pelicula.overview,
        style: kTextPopulares,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _crearCastingActores(Pelicula pelicula) {
    final peliProvider = new PeliculasProvider();
    return FutureBuilder(
      future: peliProvider.getCast(pelicula.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return _crearActoresPageView(snapshot.data);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _crearActoresPageView(List<Actor> actores) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(viewportFraction: 0.3, initialPage: 1),
        itemCount: actores.length,
        itemBuilder: (context, i) => _actorTarjeta(actores[i]),
      ),
    );
  }

  Widget _actorTarjeta(Actor actor) {
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(actor.getFoto()),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              height: 140.0,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            actor.name,
            style: kTextTarjetHorizontal,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
