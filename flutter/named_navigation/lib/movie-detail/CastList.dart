import 'package:flutter/material.dart';
import 'package:named_navigation/model/MovieCast.dart';
import 'package:named_navigation/appcostat.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:named_navigation/tmdbconfig.dart';

class CastList extends StatefulWidget {
  final int movieId;

  CastList({@required this.movieId});

  @override
  _CastListState createState() => _CastListState();
}

class _CastListState extends State<CastList>
    with AutomaticKeepAliveClientMixin<CastList> {
  Future<List<Cast>> _loadingCasts;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _loadingCasts = getCastList(); // only create the future once.
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
      future: getCastList(),
      builder: (BuildContext context, AsyncSnapshot snapShot) {
        List<Cast> castList = snapShot.data;
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
                          Navigator.pushNamed(context, PEOPLE_DETAIL,
                              arguments: cast);
                        },
                      )),
                )).toList(),
          );
        }
      },
    );
  }

  Future<List<Cast>> getCastList() async {
    var casturl = TMDB_BASE_URL +
        'movie/${widget.movieId}/credits?api_key=' +
        TMDB_APIKEY;

    var castresdata = await http.get(casturl);
    var castdecodedJson = jsonDecode(castresdata.body);
    MovieCast castInfo = MovieCast.fromJson(castdecodedJson);
    print('MovieCast parsed $castInfo');
    List<Cast> castList = new List();
    castInfo.cast.forEach((cast) {
      if (cast.profilePath != null) {
        cast.profilePath = (cast.profilePath.contains('w185'))
            ? cast.profilePath
            : TmdbConfig.baseUrl + 'w185' + cast.profilePath;
        castList.add(cast);
      }
    });
    print('cast list returnig $castList');
    return castList;
  }
}
