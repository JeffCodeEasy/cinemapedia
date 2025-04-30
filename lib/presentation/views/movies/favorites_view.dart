import 'package:cinemapedia/presentation/providers/movies.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FavoritesView extends ConsumerStatefulWidget {
  static const name = 'favorites-view';
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
  bool isLoading = false;
  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    ref.read(favoriteMoviesProvider.notifier).loadNextPage();
  }

  void loadNextPage() async {
    if (isLoading || isLastPage) return;
    isLoading = true;

    final movies =
        await ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    isLoading = false;

    if (movies.isEmpty) {
      isLastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMovies = ref.watch(favoriteMoviesProvider).values.toList();
    final colors = Theme.of(context).colorScheme;
    if (favoriteMovies.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border_sharp, size: 60, color: colors.primary),
            Text('Ohh no!!',
                style: TextStyle(fontSize: 30, color: colors.primary)),
            const Text(
              'No tiene películas favoritas',
              style: TextStyle(fontSize: 20, color: Colors.black45),
            ),
            const SizedBox(height: 20),
            FilledButton.tonal(
                onPressed: () => context.go('/'),
                child: const Text('Empieza a buscar'))
          ],
        ),
      );
    }

    return Scaffold(
        body: MovieMansonry(
      movies: favoriteMovies,
      loadNextPage: loadNextPage,
    ));
  }
}
