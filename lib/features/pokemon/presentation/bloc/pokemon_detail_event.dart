import 'package:equatable/equatable.dart';

abstract class PokemonDetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadPokemonDetail extends PokemonDetailEvent {
  final String url;

  LoadPokemonDetail(this.url);

  @override
  List<Object?> get props => [url];
}
