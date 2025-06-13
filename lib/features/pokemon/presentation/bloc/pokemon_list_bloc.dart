import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/pokemon_entity.dart';
import 'pokemon_list_event.dart';
import 'pokemon_list_state.dart';
import '../../data/repositories/pokemon_repository.dart';

class PokemonListBloc extends Bloc<PokemonListEvent, PokemonListState> {
  final PokemonRepository repository;
  List<PokemonEntity> _allPokemon = [];

  PokemonListBloc(this.repository) : super(PokemonListInitial()) {
    on<LoadPokemonList>((event, emit) async {

      emit(PokemonListLoading());
      final stopwatch = Stopwatch()..start();
      try {
        final list = await repository.getPokemonList();

        _allPokemon = list;
        emit(PokemonListLoaded(list));
      } catch (e, stacktrace) {
        print('Ошибка при получении покемонов: $e');
        print('Стек вызовов: $stacktrace');
        emit(PokemonListError('Ошибка загрузки списка покемонов'));
      }
      stopwatch.stop();
      print('Время загрузки (BLoC): ${stopwatch.elapsedMilliseconds} мс');
    });

    on<SearchPokemonList>((event, emit) {
      final query = event.query.toLowerCase();
      final filtered = _allPokemon
          .where((pokemon) => pokemon.name.toLowerCase().contains(query))
          .toList();
      emit(PokemonListLoaded(filtered));
    });
  }
}

