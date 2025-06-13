import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/pokemon/presentation/bloc/pokemon_list_bloc.dart';
import 'features/pokemon/data/datasources/pokemon_remote_data_source.dart';
import 'features/pokemon/data/repositories/pokemon_repository.dart';
import 'features/pokemon/presentation/bloc/pokemon_list_event.dart';
import 'features/pokemon/presentation/pages/pokemon_list_page.dart';
import 'package:dio/dio.dart';

class PokemonApp extends StatelessWidget {
  final DateTime startTime;
  const PokemonApp({required this.startTime, super.key});

  @override
  Widget build(BuildContext context) {
    final dio = Dio(BaseOptions(baseUrl: 'https://pokeapi.co/api/v2/'));
    final remoteDataSource = PokemonRemoteDataSource(dio);
    final repository = PokemonRepository(remoteDataSource);

    return MaterialApp(
      home: BlocProvider(
        create: (_) => PokemonListBloc(repository)..add(LoadPokemonList()),
        child: PokemonListPage(startTime: startTime),
      ),
    );
  }
}
