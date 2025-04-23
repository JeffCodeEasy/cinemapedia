import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infraestructure/models/moviedb/credits_response.dart';

class ActorMapper {
  static Actor castToEntity(Cast cast) => Actor(
        id: cast.id,
        name: cast.name,
        profilePath: cast.profilePath != null
            ? cast.profilePath!
            : 'https://i.pinimg.com/originals/fc/d7/9b/fcd79bf587e71a87aff95de232c74cd2.jpg',
        character: cast.character,
      );
}
