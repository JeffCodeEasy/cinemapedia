import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/delegates/search_movie_delegate.dart';
import 'package:cinemapedia/presentation/providers/movies.dart';
import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;
    final size = MediaQuery.of(context).size;
    final isDarkMode = ref.watch(themeNotifierProvider).isDarkMode;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  ref.read(themeNotifierProvider.notifier).changeDarkMode();
                },
                icon: isDarkMode
                    ? Icon(
                        Icons.dark_mode_outlined,
                        color: colors.primary,
                      )
                    : Icon(
                        Icons.light_mode_outlined,
                        color: colors.primary,
                      ),
              ),
              SizedBox(width: size.width * 0.2),
              Icon(Icons.movie_outlined, color: colors.primary),
              const SizedBox(width: 5),
              Text('Cinemapedia', style: titleStyle),
              const Spacer(),
              IconButton(
                onPressed: () async {
                  final searchedMovies = ref.read(searchedMoviesProvider);
                  final searchQuery = ref.read(searchQueryProvider);
                  final movie = await showSearch<Movie?>(
                    query: searchQuery,
                    context: context,
                    delegate: SearchMovieDelegate(
                      initialMovies: searchedMovies,
                      searchMovies: ref
                          .read(searchedMoviesProvider.notifier)
                          .searchMoviesByQuery,
                    ),
                  );

                  if (!context.mounted || movie == null) return;

                  context.goNamed(
                    MovieScreen.name,
                    pathParameters: {'id': movie.id.toString()},
                  );
                },
                icon: Icon(
                  Icons.search,
                  color: colors.primary,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
