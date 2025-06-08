class PokemonDetailEntity {
  final String name;
  final int height;
  final int weight;
  final String imageUrl;
  final int id;
  final bool isDefault;
  final List<String> abilities;

  PokemonDetailEntity({
    required this.name,
    required this.height,
    required this.weight,
    required this.imageUrl,
    required this.id,
    required this.isDefault,
    required this.abilities,
  });
}
