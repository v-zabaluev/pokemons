class PokemonDetailModel {
  final int id;
  final int height;
  final int weight;
  final String name;
  final String imageUrl;
  final bool isDefault;
  final List<String> abilities;

  PokemonDetailModel({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.imageUrl,
    required this.isDefault,
    required this.abilities,
  });

  factory PokemonDetailModel.fromJson(Map<String, dynamic> json) {
    return PokemonDetailModel(
      name: json['name'],
      height: json['height'],
      weight: json['weight'],
      imageUrl: json['sprites']['other']['official-artwork']['front_default'],
      id: json['id'],
      isDefault: json['is_default'],
      abilities:
          (json['abilities'] as List)
              .map((e) => e['ability']['name'] as String)
              .toList(),
    );
  }
}
