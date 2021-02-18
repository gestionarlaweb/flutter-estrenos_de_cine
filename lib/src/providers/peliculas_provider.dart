import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:trailers/src/models/actores_model.dart';
import 'dart:convert';

import 'package:trailers/src/models/pelicula_model.dart';

class PeliculasProvider {
  String _apiKey = '28d6c51cb46f81f694274c2326fb5f3e';
  String _url = 'api.themoviedb.org';
  String _languaje = 'es-ES';

  int _popularesPage = 0;
  bool _cargando = false;

  List<Pelicula> _populares = [];

  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();

  // Entrada PeliculasProvider.popularesSink
  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add;
  // Salida PeliculasProvider.popularesStream
  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream;

  void disposeStreams() {
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    //print(decodedData);
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);
    print(peliculas.items[9].title);

    return peliculas.items;
  }

// GET /movie/now_playing
  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _languaje,
    });

    return await _procesarRespuesta(url);
  }

  // GET /movie/popular
  Future<List<Pelicula>> getPopulares() async {
    if (_cargando) return []; // Si estoy cargando datos no me recargues nada
    _cargando = true;
    _popularesPage++;
    print('Cargando la siguiente página');

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _languaje,
      'page': _popularesPage.toString(),
    });

    final resp = await _procesarRespuesta(url);
    _populares.addAll(resp);
    popularesSink(_populares);

    _cargando = false;
    return resp;
  }

  // GET /movie/{movie_id}/credits
  Future<List<Actor>> getCast(String peliId) async {
    final url = Uri.https(_url, '3/movie/$peliId/credits', {
      'api_key': _apiKey,
      'language': _languaje,
    });
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final cast = new Cast.fromJsonList(decodedData['cast']);
    return cast.actores;
  }

  // GET movie/{movie_id}/videos
  // Future<List<Pelicula>> getVideos() async {
  //   final url = Uri.https(_url, '3/movie/13/videos', {
  //     'api_key': _apiKey,
  //     'language': _languaje,
  //   });

  //   return await _procesarRespuesta(url);
  // }
}
