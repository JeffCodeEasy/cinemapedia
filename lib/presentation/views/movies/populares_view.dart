import 'package:cinemapedia/presentation/providers/movies.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_mansonry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PopularesView extends ConsumerWidget {
  static const name = 'populares-view';
  const PopularesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final popularMovies = ref.watch(popularMoviesProvider);

    if (popularMovies.isEmpty) {
      return const Center(child: CircularProgressIndicator(strokeWidth: 2));
    }

    return Scaffold(
      body: MovieMansonry(
        movies: popularMovies,
         loadNextPage: () => ref.read(popularMoviesProvider.notifier).loadNextPage(),
      ),
    );
  }
}
