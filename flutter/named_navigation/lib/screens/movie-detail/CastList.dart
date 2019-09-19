import 'package:flutter/material.dart';
import 'package:named_navigation/appcostat.dart';
import 'package:named_navigation/common/service_locator.dart';
import 'package:named_navigation/model/mymdb_movie.dart';
import 'package:named_navigation/screens/peopleinfo/peopleinfo.dart';
import 'package:named_navigation/service/movieservice/movie_service.dart';

class CastList extends StatefulWidget {
  final int movieId;
  final MyMDBType type;

  CastList({@required this.movieId, @required this.type});

  @override
  _CastListState createState() => _CastListState();
}

class _CastListState extends State<CastList>
    with AutomaticKeepAliveClientMixin<CastList> {
  MovieService service = locator<MovieService>();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
      future: (widget.type == MyMDBType.MOVIE)
          ? service.getMovieCast(widget.movieId)
          : service.getTvCast(widget.movieId),
      builder: (BuildContext context, AsyncSnapshot snapShot) {
        List<MyMDBCast> castList = snapShot.data;
        if (castList == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView(
            children: ListTile.divideTiles(
                context: context,
                tiles: castList.map(
                  (cast) => Hero(
                      tag: cast.profilePath,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(cast.profilePath),
                        ),
                        title: Text(
                          cast.name,
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(cast.character,
                            style: TextStyle(color: Colors.white54)),
                        onTap: () {
                          Navigator.pushNamed(context, PeopleInfo.PATH,
                              arguments: cast);
                        },
                      )),
                )).toList(),
          );
        }
      },
    );
  }
}
