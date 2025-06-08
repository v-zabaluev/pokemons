import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/pokemon_detail_bloc.dart';
import '../bloc/pokemon_detail_event.dart';
import '../bloc/pokemon_detail_state.dart';
import '../../data/repositories/pokemon_repository.dart';
import '../bloc/pokemon_list_bloc.dart';

class PokemonDetailPage extends StatelessWidget {
  final String url;
  final PokemonRepository repository;

  const PokemonDetailPage({
    required this.url,
    required this.repository,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PokemonDetailBloc(repository)..add(LoadPokemonDetail(url)),
      child: Scaffold(
        appBar: AppBar(title: const Text('Информация о покемоне')),
        body: BlocBuilder<PokemonDetailBloc, PokemonDetailState>(
          builder: (context, state) {
            if (state is PokemonDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PokemonDetailLoaded) {
              final p = state.detail;
              return SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(p.imageUrl, height: 200),
                        const SizedBox(height: 20),
                        Text(
                          p.name.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text('ID: ${p.id}'),
                        Text('Рост: ${p.height}'),
                        Text('Вес: ${p.weight}'),
                        Text('По умолчанию: ${p.isDefault ? 'Да' : 'Нет'}'),
                        const SizedBox(height: 20),
                        const Text(
                          'Способности',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ...p.abilities.map(
                          (ability) => Text(
                            ability,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else if (state is PokemonDetailError) {
              return Center(child: Text(state.message));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
