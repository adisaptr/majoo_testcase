import 'package:flutter/material.dart';

import '../../domain/entities/movies.dart';

class DetailPage extends StatelessWidget {
  final Movies movies;
  const DetailPage({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          movies.originalName,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Image.network(
                  "https://image.tmdb.org/t/p/w500" + movies.posterPath,
                  fit: BoxFit.cover,
                  width: 250,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(movies.name,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                  children: [
                    TextSpan(
                        text: movies.firstAirDate.substring(0, 4) +
                            ' (${movies.voteAverage}'),
                    WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: Icon(
                          Icons.star_half_rounded,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                    TextSpan(text: ')'),
                  ],
                ),
              ),
              Text('Popularity : ${movies.popularity}',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${movies.overview}',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
