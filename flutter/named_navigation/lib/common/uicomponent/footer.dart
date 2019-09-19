import 'package:flutter/material.dart';
import 'package:named_navigation/appcostat.dart';
import 'package:named_navigation/screens/home/home.dart';
import 'package:named_navigation/screens/search/searchpage.dart';

class FooterNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container (
      color: Colors.black45,
      height: 75,
      child:ButtonBar(
        alignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.home, color: Colors.white,),
            onPressed: () {
              Navigator.pushNamed(context, HomePage.PATH);
              print('home');
            },
          ),
          IconButton(
            icon: Icon(Icons.search, color: Colors.white,),
            onPressed: () {
              Navigator.pushNamed(context,SearchPage.PATH);
              print('search');
            },
          ),
          IconButton(
            icon: Icon(Icons.file_download, color: Colors.white,),
            onPressed: () {
              Navigator.pushNamed(context, DOWLOAD_LIST);
              print('download');
            },
          ),
          IconButton(
            icon: Icon(Icons.playlist_add, color: Colors.white,),
            onPressed: () {
              Navigator.pushNamed(context, WATCH_LIST);
              print('watchlist');
            },
          ),
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white,),
            onPressed: () {
              Navigator.pushNamed(context, SETTING);
              print('settings');
            },
          ),
        ],
      ));
  }
}