import 'package:flutter/material.dart';
import 'package:named_navigation/model/mymdb_movie.dart';
import 'package:named_navigation/screens/movie-detail/movieDetail.dart';
import 'package:transparent_image/transparent_image.dart';

class MovieListRoll extends StatelessWidget {
  final List<MyMDBMovie> movieRollList;
  final String rollTitle;
  final bool isEmptySlot;

  MovieListRoll(
      {@required this.movieRollList,
      @required this.rollTitle,
      this.isEmptySlot});

  Widget movieCard(MyMDBMovie movie, BuildContext context) {
    return Stack(
      children: <Widget>[
        faddingImage(movie.posterImageUrl),
        ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, MovieDetail.PATH,
                      arguments: movie);
                },
                child: Container(
                  width: 150,
                  height: 220.0,
                ),
              ),
            ))
      ],
    );
  }

  Widget faddingImage(String url) {
    // return Container(
    //   width: 150.0,
    //      height: 220.0,
    //   child: Card(
    //     color: Colors.black12,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(8.0),
    //     ),
    //     child: FadeInImage.memoryNetwork(
    //       placeholder: kTransparentImage,
    //       image: url,
    //       fit: BoxFit.fill,
    //     ),
    //   ),
    // );
    return  ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: url,
        width:  150.0,
        height:  220.0,        
        fit: BoxFit.fill,
      ),
    );
  }

  Widget generateEmptySlot() {
    return Container(
      width: 150.0,
      child: Card(
        color: Colors.black12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Image.memory(kTransparentImage),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 5.0),
        child: Wrap(
          spacing: 20,
          children: <Widget>[
            Align(
              child: Text(
                rollTitle,
                style: Theme.of(context).textTheme.headline,
              ),
              alignment: Alignment.topLeft,
            ),
            Container(
              height: 220.0,
              child: ListView.builder(
                itemCount: (isEmptySlot) ? 10 : movieRollList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, position) {
                  return (isEmptySlot)
                      ? generateEmptySlot()
                      : movieCard(movieRollList[position], context);
                },
              ),
            )
          ],
        ));
  }
}
