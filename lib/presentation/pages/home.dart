import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../injection.dart';
import '../bloc/movie_cubit.dart';
import '../widgets/movie_card.dart';
import 'extra/error_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            'Movies',
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: false,
        ),
        body: buildMovies(context),
      ),
    );
  }

  BlocProvider<MovieCubit> buildMovies(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 5) / 3;
    final double itemWidth = size.width / 2;
    return BlocProvider(
      create: (context) => sl<MovieCubit>()..getMovie(),
      child: BlocBuilder<MovieCubit, MovieState>(
        builder: (context, state) {
          if (state is LoadedMovies) {
            return Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: GridView.count(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                crossAxisCount: 2,
                childAspectRatio: (itemWidth / itemHeight),
                children: List.generate(state.movies.length, (index) {
                  return MovieCard(
                    movies: state.movies[index],
                  );
                }),
              ),
            );
          } else if (state is Error) {
            return ErrorScreen(
              message: 'Tidak ada koneksi Internet',
              retryButton: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Home(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.refresh_sharp,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(strokeWidth: 10),
          );
        },
      ),
    );
  }
}
