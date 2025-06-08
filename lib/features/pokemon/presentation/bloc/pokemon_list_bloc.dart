import 'package:flutter_bloc/flutter_bloc.dart';
import 'pokemon_list_event.dart';
import 'pokemon_list_state.dart';
import '../../data/repositories/pokemon_repository.dart';

class PokemonListBloc extends Bloc<PokemonListEvent, PokemonListState> {
  final PokemonRepository repository;

  PokemonListBloc(this.repository) : super(PokemonListInitial()) {
    on<LoadPokemonList>((event, emit) async {
      emit(PokemonListLoading());
      try {
        final list = await repository.getPokemonList();
        emit(PokemonListLoaded(list));
      } catch (e, stacktrace) {
        print('Ошибка при получении покемонов: $e');
        print('Стек вызовов: $stacktrace');
        emit(PokemonListError('Ошибка загрузки списка покемонов'));
      }
    });
  }
}
