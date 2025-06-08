import '../../domain/entities/pokemon_details_entity.dart';
import '../datasources/pokemon_remote_data_source.dart';
import '../../domain/entities/pokemon_entity.dart';

class PokemonRepository {
  final PokemonRemoteDataSource dataSource;

  PokemonRepository(this.dataSource);

  Future<List<PokemonEntity>> getPokemonList() async {
    final list = await dataSource.fetchPokemonList();
    final detailed = await Future.wait(list.map((item) async {
      final detail = await dataSource.fetchPokemonDetail(item.url);
      return PokemonEntity(
        id: detail.id,
        name: detail.name,
        imageUrl: detail.imageUrl,
        detailUrl: item.url,
      );
    }));
    return detailed;
  }

  Future<PokemonDetailEntity> getPokemonDetail(String url) async {
    final detail = await dataSource.fetchPokemonDetail(url);
    return PokemonDetailEntity(
      name: detail.name,
      height: detail.height,
      weight: detail.weight,
      imageUrl: detail.imageUrl,
      id: detail.id,
      isDefault: detail.isDefault,
      abilities: detail.abilities,
    );
  }
}
