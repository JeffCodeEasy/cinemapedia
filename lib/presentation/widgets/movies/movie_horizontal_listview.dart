import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MovieHorizontalListview extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;

  const MovieHorizontalListview({
    super.key,
    required this.movies,
    this.title,
    this.subTitle,
    this.loadNextPage,
  });

  @override
  State<MovieHorizontalListview> createState() =>
      _MovieHorizontalListviewState();
}

class _MovieHorizontalListviewState extends State<MovieHorizontalListview> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(
      () {
        if (widget.loadNextPage == null) return;

        if ((scrollController.position.pixels + 200) >=
            scrollController.position.maxScrollExtent) {
          widget.loadNextPage!();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          if (widget.title != null || widget.subTitle != null)
            _Title(
              title: widget.title,
              subTitle: widget.subTitle,
            ),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: widget.movies.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return FadeInRight(
                  child: _Slides(
                    movie: widget.movies[index],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class _Slides extends StatelessWidget {
  final Movie movie;

  const _Slides({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      width: 150,
      child: Column(
        children: [
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                fit: BoxFit.cover,
                movie.posterPath,
                width: 150,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return GestureDetector(
                    onTap: () => context.push('/movie/${movie.id}'),
                    // onTap: () => context.goNamed(
                    //     MovieScreen.name,
                    //     pathParameters: {'id': movie.id.toString()},
                    //   ),
                    child: FadeIn(child: child),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: 150,
            child: Text(movie.title, maxLines: 2, style: textTheme.titleSmall),
          ),
          Row(
            children: [
              Icon(Icons.star_half_outlined, color: Colors.yellow.shade800),
              const SizedBox(width: 3),
              Text('${movie.voteAverage}',
                  style: textTheme.bodyMedium
                      ?.copyWith(color: Colors.yellow.shade800)),
              const Spacer(),
              Text(HumanFormats.number(movie.popularity),
                  style: textTheme.bodySmall)
            ],
          )
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subTitle;

  const _Title({this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if (title != null)
            Text(
              title!,
              style: titleStyle,
            ),
          const Spacer(),
          if (subTitle != null)
            FilledButton.tonal(
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
              onPressed: () {},
              child: Text(subTitle!),
            ),
        ],
      ),
    );
  }
}
