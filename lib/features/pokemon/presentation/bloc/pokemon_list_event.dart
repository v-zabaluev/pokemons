import 'package:equatable/equatable.dart';

abstract class PokemonListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadPokemonList extends PokemonListEvent {}

class SearchPokemonList extends PokemonListEvent {
  final String query;

  SearchPokemonList(this.query);

  @override
  List<Object?> get props => [query];
}