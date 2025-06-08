import 'package:flutter/material.dart';
import '../../domain/entities/pokemon_entity.dart';

class PokemonCard extends StatelessWidget {
  final PokemonEntity pokemon;
  final VoidCallback onTap;

  const PokemonCard({
    required this.pokemon,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(pokemon.imageUrl),
          backgroundColor: Colors.transparent,
        ),
        title: Text(pokemon.name.toUpperCase(),
            style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
