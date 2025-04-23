import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movie_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesProvider, List<Movie>>(
  (ref) {
    final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;
    return MoviesProvider(fetchMoreMovies: fetchMoreMovies);
  },
);


final popularMoviesProvider =
    StateNotifierProvider<MoviesProvider, List<Movie>>(
  (ref) {
    final fetchMoreMovies = ref.watch(movieRepositoryProvider).getPopular;
    return MoviesProvider(fetchMoreMovies: fetchMoreMovies);
  },
);

final upcomingMoviesProvider =
    StateNotifierProvider<MoviesProvider, List<Movie>>(
  (ref) {
    final fetchMoreMovies = ref.watch(movieRepositoryProvider).getUpcoming;
    return MoviesProvider(fetchMoreMovies: fetchMoreMovies);
  },
);

final topRatedMoviesProvider =
    StateNotifierProvider<MoviesProvider, List<Movie>>(
  (ref) {
    final fetchMoreMovies = ref.watch(movieRepositoryProvider).getTopRated;
    return MoviesProvider(fetchMoreMovies: fetchMoreMovies);
  },
);



typedef MovieCallBack = Future<List<Movie>> Function({int page});


class MoviesProvider extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  bool isLoading = false;
  MovieCallBack fetchMoreMovies;

  MoviesProvider({
    required this.fetchMoreMovies,
  }) : super([]);

  Future<void> loadNextPage() async {
    if (isLoading) return;
    isLoading = true;

    currentPage++;
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    state = [...state, ...movies];

    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }
}
