import 'package:equatable/equatable.dart';

abstract class PokemonListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadPokemonList extends PokemonListEvent {}
