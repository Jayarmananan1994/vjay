import 'package:flutter/material.dart';
import 'package:named_navigation/common/service_locator.dart';
import 'package:named_navigation/common/uicomponent/footer.dart';
import 'package:named_navigation/model/mymdb_movie.dart';
import 'package:named_navigation/model/peopledetails.dart';
import 'package:named_navigation/service/movieservice/movie_service.dart';
import 'package:transparent_image/transparent_image.dart';

class PeopleInfo extends StatefulWidget {
  static const String PATH = 'PeopleInfo';
  final MyMDBCast cast;
  PeopleInfo({@required this.cast});

  @override
  _PeopleInfoState createState() => _PeopleInfoState();
}

class _PeopleInfoState extends State<PeopleInfo> {
  MovieService service = locator<MovieService>();

  double height;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: peopeOtherDetail(),
      bottomNavigationBar: FooterNavBar(),
    );
  }

  get initialDisplay => () {
        return Stack(
            alignment: Alignment.topRight,
            children: <Widget>[castPoster(), faddinBox(),]);
  };
  get castPoster => () {
        return SizedBox(
            width: double.infinity,
            height: height * 0.7,
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.white54,
                  blurRadius: 25.0,
                  spreadRadius: 5.0,
                )
              ]),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: widget.cast.profilePathLarge,
                  fit: BoxFit.fill,
                ),
              ),
            ));
      };

  get faddinBox => () {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xff263238), Color(0xff263238).withOpacity(0.4)],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: [0, 0.5],
                tileMode: TileMode.mirror),
          ),
        );
      };

  get artistTitle => (items) {
        return Positioned(
          top: height * 0.6,
          left: 20,
          right: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: items,
          ),
        );
      };

  get peopeOtherDetail => () {
        return FutureBuilder(
          future: service.getPeopleDetail(widget.cast.id),
          builder: (BuildContext context, AsyncSnapshot snapShot) {
            PeopleDetails peopleDetails = snapShot.data;
            return initialDisplay();
          },
        );
      };

  get artistDesc => (String overview) {
        return Padding(
          child: RichText(
            textAlign: TextAlign.left,
            softWrap: true,
            text: TextSpan(
                text: overview, style: Theme.of(context).textTheme.body1),
          ),
          padding: EdgeInsets.symmetric(vertical: 15),
        );
      };
}