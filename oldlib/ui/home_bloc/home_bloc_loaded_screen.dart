import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:majootestcase/models/movie_model.dart';

class HomeBlocLoadedScreen extends StatelessWidget {
  final List<Results> data;

  const HomeBlocLoadedScreen({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return movieItemWidget(data[index]);
        },
      ),
    );
  }

  Widget movieItemWidget(Results data) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0))),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(25),
            child: Image.network(
                "https://image.tmdb.org/t/p/w500/" + data.posterPath),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: Text(data.name, textDirection: TextDirection.ltr),
          )
        ],
      ),
    );
  }
}
