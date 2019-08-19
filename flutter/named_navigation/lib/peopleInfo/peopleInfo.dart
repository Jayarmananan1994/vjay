import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:named_navigation/common/footer.dart';
import 'package:named_navigation/common/header.dart';
import 'dart:convert';

import 'package:named_navigation/model/MovieCast.dart';
import 'package:named_navigation/appcostat.dart';
import 'package:named_navigation/model/people.dart';

class PeopleInfo extends StatefulWidget {
  final Cast cast;
  PeopleInfo({@required this.cast});
  @override
  _PeopleInfoState createState() => _PeopleInfoState();
}

class _PeopleInfoState extends State<PeopleInfo> {
  bodyWidget(BuildContext context) => Stack(
    alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width - 20,
            left: 10.0,
            top: MediaQuery.of(context).size.height * 0.1,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(height: 90.0),
                  Text(
                    widget.cast.name,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Align(
              alignment: Alignment.topCenter,
              child: Hero(
                tag: widget.cast.profilePath,
                child: Container(
                  height: 150.0,
                  width: 150.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.cast.profilePath))),
                ),
              ))
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppHeader.getHeader('MyMDB'),
      backgroundColor: Theme.of(context).primaryColor,
      body: FutureBuilder(
        future: getPeopleDetail(widget.cast),
        builder: (BuildContext context, AsyncSnapshot snapShot) {
          Map result = snapShot.data;
          print('getPeopleDetail i got $result');
          if (result == null) {
           return bodyWidget(context);
          } else {
            return bodyWidget(context);
          }
        },
      ),
      bottomNavigationBar: FooterNavBar(),
    );
  }

  Future<Map> getPeopleDetail(Cast cast) async {
     var casturl = TMDB_BASE_URL +
        'person/${widget.cast.id}?api_key=' +
        TMDB_APIKEY;

    var castresdata = await http.get(casturl);
    var castdecodedJson = jsonDecode(castresdata.body);
    People peopleInfo = People.fromJson(castdecodedJson);
    Map result =new Map();
    result['people']=peopleInfo;
    return result;
  }
}
