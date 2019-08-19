import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:transparent_image/transparent_image.dart';

class CarouselWithIndicator extends StatefulWidget {
  final List<CarouselModel> trendingMoviesList;
  final Function carouselAction;

  CarouselWithIndicator({@required this.trendingMoviesList, this.carouselAction});

  @override
  _CarouselWithIndicatorState createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CarouselSlider(
          viewportFraction: 1.0,
          height: 225.0,
          autoPlay: true,
          autoPlayAnimationDuration:  Duration(milliseconds: 2000) ,
          autoPlayInterval: Duration(seconds: 6),
          items: widget.trendingMoviesList.map((item) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: item.imagePath,
                      fit: BoxFit.fill,
                    ));
              },
            );
          }).toList(),
          onPageChanged: (index) {
            setState(() {
              _current = index;
            });
          },
        ),
          Positioned(
           top: 10.0,
          left: 5.0,
          right: 0.0,
          child: Text(widget.trendingMoviesList[_current].title, style: Theme.of(context).textTheme.display1,)
        ),
        Positioned(
          top: 200.0,
          left: 0.0,
          right: 0.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.trendingMoviesList.map((item) {
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.trendingMoviesList[_current] == item
                        ? Colors.white
                        : Colors.grey),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}

class CarouselModel{
  String imagePath;
  String title;
}