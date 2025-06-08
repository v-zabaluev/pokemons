class PokemonListItemModel {
  final String name;
  final String url;

  PokemonListItemModel({required this.name, required this.url});

  factory PokemonListItemModel.fromJson(Map<String, dynamic> json) {
    return PokemonListItemModel(
      name: json['name'],
      url: json['url'],
    );
  }

  String get imageUrl {
    final id = Uri.parse(url).pathSegments.where((s) => s.isNotEmpty).last;
    return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';
  }
}
