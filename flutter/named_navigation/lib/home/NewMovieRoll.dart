import 'package:flutter/material.dart';
import 'package:named_navigation/appcostat.dart';
import 'package:transparent_image/transparent_image.dart';

class  NewMovieRoll extends StatelessWidget {
  List items = [
    {
      'imageUrl':
          'https://image.tmdb.org/t/p/w500/4mFsNQwbD0F237Tx7gAPotd0nbJ.jpg',
      'movieName': 'The Intouchable',
      'caption': 'wdfafasd'
    },
    {
      'imageUrl':
          'https://image.tmdb.org/t/p/original/ljYxG86WlLkYmqDsVm4KRBGVzie.jpg',
      'movieName': 'Pulp Fiction ',
      'caption': 'wdfafasd'
    },
    {
      'imageUrl':
          'https://i.pinimg.com/originals/0d/ee/cf/0deecf965f167dfb77ea2c3f93a525d0.jpg',
      'movieName': 'SPIDER-MAN',
      'caption': 'wdfafasd'
    },
    {
      'imageUrl':
          'http://moviereviews.s3.amazonaws.com/2019/01/23/07/57/40/f445b9ca-740d-410b-bbcb-100cedd11a8c/ahCd5YfSgyRXkgUqPl7BwHz5ET2.jpg',
      'movieName': 'Lord of the rings',
      'caption': 'wdfafasd'
    },
    {
      'imageUrl':
          'https://news.chapman.edu/wp-content/uploads/2013/09/poster_1.jpg',
      'movieName': 'Schindlers List',
      'caption': 'wdfafasd'
    }
  ];

  Material MovieCard(String imageUrl, String movieName, String caption,BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          print('card tapped');
          Navigator.pushNamed(context, MOVIE_DETAIL);
        },
        child: Container(
          width: 150.0,
          child: Card(
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Stack(
              children: <Widget>[
                //Image.network(imageUrl),
                faddingImage(imageUrl),
                Align(
                  child: ListTile(
                    title: Text(
                      movieName,
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      caption,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  alignment: Alignment.bottomCenter,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget faddingImage(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: url,
        //height: 300.0,
        fit: BoxFit.fill,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0,horizontal: 5.0),
      child:Column(
      children: <Widget>[
        Align(
          child: Text(
            'New Arrival',
            style: Theme.of(context).textTheme.headline,
          ),
          alignment: Alignment.topLeft,
        ),
        Container(
          height: 220.0,
          child: ListView.builder(
            itemCount: items.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, position) {
              final item = items[position];
              return MovieCard(
                  item['imageUrl'], item['movieName'], item['caption'],  context);
            },
          ),
        )
      ],
    ));
  }
}
