import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:trailers/src/models/pelicula_model.dart';

class PeliculasProvider {
  String _apiKey = '28d6c51cb46f81f694274c2326fb5f3e';
  String _url = 'api.themoviedb.org';
  String _languaje = 'es-ES';

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    //print(decodedData);
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);
    print(peliculas.items[1].title);

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
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _languaje,
    });

    return await _procesarRespuesta(url);
  }
}
