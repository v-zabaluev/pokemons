import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/pokemon_list_bloc.dart';
import '../bloc/pokemon_list_event.dart';
import '../bloc/pokemon_list_state.dart';
import '../widgets/pokemon_card.dart';
import 'pokemon_detail_page.dart';

class PokemonListPage extends StatefulWidget {
  final DateTime startTime;

  const PokemonListPage({required this.startTime, super.key});

  @override
  State<PokemonListPage> createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  bool _measured = false;

  void _measureLoadTime() {
    final loadTime = DateTime.now().difference(widget.startTime);
    print('Полная загрузка приложения заняла: ${loadTime.inMilliseconds} мс');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Список покемонов')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Поиск покемона',
                border: OutlineInputBorder(),
              ),
              onChanged: (query) {
                context.read<PokemonListBloc>().add(SearchPokemonList(query));
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<PokemonListBloc, PokemonListState>(
              builder: (context, state) {
                if (state is PokemonListLoaded && !_measured) {
                  // Ждём окончания отрисовки
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _measureLoadTime();
                    _measured = true;
                  });
                }

                if (state is PokemonListLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is PokemonListLoaded) {
                  if (state.pokemonList.isEmpty) {
                    return const Center(child: Text('Ничего не найдено'));
                  }
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
                              builder: (_) => PokemonDetailPage(
                                url: pokemon.detailUrl,
                                repository: context
                                    .read<PokemonListBloc>()
                                    .repository,
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
          ),
        ],
      ),
    );
  }
}

