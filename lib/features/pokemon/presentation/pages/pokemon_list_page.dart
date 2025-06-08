import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/pokemon_list_bloc.dart';
import '../bloc/pokemon_list_event.dart';
import '../bloc/pokemon_list_state.dart';
import '../widgets/pokemon_card.dart';
import 'pokemon_detail_page.dart';

class PokemonListPage extends StatelessWidget {
  const PokemonListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Список покемонов')),
      body: BlocBuilder<PokemonListBloc, PokemonListState>(
        builder: (context, state) {
          if (state is PokemonListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PokemonListLoaded) {
            return ListView.builder(
              itemCount: state.pokemonList.length,
              itemBuilder: (context, index) {
                final pokemon = state.pokemonList[index];
                return PokemonCard(
                  pokemon: pokemon,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => PokemonDetailPage(
                              url: pokemon.detailUrl,
                              repository:
                                  context.read<PokemonListBloc>().repository,
                            ),
                      ),
                    );
                  },
                );
              },
            );
          } else if (state is PokemonListError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
