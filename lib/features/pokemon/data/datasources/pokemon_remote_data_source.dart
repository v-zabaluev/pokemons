import 'package:dio/dio.dart';
import '../models/pokemon_list_item_model.dart';
import '../models/pokemon_detail_model.dart';

class PokemonRemoteDataSource {
  final Dio dio;

  PokemonRemoteDataSource(this.dio);

  Future<List<PokemonListItemModel>> fetchPokemonList() async {
    final response = await dio.get('pokemon?limit=50');
    final results = response.data['results'] as List;
    return results.map((json) => PokemonListItemModel.fromJson(json)).toList();
  }

  Future<PokemonDetailModel> fetchPokemonDetail(String url) async {
    final response = await dio.get(url);
    return PokemonDetailModel.fromJson(response.data);
  }
}
