import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/presentation/providers/actors/actors_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsByMovieProvider = StateNotifierProvider<ActorMapNotifier, Map<String, List<Actor>>>(
  (ref) {
    final actorRepository = ref.watch(actorsRepositoryProvider);
    return ActorMapNotifier(getActors: actorRepository.getActorsByMovie);
  },
);



typedef GetActorCallback = Future<List<Actor>> Function(String movieId);


class ActorMapNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorCallback getActors;

  ActorMapNotifier({required this.getActors}) : super({});

  Future<void> loadActors(String movieId) async {
    if ( state[movieId] != null ) return;

    final List<Actor> actors  = await getActors(movieId);
    state = {...state, movieId: actors };
  }
}
