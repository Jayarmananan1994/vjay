import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:transparent_image/transparent_image.dart';

class CarouselWithIndicator extends StatefulWidget {
  final List<CarouselModel> trendingMoviesList;
  final Function carouselAction;

  CarouselWithIndicator(
      {@required this.trendingMoviesList, this.carouselAction});

  @override
  _CarouselWithIndicatorState createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    var result = (widget.trendingMoviesList.length == 1 &&
            widget.trendingMoviesList[0].imagePath == '')
        ? transparentContainer()
        : Stack(
            children: <Widget>[
              CarouselSlider(
                viewportFraction: 1.0,
                height: 230.0,
                autoPlay: true,
                autoPlayAnimationDuration: Duration(milliseconds: 2000),
                autoPlayInterval: Duration(seconds: 6),
                items: widget.trendingMoviesList.map((item) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                             height: 225.0,
                           // decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
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
                  child: Text(
                    widget.trendingMoviesList[_current].title,
                    style: Theme.of(context).textTheme.display1,
                  )),
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
                      margin:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
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
    return result;
  }

  Container transparentContainer() {
    return Container(
        height: 220.0,
        //decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
        child: Image.memory(kTransparentImage)
        );
  }
}

class CarouselModel {
  String imagePath;
  String title;
}
