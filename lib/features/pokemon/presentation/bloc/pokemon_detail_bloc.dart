import 'package:flutter_bloc/flutter_bloc.dart';
import 'pokemon_detail_event.dart';
import 'pokemon_detail_state.dart';
import '../../data/repositories/pokemon_repository.dart';

class PokemonDetailBloc extends Bloc<PokemonDetailEvent, PokemonDetailState> {
  final PokemonRepository repository;

  PokemonDetailBloc(this.repository) : super(PokemonDetailInitial()) {
    on<LoadPokemonDetail>((event, emit) async {
      emit(PokemonDetailLoading());
      try {
        final detail = await repository.getPokemonDetail(event.url);
        emit(PokemonDetailLoaded(detail));
      } catch (e, stacktrace) {
        print('Ошибка при получении деталей покемона: $e');
        print('Стек вызовов: $stacktrace');
        emit(PokemonDetailError('Ошибка загрузки подробной информации о покемоне' ));
      }
    });
  }
}
