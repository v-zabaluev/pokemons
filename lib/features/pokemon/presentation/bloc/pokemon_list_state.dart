import 'package:equatable/equatable.dart';
import '../../domain/entities/pokemon_entity.dart';

abstract class PokemonListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PokemonListInitial extends PokemonListState {}

class PokemonListLoading extends PokemonListState {}

class PokemonListLoaded extends PokemonListState {
  final List<PokemonEntity> pokemonList;

  PokemonListLoaded(this.pokemonList);

  @override
  List<Object?> get props => [pokemonList];
}

class PokemonListError extends PokemonListState {
  final String message;

  PokemonListError(this.message);

  @override
  List<Object?> get props => [message];
}
