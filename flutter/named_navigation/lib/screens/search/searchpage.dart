import 'package:flutter/material.dart';
import 'package:named_navigation/appcostat.dart';
import 'package:named_navigation/common/uicomponent/header.dart';

class SearchPage extends StatefulWidget {
  static const PATH = 'searchpage';
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  double height;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: MyAppHeader.getHeader('Search'),
      backgroundColor: Color(APP_BODY_COLOR),
      body: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              hintStyle: TextStyle(fontSize: 15.0, color: Colors.white),
              enabledBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.white)),
              focusedBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.white)),
              hintText: 'Search a movie',
              suffixIcon: Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ),
          ShaderMask(
            shaderCallback: (rect) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black, Colors.transparent],
              ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
            },
            blendMode: BlendMode.dstIn,
            child: Image.network(
              'http://image.tmdb.org/t/p/h632/hNgmDBICnD8La2QN1Pkflh5NJqJ.jpg',
            ),
          )
        ],
      ),
    );
  }
}
