import 'package:flutter/material.dart';

class MyAppHeader {
  static Widget getHeader(String pageTitle) {
    return AppBar(
      title: Text(
        pageTitle,
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.black45, //Color(0xff212121),
      automaticallyImplyLeading: false,
      centerTitle: true,
    );
  }

  static Widget getTabHeader(String pageTitle) {
    return AppBar(
      bottom: TabBar(
        tabs: <Widget>[
          Tab(text: 'Home'),
          Tab(text: 'TV Shows'),
          Tab(text: 'Movies'),
          Tab(text: 'Kids'),
        ],
        indicatorColor: Colors.white,
      ),
      title: Text(
        pageTitle,
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.black45, //Color(0xff212121),
      automaticallyImplyLeading: false,
      centerTitle: true,

    );
  }
  
  static Widget getMovieDetailTab(){
    return AppBar(
      bottom: TabBar(
        tabs: <Widget>[
          Tab(text: 'Home'),
          Tab(text: 'TV Shows'),
        ],
        indicatorColor: Colors.white,
      ),
      backgroundColor: Colors.black45, //Color(0xff212121),
      automaticallyImplyLeading: false,
      centerTitle: true,

    );
  }
}
